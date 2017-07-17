<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<base href="<%=basePath%>"></base>
<html>
<head>
    <title>权限管理</title>
    <script src="${APP_PATH}/assets/js/jquery-1.11.1.min.js"></script>
    <link href="${APP_PATH}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/assets/bootstrap/js/bootstrap.min.js"></script>
    <style>
        a {
            text-decoration:none;
            out-line: none;
            color: #ffffff
        }
        a:hover, a:visited, a:link, a:active {
            text-decoration:none;
            out-line: none;
            color:#ffffff
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="jumbotron col-lg-12" style="color: inherit" >
            <div class="container" align="center" style="color: inherit">
                <h2 class="text-info" style="font-family:宋体;font-weight:bold;font-size:49px">权限添加</h2>
                <br>
                <div class="text-muted">恭喜您，你有权限添加的权限</div>
                <br>
                <br>
                <p><a role="button" href="${APP_PATH}/homePage/permissionManagement" class="btn btn-success">返回上一层</a></p>
            </div>
        </div>
    </div>

</body>
</html>
