package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.User;

public interface UserService {

    public User selectOne(User user);

    void save(User user);

    void update(User user);

    void delete(Long id);
    Page<User> selectPage(Integer pageNum, Integer pageSize, String search);

    User findById(Integer userId);
}
