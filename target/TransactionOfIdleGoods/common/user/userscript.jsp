<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/13
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%--登录状态均存在的js脚本--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--个人信息设置--%>
<script type="text/javascript">
    //用户登录账号检测
    function checkUserLoginId() {
        return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/.exec($("#userLoginId").val());
    }

    function checkName() {
        return !$("#username").val().length == 0;
    }

    //校验邮箱
    function checkEmail() {
        return /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/.exec($("#email").val());
    }

    //手机号
    function checkPhoneNumber() {
        return /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/.exec($("#phoneNumber").val());
    }

    // 修改用户基本信息
    function modifyPerMess() {
        if (checkUserLoginId() && checkName() && checkEmail() && checkPhoneNumber()) {

            $.ajax({
                type: "post",
                url: "/demo/modifyuserinfo",
                data: {
                    /**
                     * 坑：传达servlet的一定是val，之间传主键就是表单提交！！
                     */
                    userId: $("#userId").val(),
                    userloginid: $("#userLoginId").val(),
                    username: $("#username").val(),
                    useremail: $("#email").val(),
                    usephonenumber: $("#phoneNumber").val()
                },
                async: false,
                success: function (result) {
                    /**
                     * 用标记返回代表注册状态：
                     * 1： 注册成功
                     * 2： 插入失败，原因为登录id已存在
                     */
                    if (result == "1") {
                        bs4pop.notice('修改成功!', {type: 'success'});
                    } else if (result == "2") {
                        bs4pop.notice('修改失败！', {type: 'warning'});
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

    //退出登录
    function quit() {
        $.post("/demo/logout", function (res, status) {
            bs4pop.confirm('你确定要退出登录吗？', function (sure) {
                if (sure) {
                    bs4pop.alert('退出登录成功！', function () {
                        window.location.replace("index.jsp");
                    });
                }
            });
        });
    }
</script>

<%--发布闲置品模态框脚本--%>
<script type="text/javascript">
    <%--富文本编辑器--%>
    let E = window.wangEditor;
    let editor = new E('#ideaIntroduce');

    // 设置富文本编辑器的功能
    editor.config.menus = [
        "head", // 标题
        "bold", // 粗体
        "fontSize", // 字号
        "fontName", // 字体
        "italic", // 斜体
        'foreColor',  // 文字颜色
        "link", // 插入链接
        "justify", // 对齐方式
        "quote", // 引用
        "emoticon", // 表情
        "image", // 插入图片
        "video", // 插入视频
        "undo", // 撤销
        "redo", // 重复
    ];

    // 关闭上传图片方式——网络链接方式 关闭
    editor.config.showLinkImg = false;
    // 上传到处理上传文件的servlet
    editor.config.uploadImgServer = 'loadIdlepic';
    // 设置所传输文件的名字
    <%-- editor.config.uploadFileName = "${user.userId}" + "_" + (new Date()).getTime() + ".jpg";--%>

    // 处理上传文件的返回结果
    editor.config.uploadImgHooks = {
        // 服务器端返回的必须是一个 JSON 格式字符串！！！否则会报错
        customInsert: function (insertImg, result, editor) {
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果
            insertImg(result.url);
        }

    };
    // 创建富文本编辑器
    editor.create();

    /**
     * 关于分类，
     *      1、首先初始化根分类
     *      2、其次在每次选中分类后初始化子分类
     * */
    // 当打开发布商品页面时初始化根分类
    function initRootType() {  // 设定分类最多为四层
        $.ajax({
            type: "post",
            url: "getrootcategory",
            async: false, // 关异步
            success: function (result) {
                let categories = JSON.parse(result);
                // 将跟分类选项动态加载进页面中
                let $rootType = $("#rootType");
                $rootType.empty();
                let str = "<option value='请选择'>请选择</option>"
                for (let i = 0; i < categories.length; i++) {
                    str += "<option value='" + categories[i].categoryId + "'>" + categories[i].categoryName + "</option>";
                }
                $rootType.append(str);  //在中间添加
            },
        });
    }

    // 初始化子分类
    function initSonType(i) {
        // 获取父节点id值
        let fa = i == 1 ? "#rootType" : ("#sonType" + (i - 1) + " select");
        // 获取当前节点id值
        let son = "#sonType" + i;
        if ($(fa).val() == "请选择") {  // 表示父节点还未选择
            // 则当前节点仍隐藏，且之后节点全部隐藏
            for (let j = i; j < 4; j++) {
                $("#sonType" + j).hide();
            }
        } else { // 否则，当前节点显示
            $(son).show();
            $.ajax({ // 请求当前节点所有分类
                type: "post",
                url: "getcategory",
                async: false, // 关异步
                data: {
                    // 传输数据为父节点值
                    rootType: $(fa).val()
                },
                success: function (result) {
                    let categories = JSON.parse(result);
                    if (categories.length == 0) {
                        // 若当前节点分类为空，则代表上一层即为叶子节点分类
                        // 将当前节点及之后节点全部隐藏
                        for (let j = i; j < 4; j++) {
                            $("#sonType" + j).hide();
                        }
                    } else { // 否则像当前节点的select标签添加分类值
                        let $select = $(son + " select");
                        $select.empty();
                        var str = "<option value='请选择'>请选择</option>"
                        for (let j = 0; j < categories.length; j++) {
                            str += "<option value='" + categories[j].categoryId + "'>" + categories[j].categoryName + "</option>";
                        }
                        $select.append(str);  //在中间添加
                        for (let j = i + 1; j < 4; j++) { // 并将之后的select框先隐藏
                            $("#sonType" + j).hide();
                        }
                    }
                },
            });
        }
    }

    // 获取叶子节点分类
    function getType() {
        if ($("#sonType3 select").val() !== "请选择") {
            return $("#sonType3 select").val();
        }
        if ($("#sonType2 select").val() !== "请选择") {
            return $("#sonType2 select").val();
        }
        if ($("#sonType1 select").val() !== "请选择") {
            return $("#sonType1 select").val();
        }
        if ($("#rootType").val() !== "请选择") {
            return $("#rootType").val();
        }
        return null;
    }

    // 发布闲置品
    function releaseIdea() {
        $.ajax({
            type: "post",
            url: "releaseidle",
            data: {
                ideaTitle: $("#ideaTitle").val(),
                type: getType(),
                ideaIntroduce: editor.txt.html(),
                ideaPrice: $("#ideaPrice").val(),
                ideaTips: $("#ideaTips").val(),
                ideaProvince: $("#ideaProvince").val()
            },
            success: function (result) {
                if (result == "1") {
                    $("#ideaTitle").val("");
                    $("#rootType").val("请选择");
                    $("#sonType1").hide();
                    $("#sonType2").hide();
                    $("#sonType3").hide();
                    $("#ideaPrice").val("");
                    $("#ideaTips").val("");
                    $("#ideaProvince").val("")
                    editor.txt.clear();
                    bs4pop.notice('发布成功！', {type: 'success'});
                } else if (result == "2") {
                    bs4pop.notice('发布失败！，请检查闲置品信息', {type: 'warning'});
                }
            },
        });
    }
</script>

<%--收藏闲置品标签事件--%>
<script type="text/javascript">
    function collect(obj) { //收藏
        let cls = $(obj).attr("class") + "";
        $(obj).removeAttr("class");
        let flag = 1; // 标志位：0表示取消收藏，1表示收藏
        if (cls === "fa fa-heart") { //取消收藏
            flag = 0;
            $(obj).attr("class", "fa fa-heart-o");
            bs4pop.notice('取关成功！', {type: 'info'});
        } else { //收藏
            flag = 1;
            $(obj).attr("class", "fa fa-heart");
            bs4pop.notice('收藏成功', {type: 'success'});
        }

        $.ajax({
            type: "post",
            url: "managecollected",
            data: {
                flag: flag,
                goodsId: $(obj).data("good_id"),
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
            },
        });
    }
</script>

<%--查看我发布的闲置品--%>
<script type="text/javascript">
    // 当前页展示条数，默认3条
    let myReleasedModal_pageSize = 3;
    // 总条数
    let myReleasedModal_idleGoodsSize = 72;

    let myReleasedModal_idleGoodsList = null;

    function myReleasedModal_initPage() {
        myReleasedModal_getPageIdleGoodsItem(1);
        $.ajax({
            type: "post",
            url: "getidlegoodslist",
            async: false,
            data: {
                pageNum: -1,
                flag: 1,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                myReleasedModal_idleGoodsSize = result;
                $('.M-box-myReleasedModalList').pagination({
                    mode: 'fixed',
                    pageCount: Math.ceil(myReleasedModal_idleGoodsSize / myReleasedModal_pageSize),
                    showData: myReleasedModal_pageSize,
                    activeCls: 'btn-box-active',  //当前项css
                    prevContent: '上一页',
                    nextContent: '下一页',
                    callback: function (api) {
                        myReleasedModal_getPageIdleGoodsItem(api.getCurrent());
                    }
                });
            },
        });
    }

    function myReleasedModal_getPageIdleGoodsItem(pageNum) {
        $.ajax({
            type: "post",
            url: "getidlegoodslist",
            data: {
                /**
                 * flag为标识：
                 *      0：代表查找所有闲置品
                 *      1：条件查询，查询某用户发布的所有闲置品
                 *      2：表示模糊查询，查询符合条件的闲置品
                 */
                flag: 1,
                pageNum: pageNum,
                pageSize: myReleasedModal_pageSize,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                myReleasedModal_idleGoodsList = JSON.parse(result);
                let $myReleasedModalList = $("#myReleasedModalList");
                let myReleasedModal_str = "";
                $("#myReleasedModalList .box").remove();
                for (let i = 0; i < myReleasedModal_idleGoodsList.length; i++) {
                    // 若当前商品已卖出，将最后按钮事件修改为展示订单信息事件
                    let goodsStatus = myReleasedModal_idleGoodsList[i].goodsStatus != "1" ?
                        "<a style='cursor:pointer; margin-right: 15px' class='apply-btn' onclick=\"checkIdleStatusSold('" + myReleasedModal_idleGoodsList[i].goodsId + "')\"data-dismiss=\"modal\">查看详情</a>\n" :
                        "<a href=\"idlegooddetail.jsp?goodsId=" + myReleasedModal_idleGoodsList[i].goodsId + "\" class=\"apply-btn\">查看</a>\n";
                    myReleasedModal_str += "<div class=\"box\" " + (myReleasedModal_idleGoodsList[i].goodsStatus != "1" ? "style=\"background-image: url('assets/images/watermark.png')\"" : "") + ">\n" +
                        "<div class=\"job_content-box\">\n" +
                        "<div class=\"img-box\"><img src=" + myReleasedModal_idleGoodsList[i].goodsCoverImgDir + " alt=\"\"></div>\n" +
                        "<div class=\"detail-box\">\n" +
                        "<h5><a href=\"idlegooddetail.jsp?goodsId=" + myReleasedModal_idleGoodsList[i].goodsId + "\" style='max-width: 455px; display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #303841'>" + myReleasedModal_idleGoodsList[i].goodsName + "</a></h5>\n" +
                        "<div class=\"detail-info\">\n" +
                        "<h6><i class=\"fa fa-user-circle-o\" aria-hidden=\"true\"></i><span>" + myReleasedModal_idleGoodsList[i].user.userName + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-map-marker\" aria-hidden=\"true\"></i><span>" + myReleasedModal_idleGoodsList[i].goodsProvince + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-money\" aria-hidden=\"true\"></i><span>￥" + myReleasedModal_idleGoodsList[i].goodsPrice + "/RMB</span></h6>\n" +
                        "</div></div></div>\n" +
                        "<div class=\"option-box\">\n" +
                        goodsStatus +
                        "</div></div>\n";
                }
                $myReleasedModalList.prepend(myReleasedModal_str);
            }
        });
    }

    // 当闲置物被拍下后，查看订单详情事件
    function checkIdleStatusSold(goodsId) {
        // 首先查看订单状态
        $.ajax({
            type: "post",
            url: "myidlegoodsstatusdetail",
            async: false,
            data: {
                flag: 1,
                goodsId: goodsId
            },
            success: function (result) {
                let myIdleGoods = JSON.parse(result);
                if (myIdleGoods.orderStatus == "30") {
                    bs4pop.notice('该商品已被拍下，但未支付！', {type: 'primary'});
                } else if (myIdleGoods.orderStatus == "40") {
                    // 若订单已被支付，查询收货地址详情
                    $.ajax({
                        type: "post",
                        url: "myidlegoodsstatusdetail",
                        async: false,
                        data: {
                            flag: 2,
                            deliveryInfoId: myIdleGoods.deliveryInfoId
                        },
                        success: function (result) {
                            let userDeliveryInformation = JSON.parse(result);
                            // 展示给用户
                            bs4pop.notice('该商品已被拍下并已支付！请将闲置品送至：' +
                                '收货人：' + userDeliveryInformation.receiveName +
                                '， 收货地址：' + userDeliveryInformation.receiveDetailAddress +
                                '， 收货人联系方式：' + userDeliveryInformation.receiveContact, {type: 'primary'});
                        },
                    });
                }
            },
        });
    }
</script>

<%--我的浏览记录--%>
<script type="text/javascript">
    // 当前页展示条数，默认3条
    let myBrowseHistoryModal_pageSize = 3;
    // 总条数
    let myBrowseHistoryModal_idleGoodsSize = 72;

    let myBrowseHistoryModal_idleGoodsList = null;

    function myBrowseHistoryModal_initPage() {
        myBrowseHistoryModal_getPageIdleGoodsItem(1);
        $.ajax({
            type: "post",
            url: "mybrowsehistory",
            async: false,
            data: {
                pageNum: -1,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                myBrowseHistoryModal_idleGoodsSize = result;
                $('.M-box-myBrowseHistoryModalList').pagination({
                    mode: 'fixed',
                    pageCount: Math.ceil(myBrowseHistoryModal_idleGoodsSize / myBrowseHistoryModal_pageSize),
                    showData: myBrowseHistoryModal_pageSize,
                    activeCls: 'btn-box-active',  //当前项css
                    prevContent: '上一页',
                    nextContent: '下一页',
                    callback: function (api) {
                        myBrowseHistoryModal_getPageIdleGoodsItem(api.getCurrent());
                    }
                });
            },
        });
    }


    function myBrowseHistoryModal_getPageIdleGoodsItem(pageNum) {
        $.ajax({
            type: "post",
            url: "mybrowsehistory",
            data: {
                pageNum: pageNum,
                pageSize: myBrowseHistoryModal_pageSize,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                // console.log(result);
                myBrowseHistoryModal_idleGoodsList = JSON.parse(result);
                let $myBrowseHistoryModalList = $("#myBrowseHistoryModalList");
                let myBrowseHistoryModal_str = "";
                $("#myBrowseHistoryModalList .box").remove();
                for (let i = 0; i < myBrowseHistoryModal_idleGoodsList.length; i++) {
                    myBrowseHistoryModal_str += "<div class=\"box\" " + (myBrowseHistoryModal_idleGoodsList[i].goodsStatus != "1" ? "style=\"background-image: url('assets/images/watermark.png')\"" : "") + ">\n" +
                        "<div class=\"job_content-box\">\n" +
                        "<div class=\"img-box\"><img src=" + myBrowseHistoryModal_idleGoodsList[i].goodsCoverImgDir + " alt=\"\"></div>\n" +
                        "<div class=\"detail-box\">\n" +
                        "<h5><a href=\"idlegooddetail.jsp?goodsId=" + myBrowseHistoryModal_idleGoodsList[i].goodsId + "\" style='max-width: 455px; display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #303841'>" + myBrowseHistoryModal_idleGoodsList[i].goodsName + "</a></h5>\n" +
                        "<div class=\"detail-info\">\n" +
                        "<h6><i class=\"fa fa-user-circle-o\" aria-hidden=\"true\"></i><span>" + myBrowseHistoryModal_idleGoodsList[i].user.userName + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-map-marker\" aria-hidden=\"true\"></i><span>" + myBrowseHistoryModal_idleGoodsList[i].goodsProvince + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-money\" aria-hidden=\"true\"></i><span>￥" + myBrowseHistoryModal_idleGoodsList[i].goodsPrice + "/RMB</span></h6>\n" +
                        "</div></div></div>\n" +
                        "<div class=\"option-box\">\n" +
                        "<button class=\"fav-btn\"><i " + "data-good_id='" + myBrowseHistoryModal_idleGoodsList[i].goodsId + "' " + " class=\"fa " + (myBrowseHistoryModal_idleGoodsList[i].collected ? "fa-heart" : "fa-heart-o") + "\" aria-hidden=\"true\"\n" +
                        "onclick=\"collect(this)\"></i>\n" +
                        "</button>\n" +
                        "<a href=\"idlegooddetail.jsp?goodsId=" + myBrowseHistoryModal_idleGoodsList[i].goodsId + "\" class=\"apply-btn\">查看</a>\n" +
                        "</div></div>\n";
                }
                $myBrowseHistoryModalList.prepend(myBrowseHistoryModal_str);
            }
        });
    }
</script>

<%--收藏夹--%>
<script type="text/javascript">
    // 当前页展示条数，默认3条
    let myCollectedModal_pageSize = 3;
    // 总条数
    let myCollectedModal_idleGoodsSize = 72;

    let myCollectedModal_idleGoodsList = null;

    function myCollectedModal_initPage() {
        myCollectedModal_getPageIdleGoodsItem(1);
        $.ajax({
            type: "post",
            url: "mycollected",
            async: false,
            data: {
                pageNum: -1,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                myCollectedModal_idleGoodsSize = result;
                $('.M-box-myCollectedModalList').pagination({
                    mode: 'fixed',
                    pageCount: Math.ceil(myCollectedModal_idleGoodsSize / myCollectedModal_pageSize),
                    showData: myCollectedModal_pageSize,
                    activeCls: 'btn-box-active',  //当前项css
                    prevContent: '上一页',
                    nextContent: '下一页',
                    callback: function (api) {
                        myCollectedModal_getPageIdleGoodsItem(api.getCurrent());
                    }
                });
            },
        });
    }


    function myCollectedModal_getPageIdleGoodsItem(pageNum) {
        $.ajax({
            type: "post",
            url: "mycollected",
            data: {
                pageNum: pageNum,
                pageSize: myCollectedModal_pageSize,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                // console.log(result);
                myCollectedModal_idleGoodsList = JSON.parse(result);
                let $myCollectedModalList = $("#myCollectedModalList");
                let myCollectedModal_str = "";
                $("#myCollectedModalList .box").remove();
                for (let i = 0; i < myCollectedModal_idleGoodsList.length; i++) {
                    myCollectedModal_str += "<div class=\"box\" " + (myCollectedModal_idleGoodsList[i].goodsStatus != "1" ? "style=\"background-image: url('assets/images/watermark.png')\"" : "") + ">\n" +
                        "<div class=\"job_content-box\">\n" +
                        "<div class=\"img-box\"><img src=" + myCollectedModal_idleGoodsList[i].goodsCoverImgDir + " alt=\"\"></div>\n" +
                        "<div class=\"detail-box\">\n" +
                        "<h5><a href=\"idlegooddetail.jsp?goodsId=" + myCollectedModal_idleGoodsList[i].goodsId + "\" style='max-width: 455px; display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #303841'>" + myCollectedModal_idleGoodsList[i].goodsName + "</a></h5>\n" +
                        "<div class=\"detail-info\">\n" +
                        "<h6><i class=\"fa fa-user-circle-o\" aria-hidden=\"true\"></i><span>" + myCollectedModal_idleGoodsList[i].user.userName + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-map-marker\" aria-hidden=\"true\"></i><span>" + myCollectedModal_idleGoodsList[i].goodsProvince + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-money\" aria-hidden=\"true\"></i><span>￥" + myCollectedModal_idleGoodsList[i].goodsPrice + "/RMB</span></h6>\n" +
                        "</div></div></div>\n" +
                        "<div class=\"option-box\">\n" +
                        "<button class=\"fav-btn\"><i " + "data-good_id='" + myCollectedModal_idleGoodsList[i].goodsId + "' " + " class=\"fa " + (myCollectedModal_idleGoodsList[i].collected ? "fa-heart" : "fa-heart-o") + "\" aria-hidden=\"true\"\n" +
                        "onclick=\"collect(this)\"></i>\n" +
                        "</button>\n" +
                        "<a href=\"idlegooddetail.jsp?goodsId=" + myCollectedModal_idleGoodsList[i].goodsId + "\" class=\"apply-btn\">查看</a>\n" +
                        "</div></div>\n";
                }
                $myCollectedModalList.prepend(myCollectedModal_str);
            }
        });
    }
</script>

<%--查看我买到的闲置品--%>
<script type="text/javascript">
    // 当前页展示条数，默认3条
    let myBoughtModal_pageSize = 3;
    // 总条数
    let myBoughtModal_idleGoodsSize = 72;

    let myBoughtModal_idleGoodsList = null;

    function myBoughtModal_initPage() {
        myBoughtModal_getPageIdleGoodsItem(1);
        $.ajax({
            type: "post",
            url: "getmyorderslist",
            async: false,
            data: {
                pageNum: -1,
                flag: 1,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                myBoughtModal_idleGoodsSize = result;
                $('.M-box-myBoughtModalList').pagination({
                    mode: 'fixed',
                    pageCount: Math.ceil(myBoughtModal_idleGoodsSize / myBoughtModal_pageSize),
                    showData: myBoughtModal_pageSize,
                    activeCls: 'btn-box-active',  //当前项css
                    prevContent: '上一页',
                    nextContent: '下一页',
                    callback: function (api) {
                        myBoughtModal_getPageIdleGoodsItem(api.getCurrent());
                    }
                });
            },
        });
    }


    function myBoughtModal_getPageIdleGoodsItem(pageNum) {
        $.ajax({
            type: "post",
            url: "getmyorderslist",
            data: {
                pageNum: pageNum,
                pageSize: myBoughtModal_pageSize,
                userId: "<%=user.getUserId()%>"
            },
            success: function (result) {
                myBoughtModal_idleGoodsList = JSON.parse(result);
                let $myBoughtModalList = $("#myBoughtModalList");
                let myBoughtModal_str = "";
                $("#myBoughtModalList .box").remove();
                for (let i = 0; i < myBoughtModal_idleGoodsList.length; i++) {
                    // 对于买到的商品，区分其订单状态，若已支付直接提醒用户即可，否则跳转确认支付界面
                    let paymentStatus = myBoughtModal_idleGoodsList[i].orderStatus == "30" ? "myBoughtModal_confirmPayment('" + myBoughtModal_idleGoodsList[i].goodsId + "', " + myBoughtModal_idleGoodsList[i].goodsPrice + ", '" + myBoughtModal_idleGoodsList[i].orderId + "')" :
                        myBoughtModal_idleGoodsList[i].orderStatus == "0" ?
                            "bs4pop.notice('已取消！', {type: 'success'})" :
                            "bs4pop.notice('已支付！', {type: 'success'})";
                    myBoughtModal_str += "<div class=\"box\" " + (myBoughtModal_idleGoodsList[i].goodsStatus != "1" ? "style=\"background-image: url('assets/images/watermark.png')\"" : "") + ">\n" +
                        "<div class=\"job_content-box\">\n" +
                        "<div class=\"img-box\"><img src=" + myBoughtModal_idleGoodsList[i].goodsCoverImgDir + " alt=\"\"></div>\n" +
                        "<div class=\"detail-box\">\n" +
                        "<h5><a href=\"idlegooddetail.jsp?goodsId=" + myBoughtModal_idleGoodsList[i].goodsId + "\" style='max-width: 455px; display: block; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; color: #303841'>" + myBoughtModal_idleGoodsList[i].goodsName + "</a></h5>\n" +
                        "<div class=\"detail-info\">\n" +
                        "<h6><i class=\"fa fa-user-circle-o\" aria-hidden=\"true\"></i><span>" + myBoughtModal_idleGoodsList[i].user.userName + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-map-marker\" aria-hidden=\"true\"></i><span>" + myBoughtModal_idleGoodsList[i].goodsProvince + "</span></h6>\n" +
                        "<h6><i class=\"fa fa-money\" aria-hidden=\"true\"></i><span>￥" + myBoughtModal_idleGoodsList[i].goodsPrice + "/RMB</span></h6>\n" +
                        "</div></div></div>\n" +
                        "<div class=\"option-box\">\n" +
                        "<a style='cursor:pointer; margin-right: 15px' class='apply-btn' onclick=\"" + paymentStatus + "\" data-dismiss=\"modal\">订单状态</a>\n" +
                        "<a style='cursor:pointer; margin-right: 15px' class='apply-btn' onclick=\"closeOrder('" + myBoughtModal_idleGoodsList[i].goodsId + "', '" + myBoughtModal_idleGoodsList[i].orderId + "')\" data-dismiss=\"modal\">关闭订单</a>\n" +
                        "</div></div>\n";
                }
                $myBoughtModalList.prepend(myBoughtModal_str);
            }
        });
    }

    // 确认支付界面
    function myBoughtModal_confirmPayment(goodsId, goodsPrice, orderId) {
        bs4pop.prompt('订单已创建！请输入密码确认支付', '请输入登录密码', function (sure, value) {
            if (sure) {
                var passwd = md5(value);
                $.ajax({
                    type: "post",
                    url: "submitorder",
                    async: false,
                    data: {
                        passwd: passwd,
                        goodsId: goodsId,
                        userId: "<%=user.getUserId()%>",
                        goodsPrice: goodsPrice,
                        orderId: orderId
                    },
                    success: function (result) {
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

    // 关闭订单
    function closeOrder(goodsId, orderId) {
        bs4pop.confirm('你确定要关闭此订单吗？', function (sure) {
            if (sure) {
                $.ajax({
                    type: "post",
                    url: "closeorder",
                    async: false,
                    data: {
                        goodsId: goodsId,
                        orderId: orderId
                    },
                    success: function (result) {
                        if (result == "1") {
                            // 支付成功
                            bs4pop.notice('订单关闭成功！', {type: 'success'});
                        } else if (result == "2") {
                            bs4pop.notice('订单关闭失败！请重试！', {type: 'danger'});
                        }
                    },
                });
            } else {
                // 取消关闭
                bs4pop.notice('取消关闭订单！', {type: 'success'});
            }
        });
    }
</script>

<%--每次刷新页面，查看是否有消息需要提醒用户--%>
<script type="text/javascript">
    <%--若已发布闲置品被拍走，提醒用户--%>
    $.ajax({
        type: "post",
        url: "myidlegoodsstatus",
        async: false,
        data: {
            userId: "<%=user.getUserId()%>"
        },
        success: function (result) {
            let myIdleGoodsSold = JSON.parse(result);
            for (let i = 0; i < myIdleGoodsSold.length; i++) {
                bs4pop.notice("您的闲置品：" + myIdleGoodsSold[i].goodsName + "已卖出！请到我发布的商品中查看。", {position: 'bottomright'});
            }
        },
    });

    <%--若已发布闲置品被评论，提醒用户--%>
    $.ajax({
        type: "post",
        url: "getidlegoodsorderscancel",
        async: false,
        data: {
            userId: "<%=user.getUserId()%>"
        },
        success: function (result) {
            console.log(result);
            let myIdleGoodsSold = JSON.parse(result);
            for (let i = 0; i < myIdleGoodsSold.length; i++) {
                bs4pop.notice("您的闲置品：" + myIdleGoodsSold[i].goodsName + "的订单已被取消！请到我发布的查看。", {position: 'bottomright'});
            }
        },
    });

    <%--若已卖出闲置品订单被取消，提醒用户，并重新将闲置品状态置为出售中--%>
    $.ajax({
        type: "post",
        url: "getidlegoodsrated",
        async: false,
        data: {
            userId: "<%=user.getUserId()%>"
        },
        success: function (result) {
            console.log(result);
            let myIdleGoodsSold = JSON.parse(result);
            for (let i = 0; i < myIdleGoodsSold.length; i++) {
                bs4pop.notice("您的闲置品：" + myIdleGoodsSold[i].goodsName + "被评价！请到我商品详情页查看。", {position: 'bottomright'});
            }
        },
    });
</script>