<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/12/13
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%--顶部导航条，登录状态均为此头部--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
                        <a class="nav-link" href="userIndex.jsp">主页</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="idlegoodlists.jsp">闲置品</a>
                    </li>
                </ul>

                <!-- 最右侧用户按钮 -->
                <div class="user_option">
                    <div class="dropdown">
                        <a class="nav-link" id="userMenu" data-toggle="dropdown" aria-haspopup="true"
                           style="cursor:pointer;" aria-expanded="true">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </a>
                        <ul class="dropdown-menu" aria-labelledby="userMenu">
                            <li style="text-align: center">
                                <a class="dropdown-item" style="cursor:pointer;" data-toggle="modal"
                                   data-target="#personMessModal">个人设置</a>
                            </li>
                            <li style="text-align: center">
                                <a class="dropdown-item" style="cursor:pointer;" data-toggle="modal"
                                   data-target="#myReleasedModal" onclick="myReleasedModal_initPage()">我发布的</a>
                            </li>
                            <li style="text-align: center">
                                <a class="dropdown-item" style="cursor:pointer;" data-toggle="modal"
                                   data-target="#releaseIdeaModal" onclick="initRootType()">发布闲置物</a>
                            </li>
                            <li style="text-align: center">
                                <a class="dropdown-item" style="cursor:pointer;" data-toggle="modal"
                                   data-target="#myBrowseHistoryModal"
                                   onclick="myBrowseHistoryModal_initPage()">浏览记录</a>
                            </li>
                            <li style="text-align: center">
                                <a class="dropdown-item" style="cursor:pointer;" data-toggle="modal"
                                   data-target="#myCollectedModal" onclick="myCollectedModal_initPage()">收藏夹</a>
                            </li>
                            <li style="text-align: center">
                                <a class="dropdown-item" style="cursor:pointer;" data-toggle="modal"
                                   data-target="#myBoughtModal" onclick="myBoughtModal_initPage()">我买到的</a>
                            </li>
                            <li style="text-align: center">
                                <a class="dropdown-item"
                                   style="cursor:pointer;"
                                   onclick="quit()">退出</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
    </div>
</header>

<!-- 个人信息设置模态框 -->
<div class="modal fade" id="personMessModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">个人信息</h4>
                <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body" id="PerModalbody">
                <form style="padding: 0 30px;">
                    <div class="form-row">
                        <div class="form-group  col-md-6">
                            <label for="userId">用户ID</label>
                            <input id="userId" type="text" class="form-control form-control-sm" disabled
                                   value=${user.userId}>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="userLoginId">登入账号</label>
                            <input id="userLoginId" type="text" class="form-control form-control-sm"
                                   value=${user.userLoginId}>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="username">用户名</label>
                            <input id="username" type="text" class="form-control form-control-sm"
                                   value=${user.userName}>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="email">用户邮箱</label>
                            <input id="email" type="text" class="form-control form-control-sm"
                                   value=${user.userEmail}>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group  col-md-6">
                            <label for="phoneNumber">用户电话</label>
                            <input id="phoneNumber" type="text" class="form-control form-control-sm"
                                   value=${user.userPhoneNum}>
                        </div>
                        <div class="form-group col-md-6">
                            <label>注册时间</label>
                            <input type="text" class="form-control form-control-sm" disabled
                                   value=${user.userRegisterDate.toLocaleString()}>
                        </div>
                    </div>
                </form>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="modifyPerMess()">确定
                </button>
            </div>

        </div>
    </div>
</div>

