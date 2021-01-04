package com.hznu.dao;

import com.hznu.domain.UserDeliveryInformation;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDeliveryInformationDao {

    List<UserDeliveryInformation> selectAllFromDeliveryInformation();

    List<UserDeliveryInformation> selectFromDeliveryInformationByUserId(@Param("userId") String userId);

    int insertIntoDeliveryInformation(UserDeliveryInformation deliveryInformation);

    UserDeliveryInformation selectDeliveryInformationById(@Param("deliveryInfoId") String deliveryInfoId);
}
