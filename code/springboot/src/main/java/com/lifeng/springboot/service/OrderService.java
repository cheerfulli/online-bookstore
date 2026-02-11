package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.Order;

import java.util.List;

public interface OrderService {

    void save(Order order);
    void update(Order order);
    void delete(Long id);
    Order getById(Long id);
    Page<Order> findPage(Integer pageNum,Integer pageSize, String search);

    Page<Order> findUserOrder(Integer pageNum,Integer pageSize,String search,Integer state);
    List<Order> findOrderByNo(String orderNo);
    int deleteByOrderNo(String orderNo);
    List<Order> getPayList();
    int updateStateWithoutDate(Integer id,int status);
    int updateReceiptState(Integer id,String now);
}
