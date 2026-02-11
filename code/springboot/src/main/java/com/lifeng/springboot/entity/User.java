package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@TableName("user")
@Data
public class User {
    //  将数据库的字段和这个属性绑定
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String username;
    private String password;
    //    傻逼 mybatis自动将数据库里面的下划线命名法转换成驼峰命名法
    //    private String nick_name;
    private String nickName;
    private Integer age;
    private String avatar;
    private String sex;
    private String address;
    private int role;
}
