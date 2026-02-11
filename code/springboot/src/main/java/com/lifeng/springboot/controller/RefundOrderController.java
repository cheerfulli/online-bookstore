package com.lifeng.springboot.controller;

import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.service.RefundOrderService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


@RestController
@RequestMapping("/refund")
public class RefundOrderController {
    @Resource
    private RefundOrderService refundOrderService;

    // 查询所有退款订单
    @GetMapping
    public Result<?> getAll(@RequestParam(defaultValue = "1") Integer pageNum,
                            @RequestParam(defaultValue = "10") Integer pageSize,
                            @RequestParam(defaultValue = "") String search){
      ;
        return Result.success(refundOrderService.getAll(pageNum,pageSize,search));
    }

    @DeleteMapping("/{id}")
    public Result<?> deleteOne(@PathVariable("id") Integer id){
        refundOrderService.deleteOne(id);
        return Result.success();
    }
}
