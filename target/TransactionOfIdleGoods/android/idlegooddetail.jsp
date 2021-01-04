<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/14
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>商品详情</title>

    <!-- 浏览器页面图标 -->
    <link rel="shortcut icon" href="../assets/images/icon/favicon.png" type="image/x-icon">

    <link rel="stylesheet" type="text/css" href="../assets/css/bootstrap.css"/>

    <!-- 字体样式 -->
    <link href="../assets/css/font-awesome.min.css" rel="stylesheet"/>

    <!-- 滚动条插件 -->
    <link href="../assets/css/nice-select.min.css" rel="stylesheet"/>

    <!-- 卡片水平轮播展示特效插件 -->
    <link href="../assets/css/owl.carousel.min.css" rel="stylesheet" type="text/css"/>
    <%--对话框css--%>
    <link href="../assets/css/bs4.pop.css" rel="stylesheet" type="text/css"/>
    <!-- 主css -->
    <link href="../assets/css/style.css" rel="stylesheet"/>
    <!-- 反应风格 -->
    <link href="../assets/css/responsive.css" rel="stylesheet"/>
    <link href="../assets/css/menu.css" rel="stylesheet"/>
</head>
<body class="sub_page">
<%
    String goodsId = request.getParameter("goodsId");
    String userId = request.getParameter("userId");
%>

<%--商品列表--%>
<section class="job_section layout_padding">
    <div class="container">
        <div class="heading_container">
            <%--展示闲置品详细信息--%>
        </div>

        <%
            if (userId != null) {%>
        <div>
            <div class="btn-box">
                <a href="">收藏</a>
                <a style="cursor:pointer;" data-toggle="modal" data-target="#makeOrderModal" onclick="fillOrderInfo()"
                   id="buyIdleGoods">购买</a>
            </div>
        </div>
        <% } %>

        <div class="job_container" style="margin-top: 100px">
            <div class="list-group">
                <a class="list-group-item list-group-item-action active"
                   style="background: #F26D64; color: white; border-color: #F26D64">
                    <div class="d-flex w-100 justify-content-between">
                        <h5 class="mb-1">评论区</h5>
                    </div>
                </a>
                <div>
                    <%--载入页面只展示最新的三条评论--%>
                    <div id="messageBox">
                    </div>

                    <%--查看更多评论，点击后在下方展示所有评论--%>
                    <a class="list-group-item list-group-item-action" style="cursor:pointer;"
                       data-toggle="collapse" data-target="#moreCommentModel">
                        <h6 class="mb-1">查看更多评论</h6>
                    </a>
                    <div class="collapse" id="moreCommentModel">
                        <a class='list-group-item list-group-item-action'>
                            <div class='d-flex w-100 justify-content-between'>
                                <h5 class='mb-1'>卖家，价格能够再低一点吗？很心动。</h5>
                                <small class='text-muted'>3 days ago</small>
                            </div>
                            <p class='mb-1'><i class='fa fa-user-circle-o' aria-hidden='true'></i><span>秋寒iiii</span>
                            </p>
                        </a>
                    </div>
                    <%--展开富文本编辑器发布评论--%>
                    <a class='list-group-item list-group-item-action' style='cursor:pointer;'
                       data-toggle='collapse' data-target='#addNewCommentModel'>
                        <h6 class="mb-1">添加评论</h6>
                    </a>
                    <div class='collapse' id='addNewCommentModel'>
                        <div class='form-group'>
                            <div id='addNewComment' style="z-index: 100 !important;"></div>
                        </div>
                        <div class='form-group'>
                            <button type='button' class='btn btn-secondary btn-lg btn-block' onclick='addNewMessage()'>发&nbsp;&nbsp;布</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 提交订单模态框 -->
        <div class="modal fade" id="makeOrderModal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <!-- 模态框头部 -->
                    <div class="modal-header">
                        <h4 class="modal-title">提交订单</h4>
                        <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
                    </div>

                    <!-- 模态框主体 -->
                    <div class="modal-body" id="makeOrderModalBody">
                        <form style="padding: 0 30px;" id="makeOrderInfo">

                            <div class="form-row">
                                <div class="form-group  col-md-12">
                                    <label style="text-align: center">收货地址</label>
                                    <select class="form-control" id="chooseReceivePath" style="z-index: 999;"
                                            onchange="onChangeReceivePath()">
                                        <option value="请选择">请选择</option>

                                        <option value="添加" id="addNewReceivePath">添加新的收货地址</option>
                                    </select>
                                </div>
                            </div>
                            <%--添加信息的收货地址--%>
                            <div id="addNewDeliveryInformation" style="display: none">
                                <div class="form-row">
                                    <div class="form-group  col-md-6">
                                        <label for="receiveName">昵称</label>
                                        <input id="receiveName" type="text" class="form-control form-control-sm"
                                               placeholder="收货人昵称">
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label for="receiveContact">联系方式</label>
                                        <input id="receiveContact" type="text" class="form-control form-control-sm"
                                               placeholder="收货人联系方式">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md-12">
                                        <label for="receiveDetailAddress">详细地址</label>
                                        <input id="receiveDetailAddress" type="text"
                                               class="form-control form-control-sm" placeholder="收货人详细地址">
                                    </div>
                                </div>
                            </div>
                        </form>

                    </div>

                    <!-- 模态框底部 -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" id="saveReceiveInfo" onclick="save()"
                                style="display: none">保存地址
                        </button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-success" data-dismiss="modal" onclick="submitOrder()">提交
                        </button>
                    </div>

                </div>
            </div>
        </div>
    </div>
