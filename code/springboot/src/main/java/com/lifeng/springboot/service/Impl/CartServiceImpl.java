package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.controller.dto.CartDTO;
import com.lifeng.springboot.entity.Cart;
import com.lifeng.springboot.mapper.CartMapper;
import com.lifeng.springboot.service.CartService;
import com.lifeng.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author: lifeng
 * @description:
 **/
@Service("cartService")
public class CartServiceImpl implements CartService {
    @Resource
    CartMapper cartMapper;
    @Override
    public void save(Cart cart) {
        cartMapper.insert(cart);
    }

    @Override
    public Page<Cart> getCarts(Integer pageNum, Integer pageSize, String search) {
        // 从 token 获取 userID
        String userId = TokenUtils.getCurrUser();
        //新建分页对象
        Page<Cart> page = new Page<>(pageNum, pageSize);
        //新建模糊查询对象,这里有个注意事项，你模糊项查询的对应项不能为null，为null就查不出来
        //LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery().like(User::getUsername, search);
        LambdaQueryWrapper<Cart> queryWrapper = Wrappers.lambdaQuery();
        // 给查询对象加上ID限制和日期降序
        queryWrapper.eq(Cart::getUserId,userId);
        // 不为空就给查询对象加上搜索限制,例如是否查询未支付订单，或者模糊搜索
        if (!search.equals(""))
            queryWrapper.like(Cart::getCartName,search);
        Page<Cart> userPage = cartMapper.selectPage(page, queryWrapper);
        return userPage;
    }

    @Override
    public void deleteById(Integer id) {
        cartMapper.deleteById(id);
    }

    @Override
    public List<CartDTO> getMyCart(Integer userId) {
        LambdaQueryWrapper<Cart> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(Cart::getUserId,userId);
        List<Cart> carts=cartMapper.selectList(queryWrapper);
        List<CartDTO> list=new ArrayList<>();
        for(Cart cart:carts)
        {
            CartDTO cartDTO=new CartDTO();
            cartDTO.setId(cart.getId());
            cartDTO.setProductId(cart.getProductId());
            cartDTO.setPrice(cart.getPayPrice());
            cartDTO.setTitle(cart.getCartName());
            cartDTO.setImage(cart.getCartPicture());
            list.add(cartDTO);
        }
        return list;
    }
}
