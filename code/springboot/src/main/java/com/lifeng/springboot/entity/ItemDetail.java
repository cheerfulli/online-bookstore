package com.lifeng.springboot.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

@TableName("item_detail")
@Data
public class ItemDetail {
    @TableId()
    private Long itemId;
    private String itemDetail;
    private Date createTime;
    private Date updateTime;
}
