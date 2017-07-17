<%@page isELIgnored="false" language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个人主页</title>

    <%
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://"
                + request.getServerName() + ":" + request.getServerPort()
                + path + "/";
    %>
    <base href="<%=basePath%>" />
    <!-- CSS -->
    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/form-elements.css">
    <link rel="stylesheet" href ="assets/css/style.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Favicon and touch icons -->
    <link rel="shortcut icon" href="assets/ico/favicon.png">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">
    <script type="text/javascript">

        <%--function userManagement(){--%>
            <%--var set=[];--%>
            <%--set=${userPermission};--%>
            <%--var isExit=false;--%>
            <%--set.forEach(function (element, index, array) {--%>
                <%--window.console.log(element);--%>
                <%--if(element=="com.etop.controller.HomePageController.userManagement")--%>
                <%--{--%>
                    <%--isExit=true;--%>
                <%--}--%>
            <%--});--%>
            <%--if(isExit==false){--%>
                <%--window.console.log("显示吧");--%>
                <%--$("#myModal").toggleClass("show");--%>
            <%--}--%>
            <%--else{--%>
                <%--document.handle.action="homePage/userManagement";--%>
                <%--document.handle.submit();--%>
            <%--}--%>
        <%--}--%>


        function userManagement(){
            document.handle.action="homePage/userManagement";
            document.handle.submit();
        }
        function permissionManagement(){
            document.handle.action="homePage/permissionManagement";
            document.handle.submit();
        }
        function roleManagement(){
            document.handle.action="homePage/roleManagement";
            document.handle.submit();
        }
        function exit(){
            document.handle.action="homePage/exit";
            document.handle.submit();
        }

    </script>
</head>

<body>
<div>
    <div class="modal fade hidden" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                </div>
                <div class="modal-body">
                    ...
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save changes</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
</div>
<div class="top-content">

    <div class="inner-bg">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text">
                    <h1><strong> ${user.name}</strong>的个人主页</h1>
                    <div class="description">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 form-box">
                    <div class="form-top">
                        <div class="form-top-left">
                            <h3>欢迎回来</h3>
                            <p>个人信息如下：</p>
                        </div>
                        <div class="form-top-right">
                            <i class="fa fa-lock"></i>
                        </div>
                    </div>
                    <div class="form-bottom">
                        <form role="form" action="" name="handle" method="post" class="login-form">
                            <div class="form-group">
                                <label class="sr-only" >Username</label>
                                <input type="text"  value="ID:${user.id}" readonly="readonly" class="form-username form-control" >
                            </div>
                            <div class="form-group">
                                <label class="sr-only">Password</label>
                                <input type="text"  value="电话:${user.phone}" readonly="readonly" class="form-username form-control"  >
                            </div>
                            <div class="form-group">
                                <label class="sr-only">Password</label>
                                <input type="text"  value="经验:${user.experience}" readonly="readonly" class="form-username form-control"  >
                            </div>
                            <div class="form-group">
                                <label class="sr-only">Password</label>
                                <input type="text" value="年龄:${user.age}" readonly="readonly" class="form-username form-control" >
                            </div>
                            <button type="button" onclick="userManagement()"  class="btn" style="margin-bottom: 5px">用户管理</button>
                            <button type="button" onclick="permissionManagement()"  class="btn" style="margin-bottom: 5px">权限管理</button>
                            <button type="button" onclick="roleManagement()"  class="btn" style="margin-bottom: 5px">角色管理</button>
                            <button type="button" onclick="exit()"  class="btn btn-danger" style="margin-bottom:5px">退出登录</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-6 col-sm-offset-3 social-login">
                </div>
            </div>
        </div>
    </div>

</div>


<!-- Javascript -->
<script src="assets/js/jquery-1.11.1.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.backstretch.min.js"></script>
<script src="assets/js/scripts.js"></script>

<!--[if lt IE 10]>
<script src="assets/js/placeholder.js"></script>
<![endif]-->


</body>

</html>