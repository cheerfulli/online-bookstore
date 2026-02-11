package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;


@TableName("address")
@Data
public class Address {
    // 如果 address 类没有 id 可以自动补充 id
    @TableId(type = IdType.AUTO)
    private Integer id;

    private Integer userId;

    private String addName;

    private String phone;

    private String address;

    private String addDetail;
}
