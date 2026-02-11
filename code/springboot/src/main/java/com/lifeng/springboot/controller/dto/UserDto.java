package com.lifeng.springboot.controller.dto;

import com.lifeng.springboot.entity.User;
import lombok.Data;

// User的 Data Transfer Object 数据传输转换对象
@Data
public class UserDto {
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
    private String token;

    public UserDto(User user, String token) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.password = user.getPassword();
        this.nickName = user.getNickName();
        this.age = user.getAge();
        this.avatar = user.getAvatar();
        this.sex = user.getSex();
        this.address = user.getAddress();
        this.role = user.getRole();
        this.token = token;
    }
}
