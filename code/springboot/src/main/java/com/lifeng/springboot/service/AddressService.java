package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.Address;

public interface AddressService {
    public Page<Address> getPage(Integer pageNum, Integer pageSize, Integer userId);
    public boolean add(Address address);
    public boolean delete(Integer id);
    public boolean deleteByPath(Integer id);
    public boolean update(Address address);
    public Address getOne(Integer id);
}
