package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.User;
import com.lifeng.springboot.mapper.UserMapper;
import com.lifeng.springboot.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("userService")
public class UserServiceImpl implements UserService {

    @Resource
    UserMapper userMapper;
    @Override
    public User selectOne(User user) {
        return userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername,user.getUsername()));
    }

    @Override
    public void save(User user) {
        userMapper.insert(user);
    }

    @Override
    public void update(User user) {
        userMapper.updateById(user);
    }

    @Override
    public void delete(Long id) {
        userMapper.deleteById(id);
    }

    @Override
    public Page<User> selectPage(Integer pageNum, Integer pageSize, String search) {
        //新建分页对象
        Page<User> page = new Page<>(pageNum, pageSize);
        //新建模糊查询对象,这里有个注意事项，你模糊项查询的对应项不能为null，为null就查不出来
        //LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery().like(User::getUsername, search);
        LambdaQueryWrapper<User> queryWrapper = Wrappers.lambdaQuery();
        if (!search.equals(""))
            queryWrapper.like(User::getUsername,search);
        Page<User> userPage = userMapper.selectPage(page, queryWrapper);
        return userPage;
    }

    @Override
    public User findById(Integer userId) {
        return userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getId, userId));
    }
}
