<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>学生管理系统</title>
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

.container {
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
}

@media ( min-width : 768px) {
	.container {
		width: 750px;
	}
}

@media ( min-width : 992px) {
	.container {
		width: 970px;
	}
}

@media ( min-width : 1200px) {
	.container {
		width: 1170px;
	}
}

.container-fluid {
	padding-right: 15px;
	padding-left: 15px;
	margin-right: auto;
	margin-left: auto;
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
				<a class="navbar-brand" href="#">Orbis Terrarum</a>
			</div>


			<form class="navbar-form navbar-right" action="logout" method="post">
				<button type="submit" class="btn btn-danger">注销</button>
			</form>

			<p class="navbar-text navbar-right"><%=lastlogin %></p>


			<p class="navbar-text navbar-right">上次登录时间</p>




			<div class="navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="showAllStudent">学生管理</a></li>
					<li><a href="showAllClass">班级管理</a></li>
				</ul>
			</div>
		</nav>

		<div id="myCarousel" class="carousel slide">
			<!-- 轮播（Carousel）指标 -->
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
				<li data-target="#myCarousel" data-slide-to="2"></li>
			</ol>
			<!-- 轮播（Carousel）项目 -->
			<div class="carousel-inner">
				<div class="item active">
					<img src="./images/slide1.jpg" alt="First slide">
				</div>
				<div class="item">
					<img src="./images/slide2.jpg" alt="Second slide">
				</div>
				<div class="item">
					<img src="./images/slide3.jpg" alt="Third slide">
				</div>
			</div>
			<!-- 轮播（Carousel）导航 -->
			<a class="left carousel-control" href="#myCarousel" role="button"
				data-slide="prev"> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
				<span class="sr-only">Previous</span>
			</a> <a class="right carousel-control" href="#myCarousel" role="button"
				data-slide="next"> <span
				class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
				<span class="sr-only">Next</span>
			</a>
		</div>
	</div>

</body>