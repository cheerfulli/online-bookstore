package com.lifeng.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lifeng.springboot.entity.Item;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;


public interface ItemMapper extends BaseMapper<Item> {
    //  使用数据库的事务隔离机制来防止超卖
    @Update("update item set stock = stock - #{count} where id = #{id} and stock >= #{count}")
    int updateStock(@Param("id") Long productId,@Param("count") int count);
}