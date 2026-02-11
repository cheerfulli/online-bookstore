package com.lifeng.springboot.controller.dto;

import lombok.Data;

@Data
public class AliPay {
    //    调用的数据类，前端传回订单的标题、订单编号、订单的总金额，再通过后端调用支付宝的SDK实现支付
    private String subject;
    private String traceNo;
    private String totalAmount;
}
