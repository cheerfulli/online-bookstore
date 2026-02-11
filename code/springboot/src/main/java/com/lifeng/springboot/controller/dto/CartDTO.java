package com.lifeng.springboot.controller.dto;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @author: lifeng
 * @description:
 **/
@Data
public class CartDTO {
    private Integer id;
    private BigDecimal price;
    private String image;
    private String title;
    private Long productId;

}
