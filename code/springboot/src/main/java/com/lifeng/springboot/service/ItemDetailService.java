package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.ItemDetail;

public interface ItemDetailService {
    void save(ItemDetail item);

    void update(ItemDetail item);

    void delete(Long id);

    ItemDetail findById(Long id);

    Page<ItemDetail> getAll(Integer pageNum, Integer pageSize, String search);
}
