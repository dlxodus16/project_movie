<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.css">
<style>
.textsize{color:black; font-size:20px; margin:10px;}
.textsize:hover{color:black; font-size:25px; font-weight: bold;}
h1{font-size:50px;}
</style>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
%>
<br><br>
<div class="container theme-showcase">
<%if (userID==null) {%>
<a href="Main.jsp"><img align="left" src="fileSave/logo.png"></a>
<%}else if(userID.equals("admin")) {%>
	<a href="Main_admin.jsp"><img align="left" src="fileSave/logo.png"></a>
	<%}else{ %>
		<a href="Main.jsp"><img align="left" src="fileSave/logo.png"></a>
	<%} %>
	<h1 align="center">TY Theater</h1>
	<hr>
</div>
<div align="center">
	<a class="textsize" href="Reservation.jsp">예매</a>
	<a class="textsize" href="Movie.jsp">영화</a>
	<a class="textsize" href="MovieTheater.jsp">영화관</a>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>