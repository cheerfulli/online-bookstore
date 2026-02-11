package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.RefundOrder;
import com.lifeng.springboot.mapper.RefundOrderMapper;
import com.lifeng.springboot.service.RefundOrderService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author: lifeng
 * @description:
 **/
@Service("refundOrderService")
public class RefundOrderServiceImpl implements RefundOrderService {
    @Resource
    private RefundOrderMapper refundOrderMapper;
    @Override
    public Page<RefundOrder> getAll(Integer pageNum, Integer pageSize, String search) {
        // 新建分页插件
        Page<RefundOrder> page = new Page<>(pageNum,pageSize);
        // 新建模糊 wrapper
        LambdaQueryWrapper<RefundOrder> wrapper = Wrappers.lambdaQuery();
        // 排序
        wrapper.orderByDesc(RefundOrder::getId);
        if (!Strings.isEmpty(search))
            wrapper.like(RefundOrder::getUsername,search);
        // 开始查询
        Page<RefundOrder> refundOrders = refundOrderMapper.selectPage(page, wrapper);
        return refundOrders;
    }

    @Override
    public void deleteOne(Integer id) {
        refundOrderMapper.deleteById(id);
    }
}
