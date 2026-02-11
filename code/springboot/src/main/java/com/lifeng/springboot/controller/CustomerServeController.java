package com.lifeng.springboot.controller;

import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.UserAdvice;
import com.lifeng.springboot.service.UserAdviceService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.sql.Timestamp;


@RestController
@RequestMapping("/customerServ")
public class CustomerServeController {
    @Resource
    private UserAdviceService userAdviceService;
    // 用户建议收集
    @PostMapping
    public Result<?> addAdvice(@RequestBody UserAdvice userAdvice){
        // 给建议加上日期
        userAdvice.setCreateTime(new Timestamp(System.currentTimeMillis()));
        int row=userAdviceService.addAdvice(userAdvice);
        if (row == 1)
            return Result.success();
        else
            return Result.error("500","建议插入数据库时发生错误");
    }

    @GetMapping
    public Result<?> getAdvice(@RequestParam(defaultValue = "1") Integer pageNum,
                               @RequestParam(defaultValue = "10") Integer pageSize,
                               @RequestParam(defaultValue = "") String search){
       return Result.success(userAdviceService.getAdvice(pageNum,pageSize,search));
    }

    @DeleteMapping
    public Result<?> deleteAdvice(@RequestParam Integer id){
        int row=userAdviceService.deleteAdvice(id);
        if (row == 1)
            return Result.success();
        else
            return Result.error("400","未删除成功");

    }
}
