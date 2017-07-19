<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>

    <base href="<%=basePath%>"/>
    <title>权限管理</title>
    <link rel="stylesheet" href="assets/css/style.default.css" type="text/css"/>
    <script src="assets/js/jquery-1.11.1.min.js"></script>
    <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <style>
        a {
            text-decoration: none;
            out-line: none;
            color: #ffffff
        }

        a:hover, a:visited, a:link, a:active {
            text-decoration: none;
            out-line: none;
            color: #ffffff
        }

        .leftBg {
            height: 100%;
            padding: 0px;
            background: #485b79;

        }

        #leftBg {
            top: 179px;
        }
    </style>
    <script>
        var ID;
        $(document).ready(function () {
            $(".deleteBtn").each(function () {
                $(this).click(function () {
                    ID = $(this).attr("name");
                    document.getElementById("ID_SHOW").innerHTML = "ID:" + ID;
                    console.log($("#deleteID").attr("name"));
                    $("#deleteID").attr("value", ID);
                })
            });
        });
        $(document).ready(function () {
            $(".editBtn").each(function () {
                $(this).click(function () {
                    ID = $(this).attr("name");
                    $("#editID").attr("value", ID);
                    //发送请求
                    $.ajax({
                        url: "permission/permissionEditShow",
                        data: "ID=" + ID,
                        type: "POST",
                        success: function (result) {
                            if (result.code == 100) {
                                var permission = result.extend.permission;
                                $("#editName").attr("value", permission.name);
                                $("#editExpression").attr("value", permission.expression);
                            } else {
                                //找不到数据处理
                            }
                        }
                    });
                })
            });
        });
    </script>
