web.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee
                      http://xmlns.jcp.org/xml/ns/javaee/web-app_4_0.xsd"
         version="4.0"
         metadata-complete="true">
  
</web-app>
```

注册Servlet

```xml
<!--为.java文件创建servlet文件-->
<servlet>
    <!--servlet名称-->
    <servlet-name>helloServlet</servlet-name>
    <!--servlet对应的.java文件-->
    <servlet-class>com.qh.servlet.HelloServlet</servlet-class>
</servlet>
<!--为上述创建的servlet文件创建映射-->
<servlet-mapping>
    <!--servlet的名称-->
    <servlet-name>helloServlet</servlet-name>
    <!--servlet映射的服务端域名地址-->
    <url-pattern>/qiuhan</url-pattern>
</servlet-mapping>
```
