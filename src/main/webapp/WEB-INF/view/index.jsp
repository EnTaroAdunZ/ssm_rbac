<%@page isELIgnored="false" language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <%
            String path = request.getContextPath();
            String basePath = request.getScheme() + "://"
                    + request.getServerName() + ":" + request.getServerPort()
                    + path + "/";
        %>
        <base href="<%=basePath%>" />
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="assets/js/jquery-1.11.1.min.js"></script>
        <link href="assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <script src="assets/bootstrap/js/bootstrap.min.js"></script>
        <title>权限管理系统</title>

        <!-- CSS -->
        <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">

        <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
		<link rel="stylesheet" href="assets/css/form-elements.css">
        <link rel="stylesheet" href ="assets/css/style.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="assets/js/jquery-1.11.1.min.js"></script>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.png">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">
        <script>
            $(document).ready(function () {
                $("#btn_login_sumbit").click(function () {
                    if(regVerify()){
                        var username=$("#form-username").val();
                        var password=$("#form-password").val();
                        $.ajax({
                            url:"checkUser",
                            data:{"username":username,"password":password},
                            type:"POST",
                            success:function (result) {
                                if(result.code==200){
                                    show_help_block("#form-username","error","帐号或密码错误，请检查");
                                    show_help_block("#form-password","error","帐号或密码错误，请检查");
                                }else if(result.code==100){
                                    $("#loginForm").submit();
                                }
                            }
                        });

                    }
                });

                function regVerify() {
                    var username=$("#form-username").val();
                    var password=$("#form-password").val();
                    var reg=/^[a-z0-9_-]{3,16}$/;
                    var tip="用户名密码格式不对，请输入3-16位数字或字母";
                    if(reg.test(username  )){
                        show_help_block("#form-username","success","输入正确！");
                    }
                    else{
                        show_help_block("#form-username","error",tip);
                        return false;
                    }
                    if(reg.test(password)){
                        show_help_block("#form-password","success","输入正确！");
                    }
                    else{
                        show_help_block("#form-password","error",tip);
                        return false;
                    }
                    return true;
                }


                function show_help_block(ele,status,msg) {
                    $(ele).parent().removeClass("has-success has-warning")
                    if(status=="success"){
                        $(ele).parent().addClass("has-success");
                        $(ele).next("span").text(msg);
                    }else if(status=="error"){
                        $(ele).parent().addClass("has-warning");
                        $(ele).next("span").text(msg);
                    }
                }

            });

        </script>
    </head>

    <body>

        <!-- Top content -->
        <div class="top-content">

            <div class="inner-bg">
                <div class="container">
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-2 text">
                            <h1><strong>Tasada</strong>权限管理系统</h1>
                            <div class="description">
                            	<p></p>模拟论坛的权限管理系统
                            	</p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-sm-offset-3 form-box">
                        	<div class="form-top">
                        		<div class="form-top-left">
                        			<h3>在这里登录权限系统</h3>
                            		<p>在此输入您的帐号密码：</p>
                        		</div>
                        		<div class="form-top-right">
                        			<i class="fa fa-lock"></i>
                        		</div>
                            </div>
                            <div class="form-bottom">
			                    <form role="form" action="user/index" method="post" class="login-form" id="loginForm">
			                    	<div class="form-group">
			                    		<label class="sr-only" for="form-username">Username</label>
			                        	<input type="text"  placeholder="账号..." class="form-username form-control" id="form-username" name="account">
			                            <span class="help-block"></span>
                                    </div>
			                        <div class="form-group">
			                        	<label class="sr-only" for="form-password">Password</label>
			                        	<input type="password"  placeholder="密码..." class="form-password form-control" id="form-password" name="password">
                                        <span class="help-block"></span>
			                         </div>
                                    <button id="btn_login_sumbit" type="button" class="btn">登录</button>
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