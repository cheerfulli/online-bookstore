package com.lifeng.springboot.controller;

import com.lifeng.springboot.controller.dto.ItemDetailDTO;
import com.lifeng.springboot.controller.dto.ItemDto;
import com.lifeng.springboot.common.AuthAccess;
import com.lifeng.springboot.common.Result;
import com.lifeng.springboot.entity.Item;
import com.lifeng.springboot.entity.ItemDetail;
import com.lifeng.springboot.service.ItemDetailService;
import com.lifeng.springboot.service.ItemService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 这里是为了简化开发流程，因为实际开发中其实应该再写一个Service层来调用Mapper层，在Service层里面写逻辑，在Controller层返回信息
 * 这里直接Controller层调用mapper层，并且对数据进行处理，然后返回结果
 *
 * 还有这里的@RestController因为是前后端分离项目，所以后端只用返回json数据就可以了，或者说对象数据。
 * 所以不能用@Controller，它会返回一个视图
 */
@RestController
@RequestMapping("/item")
public class ItemController {

    @Resource
    ItemService itemService;

    @Resource
    ItemDetailService itemDetailService;
    @AuthAccess(message = "安卓id获取图书描述")
    @GetMapping("/app/{id}")
    public Result<?> AppfindById(@PathVariable("id") Long id){
        Item item = itemService.findById(id);
        ItemDetailDTO itemDetailDTO=new ItemDetailDTO();
        itemDetailDTO.setId(item.getId());
        itemDetailDTO.setImage(item.getImage());
        itemDetailDTO.setDepict(item.getSellPoint());
        itemDetailDTO.setTitle(item.getTitle());
        itemDetailDTO.setPrice(item.getPrice());
        return Result.success(itemDetailDTO);
    }
    @AuthAccess(message = "安卓获取轮播图")
    @GetMapping("/app/getBanners")
    public Result<?> getBanners(){
        List<String> banners=new ArrayList<>();
        //随便选了三张图片，有需要后面再改。
        banners.add("https://gd4.alicdn.com/imgextra/i2/2214800833667/O1CN01fZqqu01cxXBS0ghhs_!!2214800833667.jpg_400x400.jpg");
        banners.add("https://gd1.alicdn.com/imgextra/i1/2214800833667/O1CN01TKrNN51cxXBZaNxA4_!!2214800833667.jpg");
        banners.add("https://gd2.alicdn.com/imgextra/i3/368976905/O1CN01Bmrztb20sXdfYmxzi_!!368976905.jpg_400x400.jpg");
        return Result.success(banners);
    }

    @AuthAccess(message = "安卓获取图书")
    @GetMapping("/app/getItem")
    public Result<?> getItem(@RequestParam(defaultValue = "") String search){
        List<Item> all = itemService.getAll(search);
        List<ItemDto> list=new ArrayList<>();
        for(Item item:all){
            ItemDto itemDto=new ItemDto();
            itemDto.setId(item.getId());
            itemDto.setImage(item.getImage());
            itemDto.setTitle(item.getTitle());
            itemDto.setPrice(item.getPrice());
            list.add(itemDto);
        }
        return Result.success(list);
    }
    // 写一个查询所有的接口
    @GetMapping("/getAll")
    public Result<?> getAll(@RequestParam(defaultValue = "") String search){
        return Result.success(itemService.getAll(search));
    }


    //    新增方法，这里新增了商品之后要对应新增一个空白的商品详情
    //    @CrossOrigin
    //    后端设置跨域，没试过，不知道行不行，感觉其实不能在后端设置跨域，不然接口就暴露了
    @PostMapping
    public Result<?> save(@RequestBody Item item){
        Date currDate = new Date();
        item.setCreated(currDate);
        itemService.insert(item);
        // 新增空白的商品详情
        ItemDetail itemDetail = new ItemDetail();
        itemDetail.setItemId(item.getId());
        itemDetail.setItemDetail("<p></p>");
        itemDetail.setCreateTime(currDate);
        itemDetailService.save(itemDetail);
        return Result.success();
    }


    @PutMapping
    //    更新信息
    public Result<?> update(@RequestBody Item item){
        itemService.update(item);
        return Result.success();
    }

    @DeleteMapping
    //    删除信息
    public Result<?> delete(@RequestParam Long id){
        itemService.delete(id);
        return Result.success();
    }

    /**
     * 前后端的字段名不一定要一样，可以在前端传入数据的时候设置一下就可以了，只是比较麻烦，所以一般将实体的设置成一样
     * 请求分页数据,请求全部商品
     * @param pageNum 当前页码
     * @param pageSize 每一页显示多少个数据
     * @param search 模糊搜索的关键词
     * @return 返回一个封装好的res
     */
    @AuthAccess
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String search) {
        return Result.success(itemService.findPage(pageNum,pageSize,search));
    }

    @AuthAccess
    @GetMapping("/one")
    public Result<?> findById(@RequestParam Long id){
        return Result.success(itemService.findById(id));
    }

    /**
     * 根据 cid 来查询不同分类的商品
     * @param cid 商品分类
     */
    @AuthAccess
    @GetMapping("/category")
    public Result<?> findByCid(@RequestParam Integer cid){
        return Result.success(itemService.findByCid(cid));
    }
}