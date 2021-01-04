<%@ page import="com.hznu.domain.User" %><%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/13
  Time: 13:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品列表</title>
    <!-- 浏览器页面图标 -->
    <link rel="shortcut icon" href="assets/images/icon/favicon.png" type="image/x-icon">


    <!-- bootstrap css -->
    <link rel="stylesheet" type="text/css" href="assets/css/bootstrap.css"/>

    <!-- 字体样式 -->
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

    <style type="text/css">
        .hero_area {
            background: #F26D64;
        }

        a {
            color: #303841;
        }

        .searchContainer {
            margin: 0 auto;
            margin-top: 70px;
            width: 45%;
            margin-left: 30%;
        }

        .toolbar {
            border: 1px solid #ccc;
        }
    </style>
</head>

<%--顶部导航栏--%>
<body class="sub_page">
<div class="hero_area">
    <%
        User user = (User) session.getAttribute("user");
        if (user == null) {%>
    <%@include file="common/home/header.jsp" %>
    <%} else {%>
    <%@include file="common/user/header.jsp" %>
    <%}%>
</div>

<%--搜索栏--%>
<div class="searchContainer">
    <div class="input-group">
        <div class="input-group-prepend">
            <span class="input-group-text"><i class="fa fa-search" aria-hidden="true"></i></span>
        </div>
        <input type="text" class="form-control" placeholder="请输入商品信息" value="<%=request.getParameter("keyWords") != null ? request.getParameter("keyWords") : ""%>"
               aria-label="Recipient's username with two button addons" aria-describedby="button-addon4"
               id="btnSearchText">
        <div class="input-group-append" id="button-addon4">
            <button class="btn btn-outline-secondary" type="button" id="btnSearch" onclick="initPage(this)">搜索</button>
        </div>
    </div>
</div>

<%--商品列表--%>
<section class="job_section layout_padding">
    <div class="container">
        <div class="heading_container">
            <h2>
                商品列表
            </h2>
        </div>

        <div class="job_container">

            <!--排行分类栏，如按买家信用排行、价格低到高或高到低-->
            <div class="job_tabs-box" role="tablist">
                <ul class="nav nav-tabs" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active " id="jb-1-tab" data-toggle="tab" href="#jb-1" role="tab"
                           aria-controls="jb-1" aria-selected="true">综合排序</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " id="jb-2-tab" data-toggle="tab" href="#jb-2" role="tab"
                           aria-controls="jb-2" aria-selected="false">卖家信用从高到低</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link  " id="jb-3-tab" data-toggle="tab" href="#jb-3" role="tab"
                           aria-controls="jb-3" aria-selected="false">价格从高到低</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link " id="jb-4-tab" data-toggle="tab" href="#jb-4" role="tab"
                           aria-controls="jb-4" aria-selected="false">价格从从低到高</a>
                    </li>
                </ul>
            </div>

            <div class="tab-content" id="myTabContent">
                <div class="job_board tab-pane fade show active" id="jb-1" role="tabpanel" aria-labelledby="jb-1-tab">
                    <div class="btn-box M-box11"><a href="">下一页</a></div>
                </div>
                <div class="job_board tab-pane fade" id="jb-2" role="tabpanel" aria-labelledby="jb-2-tab">

                </div>
                <div class="job_board tab-pane fade" id="jb-3" role="tabpanel" aria-labelledby="jb-3-tab">

                </div>

                <div class="job_board tab-pane fade" id="jb-4" role="tabpanel" aria-labelledby="jb-4-tab">

                </div>
            </div>

        </div>

    </div>
</section>

<%@include file="common/footer.jsp" %>


<script src="assets/js/jquery-3.4.1.min.js"></script>
<script src="assets/js/jquery.pagination.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script src="assets/js/bs4.pop.js"></script>

<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/md5.min.js"></script>

<script src="assets/js/wangEditor.min.js"></script>
<script src="assets/js/custom.js"></script>

<%if (user != null) {%>
<%@include file="common/user/userscript.jsp" %>
<%}%>

