package com.lifeng.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.controller.dto.CartDTO;
import com.lifeng.springboot.entity.Cart;

import java.util.List;

public interface CartService {
    void save(Cart cart);

    Page<Cart> getCarts(Integer pageNum, Integer pageSize, String search);

    void deleteById(Integer id);

    List<CartDTO> getMyCart(Integer userId);
}
