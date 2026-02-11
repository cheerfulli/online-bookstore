package com.lifeng.springboot.controller;

import com.lifeng.springboot.common.AuthAccess;
import com.lifeng.springboot.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.TimeUnit;

/**
 * @author: lifeng
 * @description:
 **/

@RestController
@RequestMapping("/api/redis")
public class RedisController {
    @Autowired
    private StringRedisTemplate redisTemplate;
    @AuthAccess(message = "redis set")
    @PostMapping("/set")
    public Result<?> set(@RequestParam String key,@RequestParam String value){
        redisTemplate.opsForValue().set(key,value,30, TimeUnit.MINUTES);
        return Result.success("key set");
    }
    @AuthAccess(message = "redis get")
    @GetMapping("/get")
    public Result<?> getKey(@RequestParam String key){
        String value= redisTemplate.opsForValue().get(key);
        return  Result.success(value);

    }
}
