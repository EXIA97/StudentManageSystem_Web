<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>添加班级</title>
<link href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<script src="//cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

</head>
<style>
body {
	background-image: url("./images/backgroundImg.jpg");
	background-position: center 0;
	background-repeat: no-repeat;
	background-attachment: fixed;
	background-size: cover;
	-webkit-background-size: cover;
	-o-background-size: cover;
	-moz-background-size: cover;
	-ms-background-size: cover;
}
</style>

<body>
	<%
		String adminID = null;
		String lastlogin = null;
		if (session != null) {
			adminID = (String) session.getAttribute("adminID");
			lastlogin = session.getAttribute("lastLogin").toString();
		}
	%>

	<div class="container">
		<h1 style="color:White">学生管理系统</h1>
		<nav class="navbar navbar-inverse">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar-menu"
					aria-expanded="false">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">模块选择</a>
			</div>


			<form class="navbar-form navbar-right" action="logout" method="post">
				<button type="submit" class="btn btn-danger">注销</button>
			</form>

			<p class="navbar-text navbar-right"><%=lastlogin%></p>

			<p class="navbar-text navbar-right">上次登录时间</p>

			<div class="navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="showAllStudent">学生管理</a></li>
					<li><a href="showAllClass" class="active">班级管理</a></li>
				</ul>
			</div>
		</nav>
		<div class="row">
			<div class="col-md-9" id="content">
				<div style="padding: 100px 100px 10px;">
					<form class="bs-example bs-example-form" role="form"
						action="addClass" method="post">
						<div class="row">
							<div class="form-group">
								<div class="center-block" style="width:600px;">
									<div class="input-group input-group-sm">
										<span class="input-group-addon">班级编号</span> <input type="text"
											name="cid" class="form-control" placeholder="请输入班级编号">
									</div>
									<br>

									<div class="input-group input-group-sm">
										<span class="input-group-addon">班级名称</span> <input type="text"
											name="name" class="form-control" placeholder="请输入班级名称">
									</div>
									<br>

									<div class="input-group input-group-sm">
										<span class="label label-default">班级简介</span>
									</div>
									<br>

									<div>
										<textarea rows="5" name="note" class="form-control"
											placeholder="请输入班级简介"> 
						</textarea>
									</div>

									<br>

									<div>
										<button type="submit" class="btn btn-primary btn-lg">提交</button>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="col-md-3" id="subbar">
				<nav class="navbar navbar-inverse">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle collapsed"
							data-toggle="collapse" data-target="#navbar-menu"
							aria-expanded="false">
							<span class="sr-only">Toggle navigation</span> <span
								class="icon-bar"></span> <span class="icon-bar"></span> <span
								class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="#">功能选择</a>
					</div>

					<div class="navbar-nav ">
						<ul class="nav nav-list navbar-nav">
							<li><a href="addClass.jsp">增加班级</a></li>
							<li><a href="showAllClass">班级列表</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>


</body>
</html>