</section>

<script src="../assets/js/jquery-3.4.1.min.js"></script>
<script src="../assets/js/jquery.pagination.js"></script>
<script src="../assets/js/bootstrap.js"></script>
<script src="../assets/js/bs4.pop.js"></script>
<script src="../assets/js/md5.min.js"></script>
<script src="../assets/js/jquery.nice-select.min.js"></script>
<script src="../assets/js/owl.carousel.min.js"></script>

<script src="../assets/js/wangEditor.min.js"></script>
<script src="../assets/js/custom.js"></script>

<%--用户登录状态时，自动添加浏览记录--%>
<%if (userId != null) {%>
<script type="text/javascript">
    $.ajax({
        type: "post",
        url: "../addbrowsehistory",
        data: {
            userId: "userId",
            goodsId: "<%=goodsId%>"
        },
        success: function (result) {
            console.log(result);
        },
    });
</script>
<%--提交订单js脚本--%>
<script type="text/javascript">
    // 初始化订单模态框
    function fillOrderInfo() {
        if (typeof $("#buyIdleGoods").attr("data-target") == "undefined") {
            bs4pop.notice('该闲置物已卖出或下架！', {type: 'primary'});
        } else {
            // 获取闲置品信息并填入订单模态框中
            $.ajax({
                type: "post",
                url: "../getidlegoodsdetailinfo",
                async: false,
                data: {
                    goodsId: "<%=goodsId%>"
                },
                success: function (result) {
                    var goodsDetailInfo = JSON.parse(result);
                    console.log("goodsDetailInfo" + goodsDetailInfo);
                    $("#makeOrderInfo .box").remove();
                    $("#makeOrderInfo").prepend("<div class='form-group'>" +
                        "<div class='box'>\n" +
                        "<div class='job_content-box'>\n" +
                        "<div class='img-box'><img src='" + goodsDetailInfo.goodsCoverImgDir + "'></div>\n" +
                        "<div class='detail-box'>\n" +
                        "<h5>" + goodsDetailInfo.goodsName + "</h5>\n" +
                        "<div class='detail-info'>\n" +
                        "<h6><i class='fa fa-user-circle-o' aria-hidden='true'></i><span>" + goodsDetailInfo.user.userName + "</span></h6>\n" +
                        "<h6><i class='fa fa-money' aria-hidden='true'></i><span>￥" + goodsDetailInfo.goodsPrice + "/RMB</span></h6>\n" +
                        "</div></div></div></div></div>"
                    );
                },
            });

            /*获取用户的地址信息*/
            $.ajax({
                type: "post",
                url: "../getuserdeliveryinformation",
                async: false,
                data: {
                    userId: "<%=userId%>"
                },
                success: function (result) {
                    var userDeliveryInformation = JSON.parse(result);

                    $("#chooseReceivePath").empty();
                    var str = "<option value='请选择'>请选择</option>\n";
                    for (var i = 0; i < userDeliveryInformation.length; i++) {
                        str += "<option value='" + userDeliveryInformation[i].deliveryInfoId + "'>" + userDeliveryInformation[i].receiveName + " " + userDeliveryInformation[i].receiveContact + " " + userDeliveryInformation[i].receiveDetailAddress + "</option>";
                    }
                    str += "<option value='添加' id='addNewReceivePath'>添加新的收货地址</option>";
                    $("#chooseReceivePath").append(str);
                },
            });
        }
    }

    // select的onchange事件
    function onChangeReceivePath() {
        if ($("#chooseReceivePath").val() == "添加") {
            $("#addNewDeliveryInformation").show();
            $("#saveReceiveInfo").show();
        } else {
            $("#addNewDeliveryInformation").hide();
            $("#saveReceiveInfo").hide();
        }
    }

    // 保存新添加地址
    function save() {
        var receiveName = $("#receiveName").val();
        var receiveContact = $("#receiveContact").val();
        var receiveDetailAddress = $("#receiveDetailAddress").val();

        if (receiveName.length == 0 || receiveContact.length == 0 || receiveDetailAddress.length == 0) {
            alert("信息填写不完整，请检查！");
        } else {
            $.ajax({
                type: "post",
                url: "../adduserdeliveryinformation",
                async: false,
                data: {
                    userId: "<%=userId%>",
                    receiveName: receiveName,
                    receiveContact: receiveContact,
                    receiveDetailAddress: receiveDetailAddress
                },
                success: function (result) {
                    console.log(typeof result);
                    if (result == "2") { // 添加失败
                        bs4pop.notice('信息填写有误，请检查！', {type: 'warning'});
                    } else {
                        // 注：引号不能丢，浏览器自动加，console控制台迷惑性
                        let tmp = "<option value='" + result + "'>" + receiveName + " " + receiveContact + " " + receiveDetailAddress + "</option>";
                        $("#addNewReceivePath").before(tmp)
                        $("#chooseReceivePath").val(result);
                        $("#addNewDeliveryInformation").hide();
                        $("#saveReceiveInfo").hide();

                        // 清空表单
                        $("#receiveName").val("");
                        $("#receiveContact").val("");
                        $("#receiveDetailAddress").val("");

                        // 提示添加成功
                        bs4pop.notice('添加地址成功！', {type: 'success'});
                    }
                },
            });
        }
    }

    // 创建订单，此时订单处于未支付状态
    function submitOrder() {
        if ($("#chooseReceivePath").val() == "请选择") {
            // 表示地址未选择，提醒用户选择收货地址
            bs4pop.notice('收货地址未选择，请选择！', {type: 'warning'});
        } else {  // 保证信息无误后
            // 先提交订单并创建订单
            $.ajax({
                type: "post",
                url: "../createorder",
                async: false,
                data: {
                    goodsId: "<%=goodsId%>",
                    userId: "<%=userId%>",
                    deliveryInfoId: $("#chooseReceivePath").val()
                },
                success: function (result) {
                    console.log("result1: " + result);
                    if (result == "80") {
                        // 创建订单失败
                        bs4pop.notice('创建订单失败', {type: 'danger'});
                    } else if (result == "400") {
                        // 表示当前闲置品已被拍走
                        bs4pop.notice('表示当前闲置品被拍走或被下架，请刷新页面！', {type: 'warning'})
                    } else {
                        bs4pop.notice('订单创建成功！请支付。', {type: 'success'});
                        setTimeout(function () {
                            confirmPayment(result);
                        }, 1000);
                    }
                }
            });
        }
    }

    // 确认订单支付，完成订单
    function confirmPayment(orderId) {
        bs4pop.prompt('订单创建成功！请输入密码确认支付', '请输入登录密码', function (sure, value) {
            if (sure) {
                var passwd = md5(value);
                $.ajax({
                    type: "post",
                    url: "../submitorder",
                    async: false,
                    data: {
                        passwd: passwd,
                        goodsId: "<%=goodsId%>",
                        userId: "<%=userId%>",
                        deliveryInfoId: $("#chooseReceivePath").val(),
                        goodsPrice: goodsInfo.goodsPrice,
                        orderId: orderId
                    },
                    success: function (result) {
                        console.log("result2: " + result);
                        if (result == "40") {
                            // 支付成功
                            bs4pop.notice('支付成功！', {type: 'success'});
                        } else if (result == "90") {
                            bs4pop.notice('支付失败！请在30分钟内到我的订单中重新支付！', {type: 'danger'});
                        } else if (result == "100") {
                            bs4pop.notice('密码错误！请在30分钟内到我的订单中重新支付！', {type: 'danger'});
                        }
                    },
                });
            } else { // 取消支付，请在30分钟内支付
                bs4pop.notice('请在30分钟内到我的订单中重新支付！', {type: 'primary'});
            }
        });
    }
</script>
<%}%>

