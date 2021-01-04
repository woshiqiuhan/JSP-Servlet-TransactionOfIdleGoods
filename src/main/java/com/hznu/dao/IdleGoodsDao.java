package com.hznu.dao;

import com.hznu.domain.IdleGoods;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IdleGoodsDao {
    List<IdleGoods> selectAllFromIdleGood();

    int insertNewIdleGoods(IdleGoods idleGoods);

    List<IdleGoods> selectIdleGoodsInfo();

    int selectSizeOfIdleGoods();

    int selectSizeOfIdleGoodsByUserId(@Param("userId") String userId);

    // 模糊查询，返回找到的数量
    int selectSizeOfIdleGoodsFuzzy(@Param("words") String words);

    List<IdleGoods> selectIdleGoodsFuzzy(@Param("words") String words);

    IdleGoods selectIdleGoodsInfoById(@Param("goodsId") String goodsId);

    List<IdleGoods> selectIdleGoodsInfoByUserId(@Param("userId") String userId);

    List<IdleGoods> selectUserBrowseHistory(@Param("userId") String userId);

    List<IdleGoods> selectUserCollect(@Param("userId") String userId);

    IdleGoods selectIdleGoodsDetailInfoById(@Param("goodsId") String goodsId);

    int updateIdleGoodsStatus(@Param("goodsStatus") Integer goodsStatus, @Param("goodsId") String goodsId);

    List<IdleGoods> selectOrderIdleGoodsByUserId(@Param("userId") String userId);

    /**
     * 查询已卖出但并未提醒用户已卖出的闲置品
     * */
    List<IdleGoods> selectIdleGoodsSold(@Param("userId") String userId);

    /**
     * 查询被评价但还未提醒用户的闲置品
     */
    List<IdleGoods> selectIdleGoodsRated(@Param("userId") String userId);

    /**
     * 查询已卖出闲置品订单被取消但并未提醒用户已卖出的闲置品
     * */
    List<IdleGoods> selectIdleGoodsOrdersCancel(@Param("userId") String userId);
}
