package com.lifeng.springboot.controller;

import cn.hutool.json.JSONObject;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.alipay.api.request.AlipayTradeRefundRequest;
import com.alipay.api.response.AlipayTradeRefundResponse;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.lifeng.springboot.controller.dto.AliPay;
import com.lifeng.springboot.common.AliPayConfig;
import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.Order;
import com.lifeng.springboot.entity.RefundOrder;
import com.lifeng.springboot.mapper.ItemMapper;
import com.lifeng.springboot.mapper.OrderMapper;
import com.lifeng.springboot.mapper.RefundOrderMapper;
import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/alipay")
public class AliPayController {
    public static final String GATEWAY_URL = "https://openapi-sandbox.dl.alipaydev.com/gateway.do";
    public static final String FORMAT = "JSON";
    public static final String CHARSET = "UTF-8";
    // 签名方式
    public static final String SIGN_TYPE = "RSA2";
    @Resource
    private OrderMapper orderMapper;

    @Resource
    private AliPayConfig aliPayConfig;
    @Resource
    private RefundOrderMapper refundOrderMapper;

    @Resource
    private ItemMapper itemMapper;

    /**
     * 订单退款接口
     */
    @PostMapping("/refund")
    public Result<?> refund(@RequestBody RefundOrder refundOrder) throws AlipayApiException {
        // 1. 创建Client，通用SDK提供的Client，负责调用支付宝的API
        AlipayClient alipayClient = new DefaultAlipayClient(GATEWAY_URL,
                aliPayConfig.getAppId(), aliPayConfig.getAppPrivateKey(), FORMAT, CHARSET,
                aliPayConfig.getAlipayPublicKey(), SIGN_TYPE);
        // 2. 创建 Request，设置参数
        AlipayTradeRefundRequest request = new AlipayTradeRefundRequest();
        JSONObject bizContent = new JSONObject();
//        bizContent.set("trade_no", re.getAlipayTraceNo());  // 支付宝回调的订单流水号
        bizContent.set("out_trade_no", refundOrder.getOrderNo());   //  我的订单编号
        bizContent.set("refund_amount", refundOrder.getRefundAmount());  // 订单的总金额
        bizContent.set("refund_reason", refundOrder.getRefundReason());   //  退款原因说明
        // 退款请求号，部分退款必填，需要保证在交易号下唯一
        bizContent.set("out_request_no",refundOrder.getProductId());

        request.setBizContent(bizContent.toString());

        // 3. 执行请求
        AlipayTradeRefundResponse response = alipayClient.execute(request);
        if (response.isSuccess()) {  // 退款成功，isSuccess 为true
            // 4. 更新数据库状态
            // 直接使用订单ID来更改就行
            if (orderMapper.updateRefundState(refundOrder.getId()) >= 0)
                System.out.println("更新退款订单状态成功");
            else
                System.out.println("更新退款订单状态失败");
            // 然后更新退款时间
            refundOrder.setRefundDate(new Date());
            // 然后在退款订单表里面保存退款订单
            refundOrderMapper.insert(refundOrder);
        }
        else
            return Result.error("-1",response.getSubMsg());
        return Result.success(response.getMsg());
    }

    /*
    支付接口，调用发起支付
     */
    @GetMapping("/pay")
    public void pay(AliPay aliPay, HttpServletResponse httpResponse) throws IOException {
        // 1. 创建Client，通用SDK提供的Client，负责调用支付宝的API
        AlipayClient alipayClient = new DefaultAlipayClient(GATEWAY_URL, aliPayConfig.getAppId(),  aliPayConfig.getAppPrivateKey(),
                FORMAT,CHARSET, aliPayConfig.getAlipayPublicKey(),SIGN_TYPE);

        // 2. 创建 Request并设置Request参数
        AlipayTradePagePayRequest request = new AlipayTradePagePayRequest();
        request.setNotifyUrl(aliPayConfig.getNotifyUrl());
        JSONObject bizContent = new JSONObject();
        bizContent.set("out_trade_no",aliPay.getTraceNo());
        bizContent.set("total_amount",aliPay.getTotalAmount());
        bizContent.set("subject",aliPay.getSubject());
        bizContent.set("product_code","FAST_INSTANT_TRADE_PAY");
        request.setBizContent(bizContent.toString());
        // 发送请求
        String form = "";
        try {
            form = alipayClient.pageExecute(request).getBody();
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }
        // 返回服务器
        httpResponse.setContentType("text/html;charset=" + CHARSET);
        httpResponse.getWriter().write(form);
        httpResponse.getWriter().flush();
        httpResponse.getWriter().close();
    }

    /*
    第二个接口是支付成功回调的接口，我们在这个接口可以获取到支付订单的订单编号和支付时间，然后我们可以修改本地订单的支付状态。
     */
    @PostMapping("/notify")
    public String payNotify(HttpServletRequest request) throws Exception {
        if (request.getParameter("trade_status").equals("TRADE_SUCCESS")){
            System.out.println("============支付宝异步回调==========================");

//            从request里面取出返回的参数
            Map<String,String> params = new HashMap<>();
            Map<String,String[]> requestParams = request.getParameterMap();
            for (String name : requestParams.keySet()){
                params.put(name,request.getParameter(name));
            }
            // 获取到订单号
            String tradeNo = params.get("out_trade_no");
            // 获取到支付时间
            String gmtPayment = params.get("gmt_payment");
            // 获取到交易号
            String alipayTradeNo = params.get("trade_no");

            // 支付宝验签
            String sign = params.get("sign");
            String content = AlipaySignature.getSignCheckContentV1(params);
            boolean checkSignature = AlipaySignature.rsa256CheckContent(content,sign,aliPayConfig.getAlipayPublicKey(),CHARSET);
            if (checkSignature){
                //验签通过
                System.out.println("交易名称: " + params.get("subject"));
                System.out.println("交易状态: " + params.get("trade_status"));
                System.out.println("支付宝交易凭证号: " + params.get("trade_no"));
                System.out.println("商户订单号: " + params.get("out_trade_no"));
                System.out.println("交易金额: " + params.get("total_amount"));
                System.out.println("买家在支付宝唯一id: " + params.get("buyer_id"));
                System.out.println("买家付款时间: " + params.get("gmt_payment"));
                System.out.println("买家付款金额: " + params.get("buyer_pay_amount"));

                //更新你的订单状态，这里写一个orderMapper来处理
                orderMapper.updateState(tradeNo,1,gmtPayment);
                // 更新商品的库存，先查出 当前订单的 商品ID 和 购买数量
                LambdaQueryWrapper<Order> wrapper = Wrappers.<Order>lambdaQuery().eq(Order::getOrderNo, tradeNo);
                List<Order> orders = orderMapper.selectList(wrapper);
                // 开始扣减库存
                for (Order order : orders) {
                    // 购买的数量
                    int count = order.getCount();
                    // 购买的商品
                    Long productId = order.getProductId();
                    // 更新商品库存
                    if (itemMapper.updateStock(productId,count) > 0)
                        System.out.println("更新库存成功");
                    else
                        System.out.println("更新库存失败");
                }
            }
            // 验签失败
            else{
                System.out.println("验签失败");
                return "Verification failed";
            }
        }
        return "success";
    }
}
