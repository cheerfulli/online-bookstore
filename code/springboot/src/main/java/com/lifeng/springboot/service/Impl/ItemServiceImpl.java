package com.lifeng.springboot.service.Impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lifeng.springboot.entity.Item;
import com.lifeng.springboot.mapper.ItemMapper;
import com.lifeng.springboot.service.ItemService;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@Service("itemService")
public class ItemServiceImpl implements ItemService {
    @Resource
    ItemMapper itemMapper;
    @Override
    public List<Item> getAll(String search) {
        LambdaQueryWrapper<Item> wrapper = Wrappers.lambdaQuery();
        wrapper.orderByDesc(Item::getCreated);
        if (!Strings.isBlank(search))
            wrapper.like(Item::getTitle,search);
        List<Item> items = itemMapper.selectList(wrapper);
        return items;

    }

    @Override
    public void insert(Item item) {
        itemMapper.insert(item);
    }


    @Override
    public void update(Item item) {
        item.setUpdated(new Date());
        itemMapper.updateById(item);

    }

    @Override
    public void delete(Long id) {
        itemMapper.deleteById(id);

    }

    @Override
    public Page<Item> findPage(Integer pageNum, Integer pageSize, String search) {
        //新建分页对象
        Page<Item> page = new Page<>(pageNum, pageSize);
        //新建模糊查询对象,这里有个注意事项，你模糊项查询的对应项不能为null，为null就查不出来
        //LambdaQueryWrapper<User> queryWrapper = Wrappers.<User>lambdaQuery().like(User::getUsername, search);
        LambdaQueryWrapper<Item> queryWrapper = Wrappers.lambdaQuery();
        // 根据更新日期降序排列
        queryWrapper.orderByDesc(Item::getCreated);
        if (!search.equals(""))
            queryWrapper.like(Item::getSellPoint,search);
        Page<Item> itemPage = itemMapper.selectPage(page, queryWrapper);
        return itemPage;
    }

    @Override
    public Item findById(Long id) {
        //找到ID相同的商品
        Item item = itemMapper.selectOne(Wrappers.<Item>lambdaQuery().eq(Item::getId, id));
        return item;
    }

    @Override
    public List<Item> findByCid(Integer cid) {
        LambdaQueryWrapper<Item> wrapper = Wrappers.<Item>lambdaQuery().eq(Item::getCid, cid);
        List<Item> items = itemMapper.selectList(wrapper);
        return items;
    }

    @Override
    public int updateStock(Long id, Integer count) {
        return itemMapper.updateStock(id,count);
    }
}
