package com.lifeng.springboot.controller.dto;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @author: lifeng
 * @description:
 **/
@Data
public class ItemDetailDTO {
    private Long id;
    private String title;
    private BigDecimal price;
    private String image;
    private String depict;
}
