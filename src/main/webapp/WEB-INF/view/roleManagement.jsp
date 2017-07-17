<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
    <base href="<%=basePath%>"></base>
    <title>角色管理</title>
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
        .preBtnShow{
            margin-right: 5px;
            margin-bottom: 5px;
        }

    </style>
    <script>
        var ID;
        $(document).ready(function(){
            $(".deleteBtn").each(function(){
                $(this).click(function(){
                    ID = $(this).attr("name");
                    document.getElementById("ID_SHOW").innerHTML ="ID:"+ID;
                    $("#deleteID").attr("value",ID);

                })
            });
            $(".editBtn").each(function(){
                $(this).click(function(){
                    ID = $(this).attr("name");
                    $("#editID").attr("value",ID);
                })
            });
            $(".preBtn").each(function(){
                $(this).click(function(){
                    ID = $(this).attr("name");

                })


            });

            $(document).on("click",".preBtnShow",function(){
                $(this).click(function(){
                    $(this).toggleClass("btn-info");
                })
            });
            $("#inputPreChance").click(function () {


                var permissionList=new Array();
                permissionList.push(ID);
                $(".preBtnShow").each(function () {

                    if($(this).hasClass("btn-info")){
                        permissionList.push($(this).attr("id"));
                    }
                });
                $.ajax({

                    url:"permission/updatePermissionJson",
                    data:"permissionList="+permissionList,
                    type:"GET",
                    success:function (){
                        $("#closePreChance").click();
                    }
                });
            });
            

            $(".preBtn").each(function(){
                $(this).click(function(){
                    $("#perHandler").empty();
                    $("#perHandler").append("<h5></h5>").append("你没有获得该权限！");
                    ID = $(this).attr("name");
                    $("#editID").attr("value",ID);
                    $.ajax({
                        url:"permission/getPermissionJson",
                        data:"ID="+ID,
                        type:"GET",
                        success:function (result) {
                            var perList=result.extend.permissionJsonList;
                            $("#perHandler").empty();
                            $.each(perList,function (index,item) {
                                var isExit=item.exit;
                                if(isExit==false){
                                    var preBtn=$("<button></button>")
                                        .addClass("btn preBtnShow")
                                        .attr("type","button")
                                        .attr("id",item.permission.id)
                                        .append(item.permission.name);
                                    $("#perHandler").append(preBtn);
                                }
                                else{
                                    var preBtn=$("<button></button>")
                                        .addClass("btn preBtnShow btn-info")
                                        .attr("type","button")
                                        .attr("id",item.permission.id)
                                        .append(item.permission.name);
                                    $("#perHandler").append(preBtn);
                                }
                            });
                        }
                    });
                })
            });
        });
    </script>
</head>
<body>
<div class="container">
    <div class="row">
        <div class="jumbotron" style="color: inherit">
            <div class="container" align="center" style="color: inherit">
                <h2 class="text-info" style="font-family:宋体;font-weight:bold;font-size:49px">角色管理</h2>
                <br>
                <div class="text-muted">恭喜您，你有角色浏览的权限</div>
                <br>
                <br>
                <p><a role="button" href="user/index" class="btn btn-success">返回首页</a></p>
            </div>
        </div>
    </div>

    <div class="modal fade" id="preModal" tabindex="-1" role="dialog" aria-labelledby="preModalLabel">
        <div class="modal-dialog">
            <div class="modal-content">
                <form role="form" action="role/roleAdd" method="post">
                    <div class="modal-header">
                        <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">权限分配</h4>
                    </div>
                    <div class="modal-body" id="perHandler">

                    </div>
                    <div class="modal-footer">
                        <button id="closePreChance" data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                        <button id="inputPreChance"class="btn btn-primary" type="button">提交</button>
                    </div>
                </form>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div>
        <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form role="form" action="role/roleAdd" method="post">
                        <div class="modal-header">
                            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">角色添加</h4>
                        </div>
                        <div class="modal-body">
                            <p>角色代码</p>
                            <input class="form-control" type="text" name="sn"></input>
                        </div>
                        <div class="modal-body">
                            <p>角色名</p>
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

        <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form role="form" action="role/roleEdit" method="post">
                        <div class="modal-header">
                            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">角色编辑</h4>
                        </div>
                        <div class="modal-body">
                            <p>ID</p>
                            <input id="editID" name="id" readonly="readonly" class="form-control" type="text" name="expression" ></input>
                        </div>
                        <div class="modal-body">
                            <p>角色代号</p>
                            <input class="form-control" type="text" name="sn" ></input>
                        </div>
                        <div class="modal-body">
                            <p>角色名</p>
                            <input class="form-control" type="text" name="name"></input>
                        </div>
                        <div class="modal-footer">
                            <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                            <button class="btn btn-primary" type="submit">提交</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form role="form" action="role/roleDelete" method="post">
                        <div class="modal-header">
                            <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                            <h4 class="modal-title">确定删除角色吗？</h4>
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
        <div class="col-md-3 col-md-offset-9" style="margin-bottom: 10px">
            <button class="btn btn-primary glyphicon glyphicon-plus" data-toggle="modal" data-target="#addModal">增加</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover table table-striped" >
                <tr><th>ID</th>
                    <th>角色序列号</th>
                    <th>角色名</th>
                    <th>操作</th></tr>

                <c:forEach items="${pageInfo.list}" var="role">
                    <tr><th>${role.id}</th>
                        <th>${role.sn}</th>
                        <th>${role.name}</th>
                        <th>
                            <button name="${role.id}" class="preBtn btn btn-info glyphicon glyphicon-eye-open btn-sm" data-toggle="modal" data-target="#preModal"> 权限分配</button>
                            <c:choose>
                                <c:when test="${fn:contains(role.name,'系统管理员')||fn:contains(role.name,'管理员')||fn:contains(role.name,'普通用户')}">
                                    <button class="editBtn btn btn-warning glyphicon glyphicon-cog btn-sm disabled" >禁止编辑</button>
                                    <button class="deleteBtn btn btn-danger glyphicon glyphicon-trash btn-sm disabled">禁止删除</button>
                                </c:when>
                                <c:otherwise>
                                    <button name="${role.id}" class="editBtn btn btn-warning glyphicon glyphicon-cog btn-sm" data-toggle="modal" data-target="#editModal">编辑</button>
                                    <button name="${role.id}" class="deleteBtn btn btn-danger glyphicon glyphicon-trash btn-sm" data-toggle="modal" data-target="#deleteModal">删除</button>
                                </c:otherwise>
                            </c:choose>


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
                    <li><a href="${ pageContext.request.contextPath }/homePage/roleManagement?pn=1">首页</a></li>
                    <li>
                        <a href="${ pageContext.request.contextPath }/homePage/roleManagement?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                        <c:if test="${index==pageInfo.pageNum}">
                            <li class="active"><a href="${ pageContext.request.contextPath }/homePage/roleManagement?pn=${index}">${index}</a></li>
                        </c:if>
                        <c:if test="${index!=pageInfo.pageNum}">
                            <li><a href="${ pageContext.request.contextPath }/homePage/roleManagement?pn=${index}">${index}</a></li>
                        </c:if>
                    </c:forEach>

                    <li>
                        <a href="${ pageContext.request.contextPath }/homePage/roleManagement?pn=${pageInfo.pageNum+1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                    <li><a href="${ pageContext.request.contextPath }/homePage/roleManagement?pn=${pageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>

    </div>
</div>
</body>
</html>
