package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.UserAdvice;

public interface UserAdviceService {

    public int addAdvice(UserAdvice userAdvice);

    public Page<UserAdvice> getAdvice(Integer pageNum, Integer pageSize, String search);

    public int deleteAdvice(Integer id);
}
