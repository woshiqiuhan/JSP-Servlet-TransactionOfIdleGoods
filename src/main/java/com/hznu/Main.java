package com.hznu;

import com.hznu.dao.*;
import com.hznu.domain.*;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;


public class Main {
    public static void main(String[] args) throws UnsupportedEncodingException {
        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
            UserDao userDao = sqlSession.getMapper(UserDao.class);
            *//*Map<Object, Object> objectObjectMap = userDao.selectAllFromUserToMap();
            System.out.println(objectObjectMap);*//*

         *//*List<User> users = userDao.selectAllFromUser();
            users.forEach(System.out::println);*//*
            int i = userDao.selectCountById("admin3213");
            System.out.println(i);
        }*/


        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
            UserDao userDao = sqlSession.getMapper(UserDao.class);

            *//*int i = userDao.selectCountByIdAndPwd("15836987765", "1bbd886460827015e5d605ed44252251");
            System.out.println(i);*//*

            User user = userDao.selectUserInfo("23132137765");
            System.out.println(user);
        }*/

        /*System.out.println(MD5Util.getMD5Str("19843563212"));
        System.out.println(MD5Util.getMD5Str("19843563212").equals("e45ac14f5784c0d54c94f5ba783afacc"));*/

        /*Map<String, String> mp = new HashMap<>();

        mp.put("userloginid", "561918489948");
        mp.put("userpassword", "584894894");
        String s = URLEncoder.encode(JSON.toJSONString(mp), "UTF-8");
        System.out.println(s);

        Map<String, String> parse = (Map<String, String>) JSON.parse(s);
        System.out.println(parse.get("userloginid"));*/


        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {

            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
            List<IdleGoods> idleGoods = idleGoodsDao.selectIdleGoodsInfo();
            idleGoods.forEach(System.out::println);

            String goodsDetail = idleGoods.get(0).getGoodsDetail();


            int i = goodsDetail.indexOf("<img src=") + 10;
            int j = goodsDetail.indexOf("\"", i);
            System.out.println(goodsDetail.substring(i, j));

            System.out.println(JSON.toJSONString(idleGoods));
        }*/

        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {

            UserBrowseHistoryDao userBrowseHistoryDao = sqlSession.getMapper(UserBrowseHistoryDao.class);
            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
            *//*List<UserBrowseHistory> userBrowseHistories = userBrowseHistoryDao.selectAllFromUserBrowseHistory();
            userBrowseHistories.forEach(System.out::println);

            int i = userBrowseHistoryDao.selectCountById("u_1607572548188", "ig_1607858568257");
            System.out.println(i);*//*

//            System.out.println(userBrowseHistoryDao.selectHistoryStatus("u_1607572548188", "ig_1607858568257"));

            System.out.println(userBrowseHistoryDao.selectCountCollectByUserId("u_1607498252590"));
            List<IdleGoods> idleGoods = idleGoodsDao.selectUserCollect("u_1607498252590");
            System.out.println(JSON.toJSONString(idleGoods));

        }*/

        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {

            UserDeliveryInformationDao userDeliveryInformationDao = sqlSession.getMapper(UserDeliveryInformationDao.class);
            userDeliveryInformationDao.insertIntoDeliveryInformation(new UserDeliveryInformation("u_1607498252590", "张三sannn", "19843563212", "江西省-上饶市-信州区"));
            List<UserDeliveryInformation> userDeliveryInformations = userDeliveryInformationDao.selectFromDeliveryInformationByUserId("u_1607498252590");

            sqlSession.commit();
            System.out.println(userDeliveryInformations);
        }*/
        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {

            OrdersDao ordersDao = sqlSession.getMapper(OrdersDao.class);
            ordersDao.updateOrdersStatus(40, "od_1608120418621", 5499.00);


            *//*IdleGoodsDao mapper = sqlSession.getMapper(IdleGoodsDao.class);
            List<IdleGoods> idleGoods = mapper.selectOrderIdleGoodsByUserId("u_1608099855916");
            idleGoods.forEach(idleGood -> {
                System.out.println(idleGood.getOrderStatus());
            });*//*
        }*/


        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {

         *//*   MessageBoardDao messageBoardDao = sqlSession.getMapper(MessageBoardDao.class);
            *//**//*int i = messageBoardDao.insertNewMessageToBoard(new MessageBoard("u_1607498252590", "ig_1607865042513", "<p>而我却大所大所大萨达按时的是</p>", 1));
            System.out.println(i);*//**//*

            List<MessageBoard> messageBoards = messageBoardDao.selectByGoodsId("ig_1607873407851");*//*

            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

            List<IdleGoods> idleGoods = idleGoodsDao.selectIdleGoodsRated("u_1607572548188");
            System.out.println(idleGoods.size());
            idleGoods.forEach(System.out::println);
        }*/

        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);

            // 将商品状态更改为4，即用户取消订单但为提醒用户
            int n = idleGoodsDao.updateIdleGoodsStatus(4, "ig_1607858568257");

            if (n == 1) {
                // 更新订单信息
                OrdersDao ordersDao = sqlSession.getMapper(OrdersDao.class);
                int m = ordersDao.updateOrdersStatusTo("ig_1607858568257", 0);
                if (m == 1) { // 订单支付成功
                    // 提交事务
                    sqlSession.commit();
                } else {  // 订单创建失败
                }
            } else {
            }
        }*/

        /*try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
            MessageReplyDao messageReplyDao = sqlSession.getMapper(MessageReplyDao.class);
//            List<MessageReply> messageReplies = messageReplyDao.selectAllFromMessageReply();
            List<MessageReply> messageReplies = messageReplyDao.selectReplyByMessageId("mb_1608289325351");
            messageReplies.forEach(System.out::println);
        }*/

        try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {
            IdleGoodsDao idleGoodsDao = sqlSession.getMapper(IdleGoodsDao.class);
            List<IdleGoods> idleGoods = idleGoodsDao.selectOrderIdleGoodsByUserId("u_1607498252590");
            idleGoods.forEach(System.out::println);
        }
    }
}

