package com.hznu.utils;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

/**
 * 工具类：创建SQLSession对象
 */
public class MybatisUtils {
    static final String CONFIG_FILE = "mybatis-config.xml";
    static SqlSessionFactory factory;

    //初始化工厂类
    static {
        try {
            InputStream resourceAsStream = Resources.getResourceAsStream(CONFIG_FILE);
            factory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static SqlSession getSqlSession() {
        SqlSession session = null;
        if (session == null) {
            session = factory.openSession();
        }
        return session;
    }

    public static SqlSession getSqlSession(boolean autoCommit) {
        SqlSession session = null;
        if (session == null) {
            session = factory.openSession(autoCommit);
        }
        return session;
    }
}
