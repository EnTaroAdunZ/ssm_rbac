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
    <title>权限管理</title>
    <script src="${APP_PATH}/assets/js/jquery-1.11.1.min.js"></script>
    <link href="${APP_PATH}/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/assets/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="jumbotron col-md-12" style="color: inherit" >
            <div class="container" align="center" style="color: inherit">
                <h2 class="text-info" style="font-family:宋体;font-weight:bold;font-size:49px">权限管理</h2>
                <br>
                <div class="text-muted">恭喜您，你有权限浏览的权限</div>
                <br>
                <br>
                <p><a role="button" href="personalHomepage" class="btn btn-success">返回首页</a></p>
            </div>
        </div>
    </div>

    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title">添加权限</h4>
                </div>
                <div class="modal-body">
                    <p>权限标识符</p>
                    <textarea class="form-control"></textarea>
                </div>
                <div class="modal-body">
                    <p>权限名</p>
                    <textarea class="form-control"></textarea>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                    <a href="/permission/permissionAdd"><button class="btn btn-primary" type="button">提交</button></a>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>

    <div class="row">
        <div class="col-md-3 col-md-offset-9" style="margin-bottom: 10px">
            <button class="btn btn-primary glyphicon glyphicon-plus" data-toggle="modal" data-target="#addModal">增加</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table table-striped" >
                <tr><th>ID</th>
                    <th>权限标识符</th>
                    <th>权限名</th>
                    <th>操作</th></tr>

                <c:forEach items="${pageInfo.list}" var="permission">
                    <tr><th>${permission.id}</th>
                        <th>${permission.expression}</th>
                        <th>${permission.name}</th>
                        <th>
                            <button class="btn btn-warning glyphicon glyphicon-cog btn-sm">编辑</button>
                            <button class="btn glyphicon glyphicon-trash btn-sm disabled">禁止删除</button>
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
