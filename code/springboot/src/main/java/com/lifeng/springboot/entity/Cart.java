package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.math.BigDecimal;
import java.util.Objects;

/**
 * @author: lifeng
 * @description:
 **/
public class Cart {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private BigDecimal payPrice;
    private Long productId;
    private BigDecimal postFee;
    private Integer count;
    private Integer userId;
    private String username;
    private String cartName;
    private String cartPicture;
    private Integer addressId;

    public Cart(Integer id, BigDecimal payPrice, Long productId, BigDecimal postFee, Integer count, Integer userId, String username, String cartName, String cartPicture, Integer addressId) {
        this.id = id;
        this.payPrice = payPrice;
        this.productId = productId;
        this.postFee = postFee;
        this.count = count;
        this.userId = userId;
        this.username = username;
        this.cartName = cartName;
        this.cartPicture = cartPicture;
        this.addressId = addressId;
    }

    public Cart() {
    }

    @Override
    public String toString() {
        return "Cart{" +
                "id=" + id +
                ", payPrice=" + payPrice +
                ", productId=" + productId +
                ", postFee=" + postFee +
                ", count=" + count +
                ", userId=" + userId +
                ", username='" + username + '\'' +
                ", cartName='" + cartName + '\'' +
                ", cartPicture='" + cartPicture + '\'' +
                ", addressId=" + addressId +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Cart cart)) return false;
        return Objects.equals(getId(), cart.getId()) && Objects.equals(getPayPrice(), cart.getPayPrice()) && Objects.equals(getProductId(), cart.getProductId()) && Objects.equals(getPostFee(), cart.getPostFee()) && Objects.equals(getCount(), cart.getCount()) && Objects.equals(getUserId(), cart.getUserId()) && Objects.equals(getUsername(), cart.getUsername()) && Objects.equals(getCartName(), cart.getCartName()) && Objects.equals(getCartPicture(), cart.getCartPicture()) && Objects.equals(getAddressId(), cart.getAddressId());
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getPayPrice(), getProductId(), getPostFee(), getCount(), getUserId(), getUsername(), getCartName(), getCartPicture(), getAddressId());
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public BigDecimal getPayPrice() {
        return payPrice;
    }

    public void setPayPrice(BigDecimal payPrice) {
        this.payPrice = payPrice;
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long productId) {
        this.productId = productId;
    }

    public BigDecimal getPostFee() {
        return postFee;
    }

    public void setPostFee(BigDecimal postFee) {
        this.postFee = postFee;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getCartName() {
        return cartName;
    }

    public void setCartName(String cartName) {
        this.cartName = cartName;
    }

    public String getCartPicture() {
        return cartPicture;
    }

    public void setCartPicture(String cartPicture) {
        this.cartPicture = cartPicture;
    }

    public Integer getAddressId() {
        return addressId;
    }

    public void setAddressId(Integer addressId) {
        this.addressId = addressId;
    }
}
