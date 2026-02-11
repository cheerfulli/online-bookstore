package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.Address;
import com.lifeng.springboot.mapper.AddressMapper;
import com.lifeng.springboot.service.AddressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author: lifeng
 * @description:
 **/
@Service("addressService")
public class AddressServiceImpl implements AddressService {
    @Resource
    private AddressMapper addressMapper;
    @Override
    public Page<Address> getPage(Integer pageNum, Integer pageSize, Integer userId) {
        Page<Address> page = new Page<>(pageNum,pageSize);
        LambdaQueryWrapper<Address> wrapper = Wrappers.lambdaQuery();
        // 查询当前的 userId
        wrapper.eq(Address::getUserId,userId);
        page = addressMapper.selectPage(page,wrapper);
        return page;
    }

    @Override
    public boolean add(Address address) {
        if (addressMapper.insert(address) == 0)
            return false;
        else
            return true;
    }

    @Override
    public boolean delete(Integer id) {
        if (addressMapper.deleteById(id) == 0)
            return false;
        else
            return true;
    }

    @Override
    public boolean deleteByPath(Integer id) {
        if (addressMapper.deleteById(id) == 0)
            return false;
        else
            return true;
    }

    @Override
    public boolean update(Address address) {
        if (addressMapper.updateById(address) == 0)
            return false;
        else
            return true;
    }

    @Override
    public Address getOne(Integer id) {
        Address address = addressMapper.selectById(id);
        return address;
    }
}
