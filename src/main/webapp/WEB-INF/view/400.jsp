<!doctype html>
<html>
<head>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<base href="<%=basePath%>"></base>
<meta charset="utf-8">
<title>登录失败</title>
<link href="assets/css/pintuer.css" rel="stylesheet"/>
<style>
*{ margin:0; padding:0; list-style:none;}
table{border-collapse:collapse;border-spacing:0;}
body,html{ height:100%; font-family:'微软雅黑'; overflow-y:hidden;}
.main{ width:60%; margin-left:20%; margin-right:20%; margin-top:10%;}
.main_left{ width:38%; margin-left:12%; margin-top:10%; float:left;}
.main_right{width:50%; float:left;}
.main_radius{ padding-top:4%; width:75%; height:130px; border-radius:50%; background:#fef2ec; font-size:18px;text-align:center;}
.main_p{ font-family:'华文行楷';}
</style>
</head>

<body>
<div class="main">
   <div class="main_left"><img src="assets/img/img2.png" width="229" height="128"/></div>
   <div class="main_right">
      <div class="main_radius">
         <p class="main_p">登录失败</p>
         <p class="main_p">帐号或者密码错误！</p>
      </div>
      <div class="text-left" style="margin-top:10%; margin-left:8%;">
          <a href="login" class="button bg-yellow">返回首页</a>
      </div>
   </div>
</div>
</body>
</html>
