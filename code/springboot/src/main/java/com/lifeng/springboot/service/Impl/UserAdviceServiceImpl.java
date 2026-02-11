package com.lifeng.springboot.service.Impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.UserAdvice;
import com.lifeng.springboot.mapper.UserAdviceMapper;
import com.lifeng.springboot.service.UserAdviceService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author: lifeng
 * @description:
 **/
@Service("userAdviceService")
public class UserAdviceServiceImpl implements UserAdviceService {
    @Resource
    private UserAdviceMapper userAdviceMapper;
    @Override
    public int addAdvice(UserAdvice userAdvice) {
        int row = userAdviceMapper.insert(userAdvice);
        return row;

    }

    @Override
    public Page<UserAdvice> getAdvice(Integer pageNum, Integer pageSize, String search) {
        // 根据页码和页大小获取建议
        Page<UserAdvice> page = new Page<>(pageNum,pageSize);
        LambdaQueryWrapper<UserAdvice> wrapper = Wrappers.lambdaQuery();
        // 添加搜索词
        if (StrUtil.isNotEmpty(search))
            wrapper.like(UserAdvice::getUsername,search);
        Page<UserAdvice> result = userAdviceMapper.selectPage(page, wrapper);
        return result;

    }

    @Override
    public int deleteAdvice(Integer id) {
        int row = userAdviceMapper.deleteById(id);
        return row;
    }
}
