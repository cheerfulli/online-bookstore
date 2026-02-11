package com.lifeng.springboot.controller.dto;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * @author: lifeng
 * @description:
 **/
@Data
public class ItemDto {
    private Long id;
    private String title;
    private BigDecimal price;
    private String image;
}
