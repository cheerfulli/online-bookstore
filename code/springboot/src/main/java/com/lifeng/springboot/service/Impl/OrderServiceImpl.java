package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.Order;
import com.lifeng.springboot.mapper.OrderMapper;
import com.lifeng.springboot.service.OrderService;
import com.lifeng.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service("orderService")
public class OrderServiceImpl implements OrderService {
    @Resource
    OrderMapper orderMapper;
    @Override
    public void save(Order order) {
        orderMapper.insert(order);
    }

    @Override
    public void update(Order order) {
        orderMapper.updateById(order);
    }

    @Override
    public void delete(Long id) {
        orderMapper.deleteById(id);
    }

    @Override
    public Order getById(Long id) {
        return orderMapper.selectById(id);
    }

    @Override
    public Page<Order> findPage(Integer pageNum, Integer pageSize, String search) {
        //新建分页对象
        Page<Order> page = new Page<>(pageNum, pageSize);
        //新建模糊查询对象,这里有个注意事项，你模糊项查询的对应项不能为null，为null就查不出来
        //LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery().like(User::getUsername, search);
        LambdaQueryWrapper<Order> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.orderByDesc(Order::getCreateTime);
        if (!search.equals(""))
            queryWrapper.like(Order::getOrderName,search);
        Page<Order> userPage = orderMapper.selectPage(page, queryWrapper);
        return userPage;
    }

    @Override
    public Page<Order> findUserOrder(Integer pageNum, Integer pageSize, String search, Integer state) {
        // 从 token 获取 userID
        String userId = TokenUtils.getCurrUser();
        //新建分页对象
        Page<Order> page = new Page<>(pageNum, pageSize);
        //新建模糊查询对象,这里有个注意事项，你模糊项查询的对应项不能为null，为null就查不出来
        //LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery().like(User::getUsername, search);
        LambdaQueryWrapper<Order> queryWrapper = Wrappers.lambdaQuery();
        // 给查询对象加上ID限制和日期降序
        queryWrapper.eq(Order::getUserId,userId);
        if (state == 2)
            queryWrapper.orderByDesc(Order::getCreateTime);
        else
            queryWrapper.orderByDesc(Order::getPaymentTime);
        // 不为空就给查询对象加上搜索限制,例如是否查询未支付订单，或者模糊搜索
        if (state != 0)
            queryWrapper.eq(Order::getState,state);
        if (!search.equals(""))
            queryWrapper.like(Order::getOrderName,search);
        Page<Order> userPage = orderMapper.selectPage(page, queryWrapper);
        return userPage;
    }

    @Override
    public List<Order> findOrderByNo(String orderNo) {
        LambdaQueryWrapper<Order> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(Order::getOrderNo,orderNo);
        List<Order> orders = orderMapper.selectList(wrapper);
        return orders;
    }

    @Override
    public int deleteByOrderNo(String orderNo) {
        return orderMapper.deleteByOrderNo(orderNo);
    }

    @Override
    public List<Order> getPayList() {
        LambdaQueryWrapper<Order> wrapper = Wrappers.<Order>lambdaQuery().isNotNull(Order::getPaymentTime);
        List<Order> orders = orderMapper.selectList(wrapper);
        return orders;
    }

    @Override
    public int updateStateWithoutDate(Integer id,int status) {
        return orderMapper.updateStateWithoutDate(id,status);
    }

    @Override
    public int updateReceiptState(Integer id, String now) {
        return orderMapper.updateReceiptState(id,now);
    }

}
