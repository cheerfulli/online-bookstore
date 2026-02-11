package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.sql.Timestamp;


@Data
@TableName("user_advice")
public class UserAdvice {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer userId;
    private String nickName;
    private String username;
    private String title;
    private String content;
    private Timestamp createTime;
}
