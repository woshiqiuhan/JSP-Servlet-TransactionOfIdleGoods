package com.hznu.servlet.releaseidle.category;

import com.alibaba.fastjson.JSON;
import com.hznu.dao.CategoryDao;
import com.hznu.domain.Category;
import com.hznu.utils.MybatisUtils;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

/**
 * 获取分类
 */
public class GetCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String rootType = req.getParameter("rootType");

        if (rootType != null && !rootType.isEmpty()) {
            try (SqlSession sqlSession = MybatisUtils.getSqlSession()) {

                CategoryDao categoryDao = sqlSession.getMapper(CategoryDao.class);
                List<Category> categories = categoryDao.selectCategoryByParentCategoryId(rootType);

                try (PrintWriter out = resp.getWriter()) {
                    out.print(JSON.toJSONString(categories));
                    out.flush();
                }
            }
        }
    }
}
