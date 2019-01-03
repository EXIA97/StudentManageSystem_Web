<!DOCTYPE html>
<%@page import="java.io.Console"%>
<%@ page import="com.scau.model.Class"%>
<%@ page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>班级管理</title>
<script src="//cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<link href="//cdn.bootcss.com/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
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
		List<Class> classes = (List<Class>) session.getAttribute("classes");
	%>

	<!-- 用container把所有元素收容起来，赋予同样的样式 -->
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
			<!-- 在一行中用栅格分别分割9比3的布局 -->
			<div class="col-md-9" id="content">
				<div class="panel panel-default">
					<div class="panel-heading">
						<table class="table table-bordered" id="mytable">
							<thead>
								<tr>
									<th><input type="checkbox" onclick="ckAll()"
										id="allChecks"></th>
									<th>班级编号</th>
									<th>班级名称</th>
									<th>班级简介</th>
								</tr>
							</thead>
							<tbody>
								<%
									for (Class c : classes) {
								%>
								<tr>
									<td><input type="checkbox" name="ids"></td>
									<td id="cid"><%=c.getCid()%></td>
									<td onclick='tdclick(this)'><%=c.getName()%></td>
									<td onclick='tdclick(this)'><%=c.getNote()%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>


						<button type="button" class="btn btn-danger" onClick=del()>删除</button>
						<button type="button" class="btn btn-warning" onClick=update()>更新</button>
					</div>
				</div>
			</div>
			<div class="col-md-3" id="subbar">
				<nav class="navbar navbar-inverse navbar-fixed-right">
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

					<div class="collapse navbar-collapse ">
						<ul class="nav nav-list navbar-nav">
							<li><a href="addClass.jsp">增加班级</a></li>
							<li><a href="showAllClass" class="active">班级列表</a></li>
						</ul>
					</div>
				</nav>
			</div>
		</div>
	</div>

	<script>
	

		function tdclick(tdobject) {
			var td = $(tdobject);
			td.attr("onclick", "");
			//取出当前td中的文本内容保存起来 
			var text = td.text();
			//清空td里面的内容 
			td.html(""); 
			//建立一个文本框
			var input = $("<input>");
			//设置文本框的值是保存起来的文本内容 
			input.attr("value", text);
			input.bind("blur", function() {
				var inputnode = $(this);
				var inputtext = inputnode.val();
				var tdNode = inputnode.parent();
				tdNode.html(inputtext);
				tdNode.click(tdclick);
				td.attr("onclick", "tdclick(this)");
			});
			input.keyup(function(event) {
				var myEvent = event || window.event;
				var kcode = myEvent.keyCode;
				if (kcode == 13) {
					var inputnode = $(this);
					var inputtext = inputnode.val();
					var tdNode = inputnode.parent();
					tdNode.html(inputtext);
					tdNode.click(tdclick);
				}
			});
	
			//将文本框加入到td中 
			td.append(input);
			var t = input.val();
			input.val("").focus().val(t);
	
			//清除点击事件 
			td.unbind("click");
		}
	
	
	
		//复选框全选
		function ckAll() {
			var flag = document.getElementById("allChecks").checked;
			var cks = document.getElementsByName("ids");
			for (var i = 0; i < cks.length; i++) {
				cks[i].checked = flag;
			}
		}
	
	
		//跳转到登录
		function toLogin() {
			location.href("login");
		}
		
	
		//批量删除
		function del() {
			var ids = "";
			var trArr = $('#mytable tr');
			for (var i = 0; i < trArr.length; i++) {
				var tdArr = trArr.eq(i).find("td");
				var number = tdArr.eq(0).find("input").is(':checked'); //数量
				if (number == true) {
					ids += tdArr.eq(1).text() + "_";
				}
			}
			if (ids.length == 0) {
				alert("没有选中任何班级");
				return;
			}
			$.post("deleteClass", {
				"ids" : ids
			}, function() {
				location.reload();
			})
		}
		
		
			//批量更新
		function update() {
			var tds = "";
			var trArr = $('#mytable tr');
			for (var i = 1; i < trArr.length; i++) {
				var tdArr = trArr.eq(i).find("td");
					tds = tds + tdArr.eq(1).text() + "_" + tdArr.eq(2).text()+ "_" + tdArr.eq(3).text() + "end" ;
			}
			$.post("updateClass", {
				"tds" : tds
			}, function() {
				location.reload();
			})
		}
		
		
	</script>


</body>
</html>