<%--显示闲置品详细界面--%>
<script type="text/javascript">
    var goodsInfo = null;
    $.ajax({
        type: "post",
        url: "../getidlegoodsbyid",
        async: false,
        data: {
            goodsId: "<%=goodsId%>"
        },
        success: function (result) {
            goodsInfo = JSON.parse(result);

            $(".heading_container").empty();
            $(".heading_container").append(goodsInfo.goodsDetail);

            $(".heading_container").append("<h3 style='margin-top: 50px' align='center'><i class='fa fa-money' aria-hidden='true'></i><span>￥" + goodsInfo.goodsPrice + "/RMB</span></h3>")

            if (goodsInfo.goodsStatus != "1") { // 代表当前闲置品以卖出或下架
                $("#buyIdleGoods").removeAttr("data-target");
            }
        },
    });
</script>

<%--初始化评论区--%>
<script type="text/javascript">
    initMessageBox();

    function initMessageBox() {
        $.ajax({
            type: "post",
            url: "../getleavingmessages",
            async: false,
            data: {
                goodsId: "<%=goodsId%>"
            },
            success: function (result) {
                let messageLists = JSON.parse(result);
                console.log(messageLists);
                let strMessage = "";
                for (let i = 0; i < Math.min(3, messageLists.length); i++) {
                    strMessage += "<a class='list-group-item list-group-item-action'>\n" +
                        "<div class='d-flex w-100 justify-content-between'>\n" +
                        "<h5 class='mb-1'>" + messageLists[i].messageDetail + "</h5>\n" +
                        "<small class='text-muted'>" + GetDateTimeToString(new Date(messageLists[i].leavingDate)) + "</small>\n" +
                        "</div>\n" +
                        " <p class='mb-1'><i class='fa fa-user-circle-o' aria-hidden='true'></i><span>" + messageLists[i].userName + "</span></p>\n" +
                        "<small class='text-muted' style='cursor:pointer;'" +
                        "data-toggle='collapse' data-target='#replyModel_" + messageLists[i].messageId + "'>查看回复</small>\n" +
                        "</a>\n" +
                        "<div class='collapse list-group' id='replyModel_" + messageLists[i].messageId + "'>\n";

                    $.ajax({
                        type: "post",
                        url: "../getmessagereply",
                        async: false,
                        data: {
                            messageId: messageLists[i].messageId
                        },
                        success: function (result) {
                            let messageReplyLists = JSON.parse(result);
                            for (let j = 0; j < messageReplyLists.length; j++) {
                                strMessage += "<a class='list-group-item list-group-item-action'>\n" +
                                    "<div class='d-flex w-100 justify-content-between'>\n" +
                                    "<h5 class='mb-1' style='margin-left: 50px'>" + messageReplyLists[j].replyDetail + "</h5>\n" +
                                    "<small class='text-muted'>" + GetDateTimeToString(new Date(messageReplyLists[j].replyDate)) + "</small>\n" +
                                    "</div>\n" +
                                    "<p class='mb-1' style='margin-left: 50px'><i class='fa fa-user-circle-o' aria-hidden='true'></i><span>" + messageReplyLists[j].userName + "</span>\n" +
                                    "</p>\n" +
                                    "</a>";
                            }
                        },
                    });

                    strMessage += "<a class='list-group-item list-group-item-action' style='cursor:pointer;'\n" +
                        "data-toggle='collapse' data-target='#addNewReplyModel_" + messageLists[i].messageId + "'>\n" +
                        "<h6 class=\"mb-1\" style='margin-left: 50px'>添加回复</h6>\n" +
                        "</a>\n" +
                        "<div class='collapse' id='addNewReplyModel_" + messageLists[i].messageId + "'>\n" +
                        "<div class='form-group' style='margin-left: 50px'>\n" +
                        "<label for='addNewReplyInput_" + messageLists[i].messageId + "'>回复内容</label>\n" +
                        "<input type='text' class='form-control' id='addNewReplyInput_" + messageLists[i].messageId + "'>\n" +
                        "</div>\n" +
                        "<div class='form-group' style='margin-left: 50px'>\n" +
                        "<button type='button' class='btn btn-secondary btn-lg btn-block' onclick=\"addNewReply('" + messageLists[i].messageId + "')\">发&nbsp;&nbsp;布</button>\n" +
                        "</div></div></div>";
                }
                $("#messageBox").empty();
                $("#messageBox").append(strMessage);

                strMessage = "";
                for (let i = 3; i < messageLists.length; i++) {
                    strMessage += "<a class='list-group-item list-group-item-action'>\n" +
                        "<div class='d-flex w-100 justify-content-between'>\n" +
                        "<h5 class='mb-1'>" + messageLists[i].messageDetail + "</h5>\n" +
                        "<small class='text-muted'>" + GetDateTimeToString(new Date(messageLists[i].leavingDate)) + "</small>\n" +
                        "</div>\n" +
                        " <p class='mb-1'><i class='fa fa-user-circle-o' aria-hidden='true'></i><span>" + messageLists[i].userName + "</span></p>\n" +
                        "<small class='text-muted' style='cursor:pointer;'" +
                        "data-toggle='collapse' data-target='#replyModel_" + messageLists[i].messageId + "'>查看回复</small>\n" +
                        "</a>\n" +
                        "<div class='collapse list-group' id='replyModel_" + messageLists[i].messageId + "'>\n";

                    $.ajax({
                        type: "post",
                        url: "../getmessagereply",
                        async: false,
                        data: {
                            messageId: messageLists[i].messageId
                        },
                        success: function (result) {
                            let messageReplyLists = JSON.parse(result);
                            for (let j = 0; j < messageReplyLists.length; j++) {
                                strMessage += "<a class='list-group-item list-group-item-action'>\n" +
                                    "<div class='d-flex w-100 justify-content-between'>\n" +
                                    "<h5 class='mb-1' style='margin-left: 50px'>" + messageReplyLists[j].replyDetail + "</h5>\n" +
                                    "<small class='text-muted'>" + GetDateTimeToString(new Date(messageReplyLists[j].replyDate)) + "</small>\n" +
                                    "</div>\n" +
                                    "<p class='mb-1' style='margin-left: 50px'><i class='fa fa-user-circle-o' aria-hidden='true'></i><span>" + messageReplyLists[j].userName + "</span>\n" +
                                    "</p>\n" +
                                    "</a>";
                            }
                        },
                    });

                    strMessage += "<a class='list-group-item list-group-item-action' style='cursor:pointer;'\n" +
                        "data-toggle='collapse' data-target='#addNewReplyModel_" + messageLists[i].messageId + "'>\n" +
                        "<h6 class=\"mb-1\" style='margin-left: 50px'>添加回复</h6>\n" +
                        "</a>\n" +
                        "<div class='collapse' id='addNewReplyModel_" + messageLists[i].messageId + "'>\n" +
                        "<div class='form-group' style='margin-left: 50px'>\n" +
                        "<label for='addNewReplyInput_" + messageLists[i].messageId + "'>回复内容</label>\n" +
                        "<input type='text' class='form-control' id='addNewReplyInput_" + messageLists[i].messageId + "'>\n" +
                        "</div>\n" +
                        "<div class='form-group' style='margin-left: 50px'>\n" +
                        "<button type='button' class='btn btn-secondary btn-lg btn-block' onclick=\"addNewReply('" + messageLists[i].messageId + "')\">发&nbsp;&nbsp;布</button>\n" +
                        "</div></div></div>";
                }
                $("#moreCommentModel").empty();
                $("#moreCommentModel").append(strMessage);
            },
        });
    }

    function addNewReply(messageId) {
        <%if (userId != null) {%>
        $.ajax({
            type: "post",
            url: "../addnewmessagereply",
            data: {
                messageId: messageId,
                userId: "<%=userId%>",
                replyDetail: $("#addNewReplyInput_" + messageId).val(),
            },
            success: function (result) {
                if (result == "1") {
                    $("#addNewReplyInput_" + messageId).val("");
                    bs4pop.notice('发布成功！', {type: 'success'});
                } else if (result == "2") {
                    bs4pop.notice('发布失败！，请检查闲置品信息', {type: 'warning'});
                }
            },
        });
        <%} else {%>
        bs4pop.notice('请先登录！', {type: 'warning'})
        <%}%>
    }

    function GetDateTimeToString(date_) {
        var year = date_.getFullYear();
        var month = date_.getMonth() + 1;
        var day = date_.getDate();
        if (month < 10) month = "0" + month;
        if (day < 10) day = "0" + day;

        var hours = date_.getHours();
        var mins = date_.getMinutes();
        var secs = date_.getSeconds();
        var msecs = date_.getMilliseconds();
        if (hours < 10) hours = "0" + hours;
        if (mins < 10) mins = "0" + mins;
        if (secs < 10) secs = "0" + secs;
        if (msecs < 10) secs = "0" + msecs;
        return year + "/" + month + "/" + day + " " + hours + ":" + mins;
    }
</script>
<%--添加新评论--%>
<script type="text/javascript">
    <%--富文本编辑器初始化--%>
    let E = window.wangEditor;
    let editor_message = new E('#addNewComment');

    // 设置富文本编辑器的功能
    editor_message.config.menus = [
        "bold", // 粗体
        "italic", // 斜体
        'foreColor',  // 文字颜色
        "quote", // 引用
        "emoticon", // 表情
        "undo", // 撤销
        "redo", // 重复
    ];
    // 创建富文本编辑器
    editor_message.create();

    function addNewMessage() {
        <%
        if (userId != null) {%>
        $.ajax({
            type: "post",
            url: "../addnewleavingmessage",
            data: {
                goodsId: "<%=goodsId%>",
                userId: "<%=userId%>",
                messageDetail: editor_message.txt.html(),
            },
            success: function (result) {
                if (result == "1") {
                    editor_message.txt.clear();
                    bs4pop.notice('发布成功！', {type: 'success'});
                } else if (result == "2") {
                    bs4pop.notice('发布失败！，请检查闲置品信息', {type: 'warning'});
                }
            },
        });
        <%} else {%>
        bs4pop.notice('请先登录！', {type: 'warning'})
        <%}%>
    }
</script>
</body>
</html>
