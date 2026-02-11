package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("t_order")
public class Order {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private BigDecimal payPrice;
    private Long productId;
    private BigDecimal postFee;
    private Integer count;
    /**
     * 1-已支付，2-未支付，3-已退款，4-已发货，5-已完成
     */
    private Integer state;
    private Date createTime;
    private Date paymentTime;
    private Date endTime;
    private Integer userId;
    private String username;
    private String orderNo;
    private String orderName;
    private String orderPicture;
    private Integer addressId;
}
