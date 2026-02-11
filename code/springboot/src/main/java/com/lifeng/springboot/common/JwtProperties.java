package com.lifeng.springboot.common;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @author: lifeng
 * @description:
 **/
@Component
@ConfigurationProperties(prefix = "book.jwt")
@Data
public class JwtProperties {

    /**
     * web生成jwt令牌相关配置
     */
    private String secretKey;
    private long ttl;
    private String tokenName;


}

