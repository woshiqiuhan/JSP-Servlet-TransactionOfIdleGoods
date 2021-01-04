package com.hznu.dao;

import com.hznu.domain.UserBrowseHistory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserBrowseHistoryDao {

    List<UserBrowseHistory> selectAllFromUserBrowseHistory();

    int insertNewUserBrowseHistory(UserBrowseHistory userBrowseHistory);

    int selectCountById(@Param("userId") String userId, @Param("goodsId") String goodsId);

    int selectCountByUserId(@Param("userId") String userId);

    int selectCountCollectByUserId(@Param("userId") String userId);

    int updateBrowseTime(@Param("userId") String userId, @Param("goodsId") String goodsId);

    int selectHistoryStatus(@Param("userId") String userId, @Param("goodsId") String goodsId);

    int deleteUserColleted(@Param("userId") String userId, @Param("goodsId") String goodsId);
}
