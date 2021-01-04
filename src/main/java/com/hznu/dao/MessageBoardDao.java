package com.hznu.dao;

import com.hznu.domain.MessageBoard;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageBoardDao {
    MessageBoard selectAllFromMessageBoard();

    List<MessageBoard> selectByGoodsId(@Param("goodsId") String goodsId);

    int insertNewMessageToBoard(MessageBoard messageBoard);

    int updateStatusAfterRemindUser(@Param("goodsId") String goodsId);
}
