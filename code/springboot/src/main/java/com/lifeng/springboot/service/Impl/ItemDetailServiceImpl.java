package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.ItemDetail;
import com.lifeng.springboot.mapper.ItemDetailMapper;
import com.lifeng.springboot.service.ItemDetailService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;

@Service("itemDetailService")
public class ItemDetailServiceImpl implements ItemDetailService {

    @Resource
    private ItemDetailMapper itemDetailMapper;

    @Override
    public void save(ItemDetail itemDetail) {
        Date currDate = new Date();
        itemDetail.setCreateTime(currDate);
        itemDetailMapper.insert(itemDetail);
    }

    @Override
    public void update(ItemDetail itemDetail) {
        itemDetail.setUpdateTime(new Date());
        itemDetailMapper.updateById(itemDetail);
    }

    @Override
    public void delete(Long id) {
        itemDetailMapper.deleteById(id);

    }

    @Override
    public ItemDetail findById(Long id) {
        ItemDetail itemDetail = itemDetailMapper.selectById(id);
        return itemDetail;
    }

    /**
     * 前后端的字段名不一定要一样，可以在前端传入数据的时候设置一下就可以了，只是比较麻烦，所以一般将实体的设置成一样
     * 请求分页数据,请求全部商品
     * @param pageNum 当前页码
     * @param pageSize 每一页显示多少个数据
     * @param search 模糊搜索的关键词
     * @return 返回一个封装好的res
     */
    @Override
    public Page<ItemDetail> getAll(Integer pageNum, Integer pageSize, String search) {
        //新建分页对象
        Page<ItemDetail> page = new Page<>(pageNum, pageSize);
        //新建模糊查询对象,这里有个注意事项，你模糊项查询的对应项不能为null，为null就查不出来
        //LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery().like(User::getUsername, search);
        LambdaQueryWrapper<ItemDetail> queryWrapper = Wrappers.lambdaQuery();
        // 根据创建日期降序排列
        queryWrapper.orderByDesc(ItemDetail::getCreateTime);
        if (!search.equals(""))
            queryWrapper.like(ItemDetail::getItemId,search);
        Page<ItemDetail> itemDetailPage = itemDetailMapper.selectPage(page, queryWrapper);
        return itemDetailPage;
    }
}
