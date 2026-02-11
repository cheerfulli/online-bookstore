package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.Item;
import org.springframework.web.bind.annotation.*;

import java.util.List;

public interface ItemService {

    public List<Item> getAll(@RequestParam(defaultValue = "") String search);


    void insert(Item item);

    public void update(Item item);


    public void delete(Long id);


    public Page<Item> findPage(Integer pageNum, Integer pageSize, String search);

    public Item findById(Long id);


    public List<Item> findByCid(Integer cid);

    int updateStock(Long id,Integer count);
}
