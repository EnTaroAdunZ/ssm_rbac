<%@ page isELIgnored="false" contentType="text/html;charset=UTF-8" language="java" %>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
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
    <title>用户管理</title>
    <script src="assets/js/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="assets/css/style.default.css" type="text/css"/>

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

        .roleBtnShow {
            margin-right: 5px;
            margin-bottom: 5px;
        }

        .leftBg {
            height: 100%;
            padding: 0px;
            background: #485b79;

        }

        #leftBg {
            top: 179px;
        }
        .ajax_btn{
            margin-right: 5px;
        }
    </style>
    <script>
        var ID;
        var KW;

        $(document).ready(function () {
            window.onload =function() { KW=""; goToPage(KW,1) };
            $(document).on('click','.deleteBtn',function(){
                    ID = $(this).attr("name");
                    document.getElementById("ID_SHOW").innerHTML = "ID:" + ID;
                    $("#deleteID").attr("value", ID);
            });
            $(document).on('click','.editBtn',function(){
                    ID = $(this).attr("name");
                    $("#editID").attr("value", ID);
                    //发送后台请求
                    $.ajax({
                        url: "user/getUserById",
                        data: "ID=" + ID,
                        type: "POST",
                        success: function (result) {
                            var user = result.extend.user;
                            $("#editName").attr("value", user.name);
                            $("#editAccount").attr("value", user.account);
                            $("#editPassword").attr("value", user.password);
                            $("#editRePassword").attr("value", user.password);
                            $("#editPhone").attr("value", user.phone);
                            $("#editAge").attr("value", user.age);
                            $("#editExperience").attr("value", user.experience);

                        }
                    });
            });

//            $(".deleteBtn").each(function () {
//                $(this).click(function () {
//                    ID = $(this).attr("name");
//                    document.getElementById("ID_SHOW").innerHTML = "ID:" + ID;
//                    $("#deleteID").attr("value", ID);
//                })
//            });
//            $(".editBtn").each(function () {
//                $(this).click(function () {
//                    ID = $(this).attr("name");
//                    $("#editID").attr("value", ID);
//                    //发送后台请求
//                    $.ajax({
//                        url: "user/getUserById",
//                        data: "ID=" + ID,
//                        type: "POST",
//                        success: function (result) {
//                            var user = result.extend.user;
//                            $("#editName").attr("value", user.name);
//                            $("#editAccount").attr("value", user.account);
//                            $("#editPassword").attr("value", user.password);
//                            $("#editRePassword").attr("value", user.password);
//                            $("#editPhone").attr("value", user.phone);
//                            $("#editAge").attr("value", user.age);
//                            $("#editExperience").attr("value", user.experience);
//
//                        }
//                    });
//                })
//            });
//            $(".roleBtn").each(function () {
//                $(this).click(function () {
//                    ID = $(this).attr("name");
//
//                })
//            });

            $(document).on('click','.roleBtn',function(){
                ID = $(this).attr("name");
                $("#roleHandler").empty();
                $("#roleHandler").append("<h5></h5>").append("你没有获得该权限！");
                ID = $(this).attr("name");
                $("#editID").attr("value", ID);
                $.ajax({
                    url: "role/getRoleJson",
                    data: "ID=" + ID,
                    type: "GET",
                    success: function (result) {
                        var roleList = result.extend.roleJsons;
                        $("#roleHandler").empty();
                        $.each(roleList, function (index, item) {
                            var isExit = item.exit;
                            if (isExit == false) {
                                var roleBtn = $("<button></button>")
                                    .addClass("btn roleBtnShow")
                                    .attr("type", "button")
                                    .attr("id", item.role.id)
                                    .append(item.role.name);
                                $("#roleHandler").append(roleBtn);
                            }
                            else {
                                var roleBtn = $("<button></button>")
                                    .addClass("btn roleBtnShow btn-info")
                                    .attr("type", "button")
                                    .attr("id", item.role.id)
                                    .append(item.role.name);
                                $("#roleHandler").append(roleBtn);
                            }
                        });
                    }
                });

            });



            $(document).on("click", ".btn_page", function () {

                pn = $(this).attr("name");
                console.log("pn"+pn);
                goToPage(KW,pn);
            });

            $(document).on("click", ".roleBtnShow", function () {
                $(this).click(function () {
                    $(this).toggleClass("btn-info");
                })
            });
            $("#inputRoleChance").click(function () {
                var roleList = new Array();
                roleList.push(ID);
                $(".roleBtnShow").each(function () {
                    if ($(this).hasClass("btn-info")) {
                        roleList.push($(this).attr("id"));
                    }
                });
                $.ajax({
                    url: "role/updateRoleJson",
                    data: "roleList=" + roleList,
                    type: "GET",
                    success: function () {
                        $("#closeRoleChance").click();
                    }
                });
            });

            $('#keyword').bind('input oninput', function() {
                var KeyWord=$('#keyword').val();
                KW=KeyWord;
                goToPage(KeyWord,1);
            });

            function goToPage(KeyWord,pn) {
                $.ajax({
                    url: "user/getUserByKeyWord",
                    data: {"KeyWord":KeyWord,"pn":pn},
                    type: "GET",
                    success: function (result) {
                        $("#tbl_user tbody").empty();
                        if(result.code==100){
                            var list=result.extend.pageInfo.list;
                            $.each(list,function (index,item) {
                                build_user_tal(item);
                            });
                            var pageInfo=result.extend.pageInfo;
                            build_user_nav(pageInfo);
                        }else{
                            //交互出错时的处理
                        }
                    }
                });
            }

            function build_user_tal(item) {
                var tr=$("<tr></tr>").addClass("tr_user");
                var id=$("<th></th>").append(item.id);
                var name=$("<th></th>").append(item.name);
                var phone=$("<th></th>").append(item.phone);
                var age=$("<th></th>").append(item.age);
                var experience=$("<th></th>").append(item.experience);
                var account=$("<th></th>").append(item.account);
                var td=$("<th></th>");
                tr.append(id)
                    .append(name)
                    .append(phone)
                    .append(age)
                    .append(experience)
                    .append(account);
                var btn1=$("<button></button>")
                    .addClass("roleBtn btn btn-info glyphicon glyphicon-eye-open btn-sm ajax_btn")
                    .attr("data-toggle","modal").attr("data-target","#roleModal").attr("name",item.id)
                    .append(" 分配角色");
                td.append(btn1);
                if(item.name=="超级管理员"){
                    var btn2=$("<button></button>")
                        .addClass("btn btn-warning glyphicon glyphicon-cog btn-sm disabled ajax_btn")
                        .append("禁止编辑");
                    var btn3=$("<button></button>")
                        .addClass("btn btn-danger glyphicon glyphicon-trash btn-sm disabled ajax_btn")
                        .append("禁止删除");
                    td.append(btn2);
                    td.append(btn3);
                    tr.append(td);
                }
                else{
                    var btn2=$("<button></button>")
                        .addClass("editBtn btn btn-warning glyphicon glyphicon-cog btn-sm ajax_btn")
                        .attr("data-toggle","modal").attr("data-target","#editModal").attr("name",item.id)
                        .append(" 编辑");


                    var btn3=$("<button></button>")
                        .addClass("deleteBtn btn btn-danger glyphicon glyphicon-cog btn-sm ajax_btn")
                        .attr("data-toggle","modal").attr("data-target","#deleteModal").attr("name",item.id)
                        .append(" 删除");

                    td.append(btn2);
                    td.append(btn3);
                    tr.append(td);

                }

                $("#tbl_user tbody").append(tr);

            }

            function build_user_nav(pageInfo) {
                var pageNav=$("#pageNav");
                pageNav.empty();
                var div1=$("<div></div>").addClass("col-md-2");
                var div1_btn1=$("<button></button>").addClass("btn btn-primary glyphicon glyphicon-plus")
                    .attr("data-toggle","modal").attr("data-target","#addModal").append("增加");
                div1_btn1.appendTo(div1);
                div1.appendTo(pageNav);
                var div2=$("<div></div>").addClass("col-md-4");

                var div2_btn1=$("<button></button>").addClass("btn btn-info").attr("type","button").append("当前页码:"+pageInfo.pageNum);
                div2_btn1.appendTo(div2);
                var div2_btn2=$("<button></button>").addClass("btn btn-info").attr("type","button").append("总页码:"+pageInfo.pages);
                div2_btn2.appendTo(div2);
                var div2_btn3=$("<button></button>").addClass("btn btn-info").attr("type","button").append("总记录数:"+pageInfo.total);
                div2_btn3.appendTo(div2);
                pageNav.append(div2);
                var div3=$("<div></div>").addClass("col-md-6");
                var nav=$("<div></div>").attr("aria-label","Page navigation");
                nav.appendTo(div3);
                var ul=$("<ul></ul>").addClass("pagination");
                ul.appendTo(nav);
                var li1=$("<li></li>");
                var li1_a1=$("<a></a>").addClass("btn_page ").attr("href","javascript:;")
                    .attr("aria-label","Previous").attr("name","1")
                    .append("首页");
                li1_a1.appendTo(li1);
                ul.append(li1);
                var li2=$("<li></li>");
                var li2_a1=$("<a></a>").addClass("btn_page").attr("href","javascript:;")
                    .attr("aria-label","Previous").attr("name",pageInfo.pageNum-1);

                var li2_span1=$("<span></span>");
                li2_span1.attr("aria-hidden","true").append("<");
                li2_span1.appendTo(li2_a1);
                li2_a1.appendTo(li2);
                ul.append(li2);
                var navigatepageNums=pageInfo.navigatepageNums;
                $.each(navigatepageNums,function (index,item) {
                   if(item==pageInfo.pageNum){
                        var li=$("<li></li>").addClass("active");
                        var a=$("<a></a>").addClass("btn_page").attr("href","javascript:;").attr("name",item).append(item);
                         a.appendTo(li);
                         li.appendTo(ul);
                   }else{
                       var li=$("<li></li>");
                       var a=$("<a></a>").addClass("btn_page").attr("href","javascript:;").attr("name",item).append(item);
                       a.appendTo(li);
                       li.appendTo(ul);
                   }
                });
                //继续添加
                var li4=$("<li></li>");
                var li4_a1=$("<a></a>").addClass("btn_page").attr("href","javascript:;")
                    .attr("aria-label","Next").attr("name",pageInfo.pageNum+1);
                var li4_span1=$("<span></span>").attr("aria-hidden","true").append(">");
                li4_span1.appendTo(li4_a1);
                li4_a1.appendTo(li4);
                li4.appendTo(ul);

                var li5=$("<li></li>");
                var li5_a1=$("<a></a>").addClass("btn_page").attr("href","javascript:;")
                    .attr("aria-label","Previous").attr("name",pageInfo.pages)
                    .append("末页");;
                li5_a1.appendTo(li5);
                li5.appendTo(ul);
                pageNav.append(div3);
               }


            //低版本的触发
//            $("#keyword").change(function () {
//                var KeyWord=$(this).val();
//                console.log("进来了");
//                $.ajax({
//                    url: "user/getUserByKeyWord",
//                    data: "KeyWord=" + KeyWord,
//                    type: "GET",
//                    success: function (result) {
//                        $(".tr_user").remove();
//
//                    }
//                });
//            });
//
//            $(".roleBtn").each(function () {
//                $(this).click(function () {
//                    $("#roleHandler").empty();
//                    $("#roleHandler").append("<h5></h5>").append("你没有获得该权限！");
//                    ID = $(this).attr("name");
//                    $("#editID").attr("value", ID);
//                    $.ajax({
//                        url: "role/getRoleJson",
//                        data: "ID=" + ID,
//                        type: "GET",
//                        success: function (result) {
//                            var roleList = result.extend.roleJsons;
//                            $("#roleHandler").empty();
//                            $.each(roleList, function (index, item) {
//                                var isExit = item.exit;
//                                if (isExit == false) {
//                                    var roleBtn = $("<button></button>")
//                                        .addClass("btn roleBtnShow")
//                                        .attr("type", "button")
//                                        .attr("id", item.role.id)
//                                        .append(item.role.name);
//                                    $("#roleHandler").append(roleBtn);
//                                }
//                                else {
//                                    var roleBtn = $("<button></button>")
//                                        .addClass("btn roleBtnShow btn-info")
//                                        .attr("type", "button")
//                                        .attr("id", item.role.id)
//                                        .append(item.role.name);
//                                    $("#roleHandler").append(roleBtn);
//                                }
//                            });
//                        }
//                    });
//                })
//            });
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
                    <input type="text" name="keyword" id="keyword" placeholder="请输入关键字..."/>
                    <%--<button class="submitbutton"></button>--%>
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
            <li class="current" href=""><a href="homePage/userManagement"><span class="icon icon-flatscreen"></span>用户管理</a>
            </li>
            <li><a href="homePage/roleManagement"><span class="icon icon-pencil"></span>角色管理</a></li>
            <li><a href="homePage/permissionManagement"><span class="icon icon-message"></span>权限管理</a></li>
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
                        <form role="form" action="user/userAdd" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">用户添加</h4>
                            </div>
                            <div class="modal-body">
                                <p>姓名</p>
                                <input class="form-control" type="text" name="name"></input>
                            </div>
                            <div class="modal-body">
                                <p>手机</p>
                                <input class="form-control" type="text" name="phone"></input>
                            </div>
                            <div class="modal-body">
                                <p>年龄</p>
                                <input class="form-control" type="number" name="age"></input>
                            </div>
                            <div class="modal-body">
                                <p>经验</p>
                                <input class="form-control" type="number" name="experience"></input>
                            </div>
                            <div class="modal-body">
                                <p>帐号</p>
                                <input class="form-control" type="text" name="account"></input>
                            </div>
                            <div class="modal-body">
                                <p>密码</p>
                                <input class="form-control" type="password" name="password"></input>
                            </div>
                            <div class="modal-footer">
                                <button data-dismiss="modal" class="btn btn-default" type="button">关闭</button>
                                <button class="btn btn-primary" type="submit">提交</button>
                            </div>
                        </form>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>

            <div class="modal fade" id="roleModal" tabindex="-1" role="dialog" aria-labelledby="roleModalLabel">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form role="form" action="" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">角色分配</h4>
                            </div>
                            <div class="modal-body" id="roleHandler">

                            </div>
                            <div class="modal-footer">
                                <button id="closeRoleChance" data-dismiss="modal" class="btn btn-default" type="button">
                                    关闭
                                </button>
                                <button id="inputRoleChance" class="btn btn-primary" type="button">提交</button>
                            </div>
                        </form>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal-dialog -->
            </div>

            <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="editModalLabel">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form role="form" action="user/userEdit" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                <h4 class="modal-title">用户编辑</h4>
                            </div>
                            <div class="modal-body">
                                <p>ID</p>
                                <input id="editID" name="id" readonly="readonly" class="form-control" type="text"
                                       name="expression"></input>
                            </div>
                            <div class="modal-body">
                                <p>姓名</p>
                                <input id="editName" class="form-control" type="text" name="name"></input>
                            </div>
                            <div class="modal-body">
                                <p>手机</p>
                                <input id="editPhone" class="form-control" type="text" name="phone"></input>
                            </div>
                            <div class="modal-body">
                                <p>年龄</p>
                                <input id="editAge" class="form-control" type="number" name="age"></input>
                            </div>
                            <div class="modal-body">
                                <p>经验</p>
                                <input id="editExperience" class="form-control" type="number" name="experience"></input>
                            </div>
                            <div class="modal-body">
                                <p>帐号</p>
                                <input id="editAccount" class="form-control" type="text" name="account"></input>
                            </div>
                            <div class="modal-body">
                                <p>密码</p>
                                <input id="editPassword" class="form-control" type="password" name="password"></input>
                            </div>
                            <div class="modal-body">
                                <p>重复密码</p>
                                <input id="editRePassword" class="form-control" type="password" name="password"></input>
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
                        <form role="form" action="user/userDelete" method="post">
                            <div class="modal-header">
                                <button data-dismiss="modal" class="close" type="button"><span
                                        aria-hidden="true">×</span><span class="sr-only">Close</span></button>
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
                <div class="col-md-12 ">
                    <table id="tbl_user" class="table table-hover table table-striped">
                        <thead>
                          <tr>
                            <th>ID</th>
                            <th>姓名</th>
                            <th>手机</th>
                            <th>年龄</th>
                            <th>经验</th>
                            <th>帐号</th>
                            <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>

                        <%--<c:forEach items="${pageInfo.list}" var="user">--%>
                            <%--<tr class="tr_user">--%>
                                <%--<th>${user.id}</th>--%>
                                <%--<th>${user.name}</th>--%>
                                <%--<th>${user.phone}</th>--%>
                                <%--<th>${user.age}</th>--%>
                                <%--<th>${user.experience}</th>--%>
                                <%--<th>${user.account}</th>--%>
                                <%--<th>--%>
                                    <%--<button name="${user.id}"--%>
                                            <%--class="roleBtn btn btn-info glyphicon glyphicon-eye-open btn-sm"--%>
                                            <%--data-toggle="modal" data-target="#roleModal"> 分配角色--%>
                                    <%--</button>--%>
                                    <%--<c:choose>--%>
                                        <%--<c:when test="${fn:contains(user.name,'超级管理员')}">--%>
                                            <%--<button class="btn btn-warning glyphicon glyphicon-cog btn-sm disabled">--%>
                                                <%--禁止编辑--%>
                                            <%--</button>--%>
                                            <%--<button class="btn btn-danger glyphicon glyphicon-trash btn-sm disabled">--%>
                                                <%--禁止删除--%>
                                            <%--</button>--%>
                                        <%--</c:when>--%>
                                        <%--<c:otherwise>--%>
                                            <%--<button name="${user.id}"--%>
                                                    <%--class="editBtn btn btn-warning glyphicon glyphicon-cog btn-sm"--%>
                                                    <%--data-toggle="modal" data-target="#editModal">编辑--%>
                                            <%--</button>--%>
                                            <%--<button name="${user.id}"--%>
                                                    <%--class="deleteBtn btn btn-danger glyphicon glyphicon-cog btn-sm"--%>
                                                    <%--data-toggle="modal" data-target="#deleteModal">删除--%>
                                            <%--</button>--%>
                                        <%--</c:otherwise>--%>
                                    <%--</c:choose>--%>
                                <%--</th>--%>
                            <%--</tr>--%>
                        <%--</c:forEach>--%>
                    <%--</table>--%>

        <div class="row">
            <div id="pageNav"></div>
                <%--<div class="col-md-2">--%>
                    <%--<button class="btn btn-primary glyphicon glyphicon-plus" data-toggle="modal"--%>
                            <%--data-target="#addModal">增加--%>
                    <%--</button>--%>
                <%--</div>--%>
                <%--<div class="col-md-4">--%>
                    <%--<button type="button" class="btn btn-info">当前页码:${pageInfo.pageNum}</button>--%>
                    <%--<button type="button" class="btn btn-info">总页码:${pageInfo.pages}</button>--%>
                    <%--<button type="button" class="btn btn-info">总记录数:${pageInfo.total}</button>--%>
                <%--</div>--%>
                <%--<div class="col-md-6">--%>
                    <%--<nav aria-label="Page navigation">--%>
                        <%--<ul class="pagination">--%>
                            <%--<li><a href="${ pageContext.request.contextPath }/homePage/userManagement?pn=1">首页</a></li>--%>
                            <%--<li>--%>
                                <%--<a href="${ pageContext.request.contextPath }/homePage/userManagement?pn=${pageInfo.pageNum-1}"--%>
                                   <%--aria-label="Previous">--%>
                                    <%--<span aria-hidden="true">&laquo;</span>--%>
                                <%--</a>--%>
                            <%--</li>--%>
                            <%--<c:forEach items="${pageInfo.navigatepageNums}" var="index">--%>
                                <%--<c:if test="${index==pageInfo.pageNum}">--%>
                                    <%--<li class="active"><a--%>
                                            <%--href="${ pageContext.request.contextPath }/homePage/userManagement?pn=${index}">${index}</a>--%>
                                    <%--</li>--%>
                                <%--</c:if>--%>
                                <%--<c:if test="${index!=pageInfo.pageNum}">--%>
                                    <%--<li>--%>
                                        <%--<a href="${ pageContext.request.contextPath }/homePage/userManagement?pn=${index}">${index}</a>--%>
                                    <%--</li>--%>
                                <%--</c:if>--%>
                            <%--</c:forEach>--%>

                            <%--<li>--%>
                                <%--<a href="${ pageContext.request.contextPath }/homePage/userManagement?pn=${pageInfo.pageNum+1}"--%>
                                   <%--aria-label="Next">--%>
                                    <%--<span aria-hidden="true">&raquo;</span>--%>
                                <%--</a>--%>
                            <%--</li>--%>
                            <%--<li>--%>
                                <%--<a href="${ pageContext.request.contextPath }/homePage/userManagement?pn=${pageInfo.pages}">末页</a>--%>
                            <%--</li>--%>
                        <%--</ul>--%>
                    <%--</nav>--%>

        </div><%--</row>--%>

        </div> <%--container-fiuled--%>
    </div> <%--centercontent--%>
</div>

</body>
</html>
