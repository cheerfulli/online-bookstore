package com.lifeng.springboot.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.lifeng.springboot.mapper.UserMapper;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * @Author: Xia
 * @Date: 2024/4/2  16:27
 */
@Component
public class TokenUtils {
    private static UserMapper staticUserMapper;

    private static final String secretKey = "lifeng";
    @Resource
    private UserMapper userMapper;

    // 生成这个 bean 的前置方法，
    @PostConstruct
    public void setUserService(){
        staticUserMapper = userMapper;
    }


    // 生成 token
    public static String genToken(String userId){
        // 设置 claims 也就是 payload，可以括号里面添加多个参数
        return JWT.create().withAudience(userId)
                // 设置 token 过期时间 24 小时
                .withExpiresAt(DateUtil.offsetHour(new Date(),24))
                // 设置 sign 作为秘钥
                .sign(Algorithm.HMAC256(secretKey));
    }

    // 获取当前登录的用户id
    public static String getCurrUser(){
        try {
            HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
            String token = request.getHeader("Authorization");
            if (StrUtil.isNotEmpty(token)) {
                return JWT.decode(token).getAudience().get(0);
            }
        } catch (Exception e){
            return null;
        }
        return null;
    }
}