<script type="text/javascript">
    // 当前页展示条数，默认5条
    var pageSize = 5;
    // 总条数
    var idleGoodsSize = 72;

    var idleGoodsList = null;

    if ($("#btnSearchText").val().length != 0) {
        initPage($("#btnSearchText"));
    } else {
        initPage();
    }

    function initPage(obj) {
        let flag;
        if (typeof obj == "undefined") {
            // 如果不是搜索状态，则为搜索全部闲置品
            flag = 0;
        } else {
            flag = 2;
        }
        getPageIdleGoodsItem(1, flag);
        $.ajax({
            type: "post",
            url: "getidlegoodslist",
            async: false,
            data: {
                pageNum: -1,
                flag: flag,
                words: $("#btnSearchText").val()
            },
            success: function (result) {
                idleGoodsSize = result;
                console.log(idleGoodsSize);
                $('.M-box11').pagination({
                    mode: 'fixed',
                    pageCount: Math.ceil(idleGoodsSize / pageSize),
                    showData: pageSize,
                    activeCls: 'btn-box-active',  //当前项css
                    prevContent: '上一页',
                    nextContent: '下一页',
                    callback: function (api) {
                        getPageIdleGoodsItem(api.getCurrent(), flag);
                    }
                });
            },
        });
    }


    function getPageIdleGoodsItem(pageNum, flag) {
        $.ajax({
            type: "post",
            url: "getidlegoodslist",
            data: {
                /**
                 * flag为标识：
                 *      0：代表查找所有闲置品
                 *      1：条件查询，查询某人发布的所有闲置品
                 *      2：表示模糊查询，查询符合条件的闲置品
                 */
                flag: flag,
                pageNum: pageNum,
                pageSize: pageSize,
                words: $("#btnSearchText").val(),
                <%
                if (user != null){
                    out.print("userId: \"" + user.getUserId() + "\"");
                }
                %>
            },
            success: function (result) {
                idleGoodsList = JSON.parse(result);
                var $jb = $("#jb-1");
                var str = "";
                $("#jb-1 .box").remove();
                for (var i = 0; i < idleGoodsList.length; i++) {
                    str += "<div class=\"box\" " + (idleGoodsList[i].goodsStatus != "1" ? "style=\"background-image: url('assets/images/watermark.png')\"" : "") + ">\n" +
                        "<div class=\"job_content-box\">\n" +
                        "<div class=\"img-box\"><img src=" + idleGoodsList[i].goodsCoverImgDir + " alt=\"\"></div>\n" +
                        "<div class=\"detail-box\">\n" +
                        "<h5><a href=\"idlegooddetail.jsp?goodsId=" + idleGoodsList[i].goodsId + "\">" + idleGoodsList[i].goodsName + "</a></h5>\n" +
                        "<div class=\"detail-info\">\n" +
                        "<h6><i class=\"fa fa-user-circle-o\" aria-hidden=\"true\"></i><span>" + idleGoodsList[i].user.userName + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-map-marker\" aria-hidden=\"true\"></i><span>" + idleGoodsList[i].goodsProvince + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-money\" aria-hidden=\"true\"></i><span>￥" + idleGoodsList[i].goodsPrice + "/RMB</span></h6>\n" +
                        "</div></div></div>\n" +
                        "<div class=\"option-box\">\n" +
                        <%
                             if (user != null) {
                                 out.print("\"<button class=\\\"fav-btn\\\"><i \" + \"data-good_id='\" + idleGoodsList[i].goodsId + \"' \" + \"class=\\\"fa \" + (idleGoodsList[i].collected ? \"fa-heart\" : \"fa-heart-o\") + \"\\\" aria-hidden=\\\"true\\\"\\n\" +\n" +
"                        \"onclick=\\\"collect(this)\\\"></i>\\n\" +\n" +
"                        \"</button>\\n\" +");
                             }
                        %>
                        "<a href=\"idlegooddetail.jsp?goodsId=" + idleGoodsList[i].goodsId + "\" class=\"apply-btn\">查看</a>\n" +
                        "</div></div>\n";
                }
                $jb.prepend(str);
            }
        });
    }
</script>

</body>

</html>