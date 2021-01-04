<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/5
  Time: 21:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户注册</title>
    <!-- 浏览器页面图标 -->
    <link rel="shortcut icon" href="assets/images/icon/favicon.png" type="image/x-icon">

    <title>闲虾</title>


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

    <!--注册模块-->
    <div class="container" style="max-width: 45%">
        <form action="#" method="post" onsubmit="return formCheck()">
            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="userLoginId">登入账号</label>
                    <input type="tel" class="form-control is-invalid" id="userLoginId" required
                           placeholder="用户登入使用账号，建议使用手机号" oninput="checkUserLoginId(this)">
                    <div class="invalid-feedback">
                        *登录账号格式有误！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="password">登入密码</label>
                    <input type="password" class="form-control is-invalid" id="password" required
                           placeholder="密码" oninput="checkPassword(this)">
                    <div class="invalid-feedback">
                        *密码长度介于8到20位之间，且由字母或数字构成！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="repeatPassword">确认密码</label>
                    <input type="password" class="form-control is-invalid" id="repeatPassword" required
                           placeholder="确认密码" oninput="checkRepeatPassword(this)">
                    <div class="invalid-feedback">
                        *两次密码输入不一致！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="username">用户昵称</label>
                    <input type="text" class="form-control is-invalid" id="username" required
                           placeholder="用户昵称" oninput="checkName(this)">
                    <div class="invalid-feedback">
                        *用户名不能为空！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="email">校园邮箱</label>
                    <input type="email" class="form-control is-invalid" id="email" required
                           placeholder="仅限于杭师大校园邮箱" oninput="checkEmail(this)">
                    <div class="invalid-feedback">
                        *邮箱格式有误！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <label for="phoneNumber">手机号码</label>
                    <input type="tel" class="form-control is-invalid" id="phoneNumber" required
                           placeholder="用户手机号码" oninput="checkPhoneNumber(this)">
                    <div class="invalid-feedback">
                        *手机号码格式有误！
                    </div>
                </div>
            </div>

            <div class="form-row">
                <div class="col-md-12 mb-3">
                    <button class="btn btn-secondary btn-lg btn-block" type="submit"
                            style="background-color: #303841;border: 1px solid #303841;">注&nbsp;&nbsp;册
                    </button>
                </div>
            </div>

        </form>
    </div>
</div>

<div style="margin-top: 100px"></div>
<%@include file="common/footer.jsp" %>

<script src="assets/js/jquery-3.4.1.min.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script src="assets/js/bs4.pop.js"></script>
<script src="assets/js/md5.min.js"></script>

<script type="text/javascript">
    //用户登录账号检测
    function checkUserLoginId(obj) {
        var patrn = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
        if (!patrn.exec($(obj).val())) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    function checkName(obj) {
        if ($(obj).val().length == 0) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    //校验密码：只能输入8-20个字母、数字、下划线
    function checkPassword(obj) {
        var patrn = /^(\w){8,20}$/;
        if (!patrn.exec($(obj).val())) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    //校验确认密码
    function checkRepeatPassword(obj) {
        if ($("#password").val() != $(obj).val()) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    //校验邮箱
    function checkEmail(obj) {
        var patrn = /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@stu.hznu.edu.cn$/;
        if (!patrn.exec($(obj).val())) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    //手机号
    function checkPhoneNumber(obj) {
        var patrn = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
        if (!patrn.exec($(obj).val())) {
            $(obj).addClass("is-invalid");
            $(obj).removeClass("is-valid");
            return false;
        }
        $(obj).removeClass("is-invalid");
        $(obj).addClass("is-valid");
        return true;
    }

    function formCheck() {
        if (checkUserLoginId($("#userLoginId")) && checkName($("#username")) &&
            checkPassword($("#password")) && checkRepeatPassword($("#repeatPassword")) &&
            checkEmail($("#email")) && checkPhoneNumber($("#phoneNumber"))) {

            $.ajax({
                type: "post",
                url: "/demo/register",
                data: {
                    /**
                     * 坑：传达servlet的一定是val，之间传主键就是表单提交！！
                     */
                    userloginid: $("#userLoginId").val(),
                    username: $("#username").val(),
                    useremail: $("#email").val(),
                    usephonenumber: $("#phoneNumber").val(),
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
                        bs4pop.alert('注册成功！，请登录！', function () {
                            window.location.href = "login.jsp";
                        });

                    } else if (result == "2") {
                        bs4pop.notice('注册失败，用户登录id已存在！', {type: 'warning'});
                    }
                }
            });

            return false;
        }
        bs4pop.notice('信息填写有误！', {type: 'warning'});
        return false;
    }
</script>
</body>
</html>
