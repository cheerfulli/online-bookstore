package com.lifeng.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lifeng.springboot.entity.Order;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

public interface OrderMapper extends BaseMapper<Order> {

    @Update("update t_order set state = #{state},payment_time=#{payTime} where order_no=#{tradeNo}")
    int updateState(@Param("tradeNo") String tradeNo,@Param("state") int state,@Param("payTime") String payTime);

    // todo 将退款订单的状态改成已退款，这里其实可以更新结束时间了，以后在写
    @Update("update t_order set state = 3 where id = #{orderId}")
    int updateRefundState(@Param("orderId") int orderId);

    @Update("update t_order set state = #{state} where id=#{id}")
    int updateStateWithoutDate(@Param("id") int id,@Param("state") int state);

    @Update("update t_order set state = 5,end_time = #{endTime} where id=#{id}")
    int updateReceiptState(@Param("id") Integer id,@Param("endTime") String endTime);

    @Delete("delete from t_order where order_no = #{orderNo}")
    int deleteByOrderNo(@Param("orderNo") String orderNo);
}
