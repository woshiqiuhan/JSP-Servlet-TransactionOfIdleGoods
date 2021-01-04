package com.hznu.dao;

import com.hznu.domain.User;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface UserDao {
    Map<Object, Object> selectAllFromUserToMap();

    List<User> selectAllFromUser();

    @Select("select * from user where user_id = #{id}")
    User selectById(@Param("id") String id);

    //插入一条学生数据
    int insertNewUser(User user);

    //注册时判断是否用户登入账号重复
    int selectCountById(@Param("user_login_id") String userLoginId);

    //判断用户账号密码是否正确
    int selectCountByIdAndPwd(@Param("user_login_id") String userLoginId, @Param("user_password") String userPassword);

    //获取用户信息
    User selectUserInfo(@Param("user_login_id") String userLoginId);

    //修改用户信息
    int modifyUserInfo(User user);

    int selectCountByUserIdAndPwd(@Param("user_id") String userLoginId, @Param("user_password") String userPassword);
}
