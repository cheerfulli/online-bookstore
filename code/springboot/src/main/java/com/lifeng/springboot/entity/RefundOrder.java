package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("refund_order")
public class RefundOrder {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String orderNo;
    private Long productId;
    private String orderPicture;
    private Integer refundType;
    private String refundReason;
    private String refundDesc;
    // 退款金额
    private BigDecimal refundAmount;
    private Date refundDate;
    private Integer userId;
    private String username;
}
