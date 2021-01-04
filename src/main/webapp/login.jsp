<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/5
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户登录</title>
    <!-- 浏览器页面图标 -->
    <link rel="shortcut icon" href="assets/images/icon/favicon.png" type="image/x-icon">

    <!-- bootstrap css -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css"/>

    <!-- 字体样式 -->
    <%--    <link href="assets/css/fonts.googleapis.css" rel="stylesheet">--%>
    <link href="assets/css/font-awesome.min.css" rel="stylesheet"/>

    <!-- 滚动条插件 -->
    <link href="assets/css/nice-select.min.css" rel="stylesheet"/>

    <!-- 卡片水平轮播展示特效插件 -->
    <link href="assets/css/owl.carousel.min.css" rel="stylesheet" type="text/css"/>

    <%--对话框css--%>
    <link href="assets/css/bs4.pop.css" rel="stylesheet" type="text/css"/>

    <!-- 主css -->
    <link href="assets/css/style.css" rel="stylesheet"/>
    <!-- 反应风格 -->
    <link href="assets/css/responsive.css" rel="stylesheet"/>
    <link href="assets/css/menu.css" rel="stylesheet"/>
</head>
<body class="sub_page">
<div class="hero_area">
    <!-- 顶部导航栏 -->

    <%@include file="common/home/header.jsp" %>

    <%--登录表单--%>
    <div class="container" style="max-width: 45%">
        <form onsubmit="return formCheck()" method="post">
            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="userLoginId">登入账号</label>
                    <input type="tel" class="form-control is-invalid" id="userLoginId" required
                           placeholder="登入账号" oninput="checkInput(this)">
                    <div class="invalid-feedback">
                        *登录账号不能为空！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="password">登入密码</label>
                    <input type="password" class="form-control is-invalid" id="password" required
                           placeholder="密码" oninput="checkInput(this)">
                    <div class="invalid-feedback">
                        *密码长度介于8到20位之间！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <button class="btn btn-secondary btn-lg btn-block" type="submit"
                            style="background-color: #303841;border: 1px solid #303841;">登&nbsp;&nbsp;录
                    </button>
                </div>
            </div>
        </form>
    </div>

</div>
<div style="margin-top: 400px"></div>

<%@include file="common/footer.jsp" %>

<script src="assets/js/jquery-3.4.1.min.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script src="assets/js/bs4.pop.js"></script>

<script src="assets/js/md5.min.js"></script>
<script type="text/javascript">
    //用户登录账号、密码简单校验
    function checkInput(obj) {
        if ($(obj).val().length == 0) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    //提交时校验所有内容
    function formCheck() {
        if (checkInput($("#userLoginId")) && checkInput($("#password"))) {
            $.ajax({
                type: "post",
                url: "/demo/login",
                data: {
                    userloginid: $("#userLoginId").val(),
                    userpassword: md5($("#password").val())
                },
                async: false,
                success: function (result) {
                    /**
                     * 用标记返回代表注册状态：
                     * 1： 注册成功
                     * 2： 插入失败，原因为登录id已存在
                     */
                    if (result == "1") {
                        bs4pop.alert('登录成功！', function () {
                            $.ajax({
                                type: "post",
                                url: "/demo/userinfo",
                                data: {
                                    userloginid: $("#userLoginId").val()
                                },
                                async: false,
                                success: function (result) {
                                    window.location.href = "userIndex.jsp";
                                }
                            });
                        });
                    } else if (result == "2") {
                        bs4pop.notice('登录账号或密码不正确！', {type: 'danger'});
                    }
                }
            });
            //如果表单校验通过返回true
            //不通过则返回false
            return false;
        }
        alert("信息填写有误！");
        return false;
    }
</script>
</body>
</html>