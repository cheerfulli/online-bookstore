package com.lifeng.springboot.controller;

import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.Address;
import com.lifeng.springboot.service.AddressService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


@RestController
@RequestMapping("/address")
public class AddressController {

    @Resource
    private AddressService addressService;

    // 通过 userid 来查询所有地址
    @GetMapping
    public Result<?> getPage(@RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize,
                             @RequestParam Integer userId){
        return Result.success(addressService.getPage(pageNum,pageSize,userId));
    }

    // 新增地址
    @PostMapping
    public Result<?> add(@RequestBody Address address){
        if(!addressService.add(address))
            return Result.error("400","新增地址插入失败");
        return Result.success();
    }

    // 删除地址
    @DeleteMapping
    public Result<?> delete(@RequestParam Integer id){
        if(!addressService.delete(id))
            return Result.error("400","删除地址失败");
        return Result.success();
    }

    @DeleteMapping("{id}")
    public Result<?> deleteByPath(@PathVariable Integer id){
        if(!addressService.deleteByPath(id))
            return Result.error("400","删除地址失败");
        return Result.success();
    }

    // 更新地址
    @PutMapping
    public Result<?> update(@RequestBody Address address){
        if(!addressService.update(address))
            return Result.error("400","更新地址失败");
        return Result.success();
    }

    // 获取到单个地址
    @GetMapping("/one")
    public Result<?> getOne(@RequestParam Integer id){
        Address address = addressService.getOne(id);
        if (address != null)
            return  Result.success(address);
        return Result.error("401","请求的地址无效");
    }
}
