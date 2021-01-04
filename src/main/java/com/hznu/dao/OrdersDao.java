package com.hznu.dao;

import com.hznu.domain.Orders;
import com.hznu.domain.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface OrdersDao {
    List<Orders> selectAllFromOrder();

    Orders selectordersById(@Param("orderId") String orderId);

    int insertIntoNewOrder(Orders order);

    int updateOrdersStatus(@Param("orderStatus") Integer orderStatus, @Param("orderId") String orderId, @Param("goodsPrice") Double goodsPrice);

    Orders selectOrdersByUserIdAndGoodsId(@Param("userId") String userId, @Param("goodsId") String goodsId);

    int selectCountByUserId(@Param("userId") String userId);

    Orders selectordersByGoodsId(@Param("goodsId") String goodsId);

    int updateOrdersStatusTo(@Param("orderId") String orderId, @Param("orderStatus") Integer orderStatus);

}