<!-- 发布闲置物模态框 -->
<div class="modal fade" id="releaseIdeaModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">发布闲置物</h4>
                <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body" id="releaseIdeaModalBody">
                <form style="padding: 0 30px;" id="releaseForm">
                    <div class="form-group">
                        <label for="ideaTitle" style="text-align: center">标题</label>
                        <input class="form-control form-control-sm" id="ideaTitle"
                               placeholder="请输入闲置物标题"/>
                    </div>
                    <div class="form-row">
                        <div class="form-group  col-md-3">
                            <label style="text-align: center">分类</label>
                            <select class="form-control" id="rootType" style="z-index: 999;" onchange="initSonType(1)">
                                <option value="请选择">请选择</option>
                            </select>
                        </div>
                        <div class="form-group  col-md-3" id="sonType1" style="display: none">
                            <label style="text-align: center">子分类</label>
                            <select class="form-control" onchange="initSonType(2)">
                                <option value="请选择">请选择</option>
                            </select>
                        </div>
                        <div class="form-group  col-md-3" id="sonType2" style="display: none">
                            <label style="text-align: center">子分类</label>
                            <select class="form-control" onchange="initSonType(3)">
                                <option value="请选择">请选择</option>
                            </select>
                        </div>
                        <div class="form-group  col-md-3" id="sonType3" style="display: none">
                            <label style="text-align: center">子分类</label>
                            <select class="form-control">
                                <option value="请选择">请选择</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group  col-md-4">
                            <label for="ideaPrice" style="text-align: center">价格</label>
                            <input class="form-control form-control-sm" id="ideaPrice" placeholder="请输入闲置物标价"/>
                        </div>
                        <div class="form-group col-md-8">
                            <label for="ideaTips" style="text-align: center">标签</label>
                            <input class="form-control form-control-sm" id="ideaTips" placeholder="请输入闲置物标签"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="ideaTitle" style="text-align: center">闲置物所在地</label>
                        <input class="form-control form-control-sm" id="ideaProvince"
                               placeholder="请输入闲置物所在地，格式为“省-市-区”，eg:“浙江省-杭州市-余杭区”"/>
                    </div>
                    <div class="form-group">
                        <label for="ideaIntroduce" style="text-align: center">内容</label>
                        <div id="ideaIntroduce" class="toolbar" style="z-index: 100 !important;"></div>
                    </div>
                </form>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" data-dismiss="modal" onclick="releaseIdea()">发布
                </button>
            </div>

        </div>
    </div>
</div>

<!-- 我发布闲置物模态框 -->
<div class="modal fade" id="myReleasedModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">我发布的</h4>
                <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body" id="myReleasedModalBody">
                <section class="job_section" style="margin-top: -30px">
                    <div class="container">
                        <div class="job_container">
                            <div class="tab-content">
                                <div class="job_board tab-pane fade show active" id="myReleasedModalList"
                                     role="tabpanel"
                                     aria-labelledby="jb-1-tab">

                                </div>
                            </div>
                        </div>
                        <div class="btn-box M-box-myReleasedModalList"><a href="">下一页</a></div>
                    </div>
                </section>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>

        </div>
    </div>
</div>

<!-- 浏览记录模态框 -->
<div class="modal fade" id="myBrowseHistoryModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">浏览记录</h4>
                <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body" id="myBrowseHistoryModalBody">
                <section class="job_section" style="margin-top: -30px">
                    <div class="container">
                        <div class="job_container">
                            <div class="tab-content">
                                <div class="job_board tab-pane fade show active" id="myBrowseHistoryModalList"
                                     role="tabpanel"
                                     aria-labelledby="jb-1-tab">

                                </div>
                            </div>
                        </div>
                        <div class="btn-box M-box-myBrowseHistoryModalList"><a href="">下一页</a></div>
                    </div>
                </section>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>

        </div>
    </div>
</div>

<!-- 收藏夹模态框 -->
<div class="modal fade" id="myCollectedModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">收藏夹</h4>
                <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body" id="myCollectedModalBody">
                <section class="job_section" style="margin-top: -30px">
                    <div class="container">
                        <div class="job_container">
                            <div class="tab-content">
                                <div class="job_board tab-pane fade show active" id="myCollectedModalList"
                                     role="tabpanel"
                                     aria-labelledby="jb-1-tab">

                                </div>
                            </div>
                        </div>
                        <div class="btn-box M-box-myCollectedModalList"><a href="">下一页</a></div>
                    </div>
                </section>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>

        </div>
    </div>
</div>

<!-- 我买到的置物模态框 -->
<div class="modal fade" id="myBoughtModal">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- 模态框头部 -->
            <div class="modal-header">
                <h4 class="modal-title">我买到的</h4>
                <a class="close" data-dismiss="modal" style="cursor:pointer;">&times;</a>
            </div>

            <!-- 模态框主体 -->
            <div class="modal-body" id="myBoughtModalBody">
                <section class="job_section" style="margin-top: -30px">
                    <div class="container">
                        <div class="job_container">
                            <div class="tab-content">
                                <div class="job_board tab-pane fade show active" id="myBoughtModalList"
                                     role="tabpanel"
                                     aria-labelledby="jb-1-tab">

                                </div>
                            </div>
                        </div>
                        <%--myReleased--%>
                        <div class="btn-box M-box-myBoughtModalList"><a href="">下一页</a></div>
                    </div>
                </section>
            </div>

            <!-- 模态框底部 -->
            <div class="modal-footer">
                <button type="button" class="btn btn-success" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>