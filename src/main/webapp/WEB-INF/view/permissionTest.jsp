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
        .main-box{
            text-align: center;
            padding: 20px;
            border-radius: 5px;
            -moz-border-radius: 5px;
            -webkit-border-radius: 5px;
            margin-bottom: 40px;
        }
        .mb-dull{
            background-color: #d36f2e;
        }
        .fa-5x {
            font-size: 5em;
        }
        .fa {
            display: inline-block;
            font: normal normal normal 14px/1 FontAwesome;
            font-size: inherit;
            text-rendering: auto;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
        }
        .fa-plug:before {
            content: "\f1e6";
        }
        .btn_test{
            height: 100px;
            width: 20%;
            margin-bottom: 25px;
            margin-right: 25px;
            line-height: 90px;
            font-size: 24px;
            border-radius:40px;
        }
    </style>
    <script>
        $(document).ready(function () {

            $(".btn_test").each(function () {
                var ID=$(this).attr("name");
                $(this).click(function () {
                    $.ajax({
                        url: "permission/permissionModel",
                        data: "ID=" + ID,
                        type: "POST",
                        success: function (result) {
                            if(result.code==100){
                                $('#successTip').modal();
                            }
                            else{
                                $('#failTip').modal();
                            }
                        }
                    });
                })
            });//roleBtn-end
        });//document-end
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
            <li ><a href="homePage/permissionManagement"><span class="icon icon-message"></span>权限管理</a></li>
            <li  class="current"><a href=""><span class="icon icon-chart"></span>功能模拟</a></li>
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

                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-success">
                            <div class="panel-heading">权限测试中....</div>
                            <div class="panel-body" id="testArea">
                                <div class="modal fade" id="successTip" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                                <h4 class="modal-title">权限测试</h4>
                                            </div>
                                            <div class="modal-body">
                                                <h1>恭喜，你拥有该权限</h1>
                                            </div>
                                            <div class="modal-footer">
                                                <button data-dismiss="modal" class="btn btn-default" type="button" id="btn_success">关闭</button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal-dialog -->
                                </div><!-- /.modal fade -->

                                <div class="modal fade" id="failTip" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" >
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button data-dismiss="modal" class="close" type="button"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>
                                                <h4 class="modal-title">权限测试</h4>
                                            </div>
                                            <div class="modal-body">
                                                <h1>抱歉，你暂时没有该权限</h1>
                                            </div>
                                            <div class="modal-footer">
                                                <button data-dismiss="modal" class="btn btn-default" type="button" id="btn_fail">关闭</button>
                                            </div>
                                        </div><!-- /.modal-content -->
                                    </div><!-- /.modal-dialog -->
                                </div><!-- /.modal fade -->
                                <c:forEach items="${permission}" var="per">
                                    <button class="btn btn-info btn_test" name="${per.id}">${per.name}</button>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
            </div>


            </div>
        </div>
    </div>
</div>
</body>
</html>
