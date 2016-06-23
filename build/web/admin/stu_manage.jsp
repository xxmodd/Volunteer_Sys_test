<%@page import="cn.edu.hnuc.volunteer_Sys.util.checkLogin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	if (checkLogin.checkL(request, response) != 2) {
		response.sendRedirect("../login.jsp");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>学生管理页面</title>
<script type="text/javascript" src="../js/student/admin_stu_delete.js"></script>

<script type="text/javascript" src="/Volunteer_Sys_test/js/user/logout.js"></script>
<link href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css" rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/2.2.1/jquery.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
<script src="/Volunteer_Sys_test/js/layer/layer.js"></script>

</head>
<body>
    <nav class="navbar navbar-default">
        <%
            int user_statuscode = checkLogin.checkL(request, response);
            String infoOut;
            String un = "";
            if (user_statuscode == 1) {
                un = request.getSession().getAttribute("stu_account").toString();
                infoOut = "<li><a href=\"#\">"
                        + un + "</a></li><li><a href=\"javascript:logout();\">注销</a></li><li><a href=\"/Volunteer_Sys_test/student/info.jsp\">查看基本信息</a></li><li><a href=\"/Volunteer_Sys_test/changePassword/\">修改密码</a></li>";
            } else if (user_statuscode == 2) {
                un = request.getSession().getAttribute("adm_username").toString();
                infoOut = "<li><a href=\"#\""
                        + un + "</li><li><a href=\"javascript:logout();\">注销</a></li><li><a href=\"/Volunteer_Sys_test/admin/act_manage.jsp\">本院活动管理</a></li><li><a href=\"/Volunteer_Sys_test/admin/stu_manage.jsp\">本院学生管理</a></li><li><a href=\"/Volunteer_Sys_test/changePassword/\">修改密码</a></li>";
            } else if (user_statuscode == 3) {
                un = request.getSession().getAttribute("superadmin").toString();
                infoOut = "<li><a href=\"#\"" + un +  "</li><li><a href=\"javascript:logout();\">注销</a></li><li><a href=\"/Volunteer_Sys_test/superadmin/adm_manage.jsp\">管理管理员</a></li>";
            } else {
                un = "用户登录";
                infoOut = "<li><a href=\"#\"" + un +  "</li><li><a href=\"/Volunteer_Sys_test/login.jsp\">普通用户/管理员</a></li><li><a href=\"/Volunteer_Sys_test/superadmin/login.jsp\">高级管理员</a></li>";
            }
        %>
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/Volunteer_Sys_test/">志愿者服务平台</a>
            </div>
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"><%= un %> <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <%= infoOut %>
                        </ul>
                    </li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <div class="container">
        <div class="row">
            <div class="panel panel-default">
                <div class="panel-heading">学生管理</div>
                <table class="table" id="table">
                    <tr>
                        <td>#</th>
                        <th>姓名</th>
                        <th>学号</th>
                        <th>性别</th>
                        <th>电话</th>
                        <th>QQ</th>
                        <th>邮箱</th>
                        <th>所属学院</th>
                        <th>操作</th>
                        <th>操作</th>
                    </tr>
                </table>
            </div>
        </div>
    </div>
<script>
    var ind = layer.msg('加载中', {icon: 16});
    $.ajax({
        url: '/Volunteer_Sys_test/servlet/admin_Stus_show',
        method: 'post',
        dataType: 'json',
        data:{},
        success: function(data){
            for(var i=0; i<data.length; i++){
                $('#table').append('<tr><td>' + (i+1) + '</td><td>' + data[i].stu_name + '</td><td>' + data[i].stu_account + '</td><td>' + data[i].stu_sex + '</td><td>' + data[i].stu_phone + '</td><td>' + data[i].stu_qq + '</td><td>' + data[i].stu_email + '</td><td>' + JSON.parse(data[i].academy_info).aca_name + '</td><td><button class="btn btn-default" onclick="stu_delete(' + data[i].stu_id + ')">删除</button></td><td><a href="./stu_act_manage.jsp?account=' + data[i].stu_account + '" class="btn btn-default">查看活动</a></td></tr>');
            }
            layer.close(ind);
            console.log(data);
        },
        error: function(){
            layer.close(ind);
            layer.msg('网络错误，请重新刷新本页~~~');
        }
    });
</script>           
</body>
</html>