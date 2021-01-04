<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>

<head>
    <meta charset="utf-8"/>

    <!-- 浏览器页面图标 -->
    <link rel="shortcut icon" href="assets/images/icon/favicon.png" type="image/x-icon">

    <title>闲虾</title>

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

</head>

<body>
<div class="hero_area">
    <%@include file="common/home/header.jsp" %>

    <section class="slider_section ">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="detail-box">
                        <h1>
                            校园闲置品交易 <br>
                            来闲虾就对了
                        </h1>
                        <p>
                            致力于让你的闲置物品活起来，没有中间商赚差价，价格更低！校企合作，让安全更有保障！
                        </p>
                    </div>
                    <div class="find_container ">
                        <form onsubmit="return search()">
                            <div class="form-row">
                                <div class="form-group col-lg-12">
                                    <input type="text" class="form-control" id="keyWords"
                                           placeholder="What do you want?">
                                </div>
                            </div>
                            <div class="btn-box">
                                <button class="btn">搜&nbsp;&nbsp;&nbsp;索</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="img-box">
                        <img src="assets/images/slider-img.png" alt="">
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%--底部质量订单展示--%>
<section class="client_section layout_padding-bottom">
    <div class="container-fluid">
        <div class="heading_container heading_center psudo_white_primary mb_45">
            <h2>闲置物品轻松卖</h2>
        </div>
        <div class="carousel-wrap ">
            <div class="owl-carousel client_owl-carousel">
                <div class="item">
                    <div class="box">
                        <div class="img-box">
                            <img src="assets/images/Iphone12.jpg" alt="" class="box-img">
                        </div>
                        <div class="detail-box">
                            <div class="client_id">
                                <div class="client_info">
                                    <h6><i class="fa fa-user-circle-o" aria-hidden="true"></i>&nbsp;秋寒</h6>
                                    <p><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;浙江省杭州市</p>
                                </div>
                                <i class="fa fa-quote-left" aria-hidden="true"></i>
                            </div>
                            <p>卖出Iphone12，赚了6000RMB!</p>
                        </div>
                    </div>
                </div>
                <div class="item">
                    <div class="box">
                        <div class="img-box">
                            <img src="assets/images/client2.jpg" alt="" class="box-img">
                        </div>
                        <div class="detail-box">
                            <div class="client_id">
                                <div class="client_info">
                                    <h6><i class="fa fa-user-circle-o" aria-hidden="true"></i>&nbsp;陈旦</h6>
                                    <p><i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp;浙江省温州市</p>
                                </div>
                                <i class="fa fa-quote-left" aria-hidden="true"></i>
                            </div>
                            <p>便宜卖出九阳豆浆机，赚了200RMB!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="common/footer.jsp" %>

<script src="assets/js/jquery-3.4.1.min.js"></script>
<script src="assets/js/bootstrap.js"></script>
<script src="assets/js/bs4.pop.js"></script>

<script src="assets/js/jquery.nice-select.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>

<script src="assets/js/custom.js"></script>

<%--搜索栏--%>
<script type="text/javascript">
    function search() {
        window.location.href = "idlegoodlists.jsp?keyWords=" + $("#keyWords").val();
        return false;
    }
</script>
</body>
</html>