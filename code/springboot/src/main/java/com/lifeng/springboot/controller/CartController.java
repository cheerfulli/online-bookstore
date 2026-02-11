package com.lifeng.springboot.controller;

import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.StrUtil;
import com.lifeng.springboot.controller.dto.ItDTO;
import com.lifeng.springboot.common.AuthAccess;
import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.Cart;
import com.lifeng.springboot.entity.Item;
import com.lifeng.springboot.entity.Order;
import com.lifeng.springboot.entity.User;
import com.lifeng.springboot.service.CartService;
import com.lifeng.springboot.service.ItemService;
import com.lifeng.springboot.service.OrderService;
import com.lifeng.springboot.service.UserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author: lifeng
 * @description:
 **/
@RestController
@RequestMapping("/cart")
public class CartController {
    @Resource
    OrderService orderService;

    @Resource
    UserService userService;

    @Resource
    ItemService itemService;

    @Resource
    CartService cartService;

    @AuthAccess(message = "安卓添加购物车")
    @PostMapping("/app/add")
    public Result<?> addCart(@RequestBody ItDTO itDTO){
        Item item = itemService.findById(itDTO.getItemId());
        User user = userService.findById(itDTO.getUserId());
        createCart(item,user,1);
        return Result.success();
    }

    @AuthAccess(message = "安卓获取购物车")
    @GetMapping("/app/getCarts/{userId}")
    public Result<?> getCartList(@PathVariable Integer userId) {
        return Result.success(cartService.getMyCart(userId));
    }
    @AuthAccess(message = "安卓删除购物车")
    @DeleteMapping("/app/delete/{id}")
    public Result<?> deleteById(@PathVariable Integer id){
        cartService.deleteById(id);
        return Result.success();
    }

    @PostMapping("/buyCart")
    public Result<?> buyCart(@RequestBody List<Cart> carts,@RequestParam BigDecimal totalPrice,
                             @RequestParam Integer addressId, HttpServletRequest request) {
        // 生成订单号
        String orderNo = IdUtil.getSnowflake().nextIdStr();
        // 如果是 Web 端
        if (StrUtil.isEmpty(request.getHeader("source-client"))) {
            // 生成订单名称
            String orderName = carts.get(0).getCartName() + "等多件商品";
            // 拼接支付URL
            String payUrl = "http://localhost:9090/alipay/pay?subject=" + orderName + "&traceNo=" + orderNo + "&totalAmount=" + totalPrice;
            // 对所以加入购物车的商品进行处理，添加订单号
            for (Cart cart : carts) {
                Order order = new Order();
                // 设置商品ID
                order.setProductId(cart.getProductId());
                // 获取商品名称
                order.setOrderName(cart.getCartName());
                // 设置订单号
                order.setOrderNo(orderNo);
                // 设置订单价格
                order.setPayPrice(cart.getPayPrice());
                // 设置邮费
                order.setPostFee(BigDecimal.ZERO);
                // 设置商品数量
                order.setCount(cart.getCount());
                // 设置支付状态
                order.setState(2);
                order.setUserId(cart.getUserId());
                order.setUsername(cart.getUsername());
                order.setOrderPicture(cart.getCartPicture());
                //构建创建时间
                Date currDate = new Date();
                order.setCreateTime(currDate);
                orderService.save(order);
                //从购物车中删除
                cartService.deleteById(cart.getId());
            }
            // 返回支付URL
            return Result.success(payUrl);
        }
        // 如果是手机端
        else {
            // 对所有加入购物车的商品进行处理，添加订单号，添加地址
//            for (Order order : orders) {
//                order.setOrderNo(orderNo);
//                order.setAddressId(addressId);
//                // 同时也更新商品的选择数量
//                orderMapper.updateById(order);
//            }
            // 回传统一的订单编号
            return Result.success(orderNo);
        }
    }

    /**
     * @param itemId 要加入购物车的物品ID
     * @param userId 用户的ID
     * @return 返回成功消息就可以了
     */
    @GetMapping("/add")
    public Result<?> addToCart(@RequestParam Long itemId,@RequestParam Integer userId,@RequestParam Integer count){
        Item item = itemService.findById(itemId);
        User user = userService.findById(userId);
        createCart(item,user,count);
        return Result.success();
    }
    private Cart createCart(Item item, User user, Integer count) {
        Cart cart = new Cart();
        // 设置商品ID
        cart.setProductId(item.getId());
        // 获取商品名称
        cart.setCartName(item.getTitle());
        // 设置订单价格
        cart.setPayPrice(item.getPrice());
        // 设置邮费
        cart.setPostFee(BigDecimal.ZERO);
        // 设置商品数量
        cart.setCount(count);

        cart.setUserId(user.getId());
        cart.setUsername(user.getUsername());
        cart.setCartPicture(item.getImage());
        cartService.save(cart);
        return cart;
    }

    @GetMapping("/getCarts")
    public Result<?> getCarts(@RequestParam(defaultValue = "1") Integer pageNum,
                                   @RequestParam(defaultValue = "10") Integer pageSize,
                                   @RequestParam(defaultValue = "") String search) {

        return Result.success(cartService.getCarts(pageNum,pageSize,search));
    }
    @PostMapping("/deleteCarts")
    public Result<?> deleteCarts(@RequestBody List<Cart> carts) {
        for (Cart cart:carts) {
            cartService.deleteById(cart.getId());
        }
        return Result.success();
    }

}
