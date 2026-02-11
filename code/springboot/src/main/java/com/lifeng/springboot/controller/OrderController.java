package com.lifeng.springboot.controller;


import cn.hutool.core.lang.Dict;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.Item;
import com.lifeng.springboot.entity.Order;
import com.lifeng.springboot.entity.User;
import com.lifeng.springboot.exception.ServiceException;
import com.lifeng.springboot.service.ItemService;
import com.lifeng.springboot.service.OrderService;
import com.lifeng.springboot.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/order")
public class OrderController {
    @Resource
    OrderService orderService;

    @Resource
    UserService userService;

    @Resource
    ItemService itemService;

    @PostMapping
    public Result<?> save(@RequestBody Order order){
        orderService.save(order);
        return Result.success();
    }

    //更新订单
    @PutMapping
    public Result<?> update(@RequestBody Order order){
        orderService.update(order);
        return Result.success();
    }

    //根据订单ID删除订单
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id){
        orderService.delete(id);
        return Result.success();
    }

    //根据订单ID查询订单
    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id){
        return Result.success(orderService.getById(id));
    }

    //购买商品，新建一个订单，单独购买一个商品
    @GetMapping("/buy")
    public Result<?> buy(@RequestParam Long itemId, @RequestParam Integer userId, @RequestParam Integer count,
                         HttpServletRequest request){
        Item item = itemService.findById(itemId);
        User user = userService.findById(userId);
        String orderNo = IdUtil.getSnowflake().nextIdStr();
        // 先新建未支付订单
        Order order = createOrder(item, user, orderNo,count);
        // 如果是小程序，回传这个订单，进入确认订单页面
        if (StrUtil.isNotEmpty(request.getHeader("source-client"))){
            return Result.success(order);
        }
        // 如果是web端
        else {
            BigDecimal price = item.getPrice().multiply(new BigDecimal(count));
            String payUrl = "http://localhost:9090/alipay/pay?subject=" + item.getTitle() + "&traceNo=" + orderNo + "&totalAmount=" + price;
            return Result.success(payUrl);
        }
    }

    private Order createOrder(Item item, User user, String orderNo, Integer count) {
        Order order = new Order();
        // 设置商品ID
        order.setProductId(item.getId());
        // 获取商品名称
        order.setOrderName(item.getTitle());
        // 设置订单号
        order.setOrderNo(orderNo);
        // 设置订单价格
        order.setPayPrice(item.getPrice());
        // 设置邮费
        order.setPostFee(BigDecimal.ZERO);
        // 设置商品数量
        order.setCount(count);
        // 设置支付状态
        order.setState(2);
        order.setUserId(user.getId());
        order.setUsername(user.getUsername());
        order.setOrderPicture(item.getImage());
        //构建创建时间
        Date currDate = new Date();
        order.setCreateTime(currDate);
        save(order);
        return order;
    }


    /**
     * 查询全部的订单消息
     * @param pageNum 当前的页数
     * @param pageSize 一页的大小
     * @param search 搜索的关键词
     * @return 结果集
     */
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {

        return Result.success(orderService.findPage(pageNum,pageSize,search));
    }

    /**
     * 查询对应用户的订单信息
     * @param pageNum 当前页码
     * @param pageSize 每一页的条数
     * @param search 搜索的商品名称
     * @param state 查询订单的状态类型，0表示全部
     * @return 返回分页好的数据表
     */
    @GetMapping("/user_order")
    public Result<?> findUserOrder(@RequestParam(defaultValue = "1") Integer pageNum,
                                   @RequestParam(defaultValue = "10") Integer pageSize,
                                   @RequestParam(defaultValue = "") String search,
                                   @RequestParam(defaultValue = "0") Integer state) {

        return Result.success(orderService.findUserOrder(pageNum,pageSize,search,state));
    }

    /**
     * 根据传入的订单编号查出该订单购买的商品
     */
    @GetMapping("/selectOrder")
    public Result<?> findOrderByNo(@RequestParam String orderNo){

        return Result.success(orderService.findOrderByNo(orderNo));
    }

    // 小程序端模拟支付接口，直接模拟收到微信回调更新库存等等操作
    @PostMapping("/mockPay")
    public Result<?> mockNotify(@RequestBody List<Order> orders){
        // 获取当前支付时间
        Date payment = new Date();
        // 更新订单状态
        for (Order order : orders) {
            // 先进行库存扣减，如果扣减失败，直接弹出库存不足
            if (itemService.updateStock(order.getProductId(),order.getCount()) <= 0){
                throw new ServiceException("407","您购买的商品中有库存不足的情况");
            }
            // 设置支付时间
            order.setPaymentTime(payment);
            // 设置支付状态
            order.setState(1);
            // 更新订单
            orderService.update(order);
        }
        return Result.success();
    }

    // 发货接口
    @PutMapping("/send/{id}")
    public Result<?> Send(@PathVariable("id") Integer id){
        if (orderService.updateStateWithoutDate(id,4) <= 0)
            throw new ServiceException("400","，发货出错");
        return Result.success();
    }

    // 确定收货接口
    @PutMapping("/receive/{id}")
    public Result<?> receive(@PathVariable Integer id){
        // 创建当前时间
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String now = format.format(new Date());
        // 更新订单状态和结束时间
        if (orderService.updateReceiptState(id,now) <= 0)
            throw new ServiceException("400","，确认收货出错");
        return Result.success();
    }

    // 根据订单编号删除订单接口
    @DeleteMapping("/delete/{orderNo}")
    public Result<?> deleteByOrderNo(@PathVariable String orderNo){
        if (orderService.deleteByOrderNo(orderNo)<= 0)
            throw new ServiceException("400","，删除订单出错");
        return Result.success();
    }

    /**
     * 获取驾驶舱所需要的图表数据
     * @return 图表数据
     */
    @GetMapping("/charts")
    public Result<?> charts() {
        List<Order> orders = orderService.getPayList();
        // 获取下单的日期，并对日期排序
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        List<String> dateList = orders.stream().map(order -> (format.format(order.getPaymentTime())))
                .distinct().sorted(Comparator.naturalOrder()).collect(Collectors.toList());
        List<Dict> lineList = new ArrayList<>();
        // 获取每天下单的金额和
        for (String date : dateList) {
            // 从 orders 里面找到这一天的订单
            BigDecimal sum = orders.stream().filter(order -> format.format(order.getPaymentTime()).equals(date))
                    .map(order -> order.getPayPrice().multiply(new BigDecimal(order.getCount())))
                    .reduce(BigDecimal::add).orElse(BigDecimal.ZERO);
            Dict dict = Dict.create().set("date",date).set("value",sum);
            lineList.add(dict);
        }

        List<Dict> barList = new ArrayList<>();
        // 包装柱状图的数据，每天的订单量
        for (String date : dateList) {
            Integer numbers = orders.stream().filter(order -> format.format(order.getPaymentTime()).equals(date))
                    // 把每个订单映射成 1
                    .map(order -> 1).reduce(Math::addExact).orElse(0);
            Dict dict = Dict.create().set("date",date).set("count",numbers);
            barList.add(dict);
        }

        // todo 饼图的数据根据商品 id 来分类

        Dict res = Dict.create().set("lineData", lineList).set("barData", barList);
        // 包装柱状图数据
        return Result.success(res);
    }
}
