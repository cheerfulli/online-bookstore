package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.RefundOrder;

public interface RefundOrderService {


    Page<RefundOrder> getAll(Integer pageNum,Integer pageSize,String search);

    void deleteOne(Integer id);
}
