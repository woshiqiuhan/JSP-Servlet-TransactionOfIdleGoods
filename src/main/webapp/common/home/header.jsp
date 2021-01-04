<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/5
  Time: 20:00
  To change this template use File | Settings | File Templates.
--%>
<!-- 顶部导航栏，未登录状态均为此头部 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<header class="header_section">
    <div class="container-fluid">
        <nav class="navbar navbar-expand-lg custom_nav-container ">
            <!-- 左上方图标 -->
            <a class="navbar-brand" href="#">
                <span style="font-size: 30px">闲虾</span>
            </a>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class=""> </span>
            </button>

            <!-- 导航列表 -->
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav  ml-auto">
                    <li class="nav-item ">
                        <a class="nav-link" href="index.jsp">主页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="idlegoodlists.jsp">闲置品</a>
                    </li>
                </ul>

                <!-- 最右侧用户按钮 -->
                <div class="user_option">
                    <div class="dropdown">
                        <a class="nav-link" style="cursor:pointer;" id="userLogin" data-toggle="dropdown"
                           aria-haspopup="true"
                           aria-expanded="true">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="userLogin">
                            <li style="text-align: center">
                                <a href="login.jsp" class="dropdown-item">登录</a>
                            </li>
                            <li style="text-align: center">
                                <a href="register.jsp" class="dropdown-item">注册</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </div>
</header>