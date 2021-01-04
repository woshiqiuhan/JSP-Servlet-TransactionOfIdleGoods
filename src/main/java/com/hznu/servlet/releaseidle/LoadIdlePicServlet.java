package com.hznu.servlet.releaseidle;

import com.alibaba.fastjson.JSON;
import com.hznu.domain.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 富文本编辑器中上传图片
 */
public class LoadIdlePicServlet extends HttpServlet {
    private static final long serialVersionUID = 7042756416806244618L;

    public static final int UPLOAD_FILE_MAX_SIZE = 5 * 1024 * 1024; // 限定上传文件的大小

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO Auto-generated method stub
        System.out.println("post");

        //解决乱码问题
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        //检测服务器上目的存储目录是否存在，如果不存在则创建
        String fileDir = getServletContext().getRealPath("/assets/upload/images");
        File dirUpload = new File(fileDir);
        if (!dirUpload.exists()) {
            dirUpload.mkdirs();
        }

        fileDir += "/" + user.getUserId();
        dirUpload = new File(fileDir);
        if (!dirUpload.exists()) {
            dirUpload.mkdirs();
        }

        // 指定上传文件的保存地址
        String fileName = null;//文件名

        // 判断是否为上传文件
        int n = 0;
        if (ServletFileUpload.isMultipartContent(req)) {

            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(20 * 1024); // 设置内存中允许存储的字节数
            ServletFileUpload upload = new ServletFileUpload(factory); // 创建新的上传文件句柄

            // 创建保存上传文件的集合对象
            List<FileItem> formlists = null;
            try {
                formlists = (List<FileItem>) upload.parseRequest(req); // 获取上传文件集合
            } catch (FileUploadException e) {
                e.printStackTrace();
            }

            if (formlists != null && formlists.size() > 0) { //当获取文件集合对象成功且集合不为空
                for (FileItem formitem : formlists) {  //遍历表单域
                    if (!formitem.isFormField()) { // 忽略不是上传文件的表单域
                        // 获取上传文件的名称，包括路径
                        String name = new Date().getTime() + ".jpg";

                        // 如果上传文件大于规定的上传文件的大小，直接返回提醒用户
                        if (formitem.getSize() > UPLOAD_FILE_MAX_SIZE) {
                            continue;
                        }

                        String adjunctsize = Long.toString(formitem.getSize()); // 获取上传文件的大小

                        // 如果上传文件为空，查看下一个
                        if ((name == null) || (name.equals("")) && (adjunctsize.equals("0"))) {
                            continue;
                        }

                        //获取文件名
                        fileName = name.substring(name.lastIndexOf("\\") + 1);

                        try {
                            //向服务器写入目的目录文件
                            formitem.write(new File(fileDir + "\\" + fileName)); // 向文件写数据
                            n++;
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }
            }
        }
        String contextPath = req.getContextPath();
        String basePath = req.getScheme() + "://" + req.getServerName() + ":" + req.getServerPort() + contextPath + "/assets/upload/images/" + user.getUserId();

        try (PrintWriter out = resp.getWriter()) {
            Map<String, String> mp = new HashMap<>();

            mp.put("result", n + "");
            mp.put("url", basePath + "/" + fileName);
            String result = JSON.toJSONString(mp);
            out.print(result);
            out.flush();
        }
    }
}
