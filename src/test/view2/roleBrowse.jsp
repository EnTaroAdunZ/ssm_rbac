<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>权限添加</title>
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
                <h2 class="text-info" style="font-family:宋体;font-weight:bold;font-size:49px">用户の角色浏览</h2>
                <br>
                <div class="text-muted">恭喜您，你有浏览角色权限的能力</div>
                <br>
                <br>
                <p><a role="button" href="#" class="btn btn-success">返回上一层</a></p>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3 col-md-offset-9" style="margin-bottom: 10px">
            <button class="btn btn-primary glyphicon glyphicon-plus">增加</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table table-striped" >
                <tr><th>ID</th>
                    <th>角色代码</th>
                    <th>角色名</th>
                    <th>操作</th></tr>

                <c:forEach items="${pageInfo.list}" var="user">
                    <tr><th>${user.roleList[0].id}</th>
                        <th>${user.roleList[0].sn}</th>
                        <th>${user.roleList[0].name}</th>
                        <th>
                           <a href="${pageContext.request.contextPath}/role/permissionBrowse?wid=${user.roleList[0].id}">  <button class="btn btn-info glyphicon glyphicon-eye-open btn-sm"
                           >权限</button></a>
                            <button class="btn glyphicon glyphicon-trash btn-sm  btn-warning"> 删除</button>
                        </th></tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <div class="row">
        <div class="col-md-5">
            <span>当前页码:${pageInfo.pageNum}</span>
            <span>总页码:${pageInfo.pages}</span>
            <span>总记录数:${pageInfo.total}</span>
        </div>
        <div class="col-md-7">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=1">首页</a></li>
                    <li>
                        <a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                        <c:if test="${index==pageInfo.pageNum}">
                            <li class="active"><a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${index}">${index}</a></li>
                        </c:if>
                        <c:if test="${index!=pageInfo.pageNum}">
                            <li><a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${index}">${index}</a></li>
                        </c:if>
                    </c:forEach>

                    <li>
                        <a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li><a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>

    </div>
</div>
</body>
</html>