</head>
<body class="withvernav">
<div class="bodywrapper">
    <div class="topheader">
        <div class="left">
            <h1 class="logo">新日暮里.<span>研究所</span></h1>
            <span class="slogan">权限管理系统</span>

            <div class="search">
                <form action="" method="post">
                    <input type="text" name="keyword" id="keyword" value="请输入"/>
                    <button class="submitbutton"></button>
                </form>
            </div><!--search-->

            <br clear="all"/>

        </div><!--left-->

        <div class="right">
            <!--<div class="notification">
                <a class="count" href="ajax/notifications.html"><span>9</span></a>
            </div>-->
            <div class="userinfo">
                <img src="assets/img/avatar1.png" alt=""/>
                <span>尊敬的用户，欢迎您</span>
            </div><!--userinfo-->

        </div><!--right-->
    </div><!--topheader-->


    <div class="header">
        <ul class="headermenu">
            <li href=""><a href="homePage/userManagement"><span class="icon icon-flatscreen"></span>用户管理</a>
            </li>
            <li><a href="homePage/roleManagement"><span class="icon icon-pencil"></span>角色管理</a></li>
            <li  class="current"><a href="homePage/permissionManagement"><span class="icon icon-message"></span>权限管理</a></li>
            <li><a href=""><span class="icon icon-chart"></span>功能模拟</a></li>
        </ul>

        <div class="headerwidget">
            <div class="earnings">
                <div class="one_half">
                    <h4>论坛访问人数</h4>
                    <h2>6300</h2>
                </div><!--one_half-->
                <div class="one_half last alignright">
                    <h4>活跃比率</h4>
                    <h2>93%</h2>
                </div><!--one_half last-->
            </div><!--earnings-->
        </div><!--headerwidget-->

    </div><!--header-->

    <div class="vernav2 iconmenu leftBg" id="leftBg">

    </div><!--leftmenu-->
    <div class="centercontent">
        <div class="container-fiuled">
            <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form role="form" action="permission/permissionAdd" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">权限添加</h4>
                            </div>
                            <div class="modal-body">
                                <p>权限标识符</p>
                                <input class="form-control" type="text" name="expression"></input>
                            </div>
                            <div class="modal-body">
                                <p>权限名</p>
                                <input class="form-control" type="text" name="name"></input>
                            </div>
                            <div class="modal-footer">
                                <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                                <button class="btn btn-primary" type="submit">提交</button>
                            </div>
                        </form>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>


            <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form role="form" action="permission/permissionEdit" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">权限编辑</h4>
                            </div>
                            <div class="modal-body">
                                <p>ID</p>
                                <input id="editID" name="id" readonly="readonly" class="form-control" type="text"
                                       name="expression"></input>
                            </div>
                            <div class="modal-body">
                                <p>权限标识符</p>
                                <input id="editExpression" class="form-control" type="text" name="expression"></input>
                            </div>
                            <div class="modal-body">
                                <p>权限名</p>
                                <input id="editName" class="form-control" type="text" name="name"></input>
                            </div>
                            <div class="modal-footer">
                                <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                                <button class="btn btn-primary" type="submit">提交</button>
                            </div>
                        </form>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>

            <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form role="form" action="permission/permissionDelete" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">确定删除权限吗？</h4>
                            </div>
                            <input id="deleteID" name="ID" type="hidden" value="">
                            <div class="modal-body">
                                <p id="ID_SHOW"></p>
                            </div>
                            <div class="modal-footer">
                                <button data-dismiss="modal" class="btn btn-info" type="button">取消</button>
                                <button class="btn btn-danger" type="submit">确定</button>
                            </div>
                        </form>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>



            <div class="row">
                <div class="col-md-12 ">
                    <table class="table table-hover table table-striped">
                        <tr>
                            <th>ID</th>
                            <th>权限标识符</th>
                            <th>权限名</th>
                            <th>操作</th>
                        </tr>

                        <c:forEach items="${pageInfo.list}" var="permission">
                            <tr>
                                <th>${permission.id}</th>
                                <th>${permission.expression}</th>
                                <th>${permission.name}</th>
                                <th>
                                    <c:choose>
                                        <c:when test="${fn:contains(permission.expression,'com.etop')}">
                                            <button class="btn btn-warning glyphicon glyphicon-cog btn-sm disabled">
                                                禁止编辑
                                            </button>
                                            <button class="btn btn-danger glyphicon glyphicon-trash btn-sm disabled">
                                                禁止删除
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button name="${permission.id}"
                                                    class="editBtn   btn btn-warning glyphicon glyphicon-cog btn-sm"
                                                    data-toggle="modal" data-target="#editModal">编辑
                                            </button>
                                            <button name="${permission.id}"
                                                    class="deleteBtn btn btn-danger glyphicon glyphicon-cog btn-sm"
                                                    data-toggle="modal" data-target="#deleteModal">删除
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </th>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
            <div class="row">
                <div class="col-md-2">
                    <button class="btn btn-primary glyphicon glyphicon-plus" data-toggle="modal"
                            data-target="#addModal">增加
                    </button>
                </div>
                <div class="col-md-4">
                    <button type="button" class="btn btn-info">当前页码:${pageInfo.pageNum}</button>
                    <button type="button" class="btn btn-info">总页码:${pageInfo.pages}</button>
                    <button type="button" class="btn btn-info">总记录数:${pageInfo.total}</button>
                </div>
                <div class="col-md-6">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <li><a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=1">首页</a>
                            </li>
                            <li>
                                <a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${pageInfo.pageNum-1}"
                                   aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                                <c:if test="${index==pageInfo.pageNum}">
                                    <li class="active"><a
                                            href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${index}">${index}</a>
                                    </li>
                                </c:if>
                                <c:if test="${index!=pageInfo.pageNum}">
                                    <li>
                                        <a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${index}">${index}</a>
                                    </li>
                                </c:if>
                            </c:forEach>

                            <li>
                                <a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${pageInfo.pageNum+1}"
                                   aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <li>
                                <a href="${ pageContext.request.contextPath }/homePage/permissionManagement?pn=${pageInfo.pages}">末页</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
