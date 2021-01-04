<%--
  Created by IntelliJ IDEA.
  User: 12061
  Date: 2020/10/9
  Time: 19:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <title>服务器错误500</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <%
        String path = "/jsp";
    %>
    <link rel="stylesheet" href="/assets/css/bootstrap.css">

    <link rel="stylesheet" href="css/style.css">

</head>
<body>

<%@include file="errorcommon.jsp" %>
<div class="col-md-6 align-self-center">
    <h1>500</h1>
    <h2>UH OH! 服务器错误</h2>
    <p>我们正在努力解决500错误。你可以点击下面的按钮，返回主页。
    </p>
    <a href="/jsp">
        <button class="btn green">返回首页</button>
    </a>
</div>
</div>
</div>
</main>

<script src="js/gsap.min.js"></script>
<script src="js/script.js"></script>


</body>
</html>
