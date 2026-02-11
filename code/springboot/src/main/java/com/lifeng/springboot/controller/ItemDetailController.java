package com.lifeng.springboot.controller;

import com.lifeng.springboot.common.AuthAccess;
import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.ItemDetail;
import com.lifeng.springboot.service.ItemDetailService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/itemDetail")
public class ItemDetailController {

    @Resource
    private ItemDetailService itemDetailService;

    /**
     * 通过商品ID取出商品的详情
     * @param id 传入的商品ID
     * @return 返回一个ItemDetail的实体类
     */
    @AuthAccess
    @GetMapping
    public Result<?> findById(@RequestParam Long id){
        return Result.success(itemDetailService.findById(id));
    }

    @GetMapping("/getAll")
    public Result<?> getAll(@RequestParam(defaultValue = "1") Integer pageNum,
                            @RequestParam(defaultValue = "10") Integer pageSize,
                            @RequestParam(defaultValue = "") String search){

        return Result.success(itemDetailService.getAll(pageNum,pageSize,search));
    }

    @DeleteMapping("{id}")
    public Result<?> delete(@PathVariable("id") Long id){
        itemDetailService.delete(id);
        return Result.success();
    }

    @PostMapping
    public Result<?> add(@RequestBody ItemDetail itemDetail){
        itemDetailService.save(itemDetail);
        return Result.success();
    }

    @PutMapping
    public Result<?> update(@RequestBody ItemDetail itemDetail){
        itemDetailService.update(itemDetail);
        return Result.success();
    }
}
