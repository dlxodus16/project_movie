<%@page import="movie.Movie"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movie.MovieDAO"%>
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
.login {list-style: none; display:inline; float:right; margin:8px;}
.center{text-align:center;}
h1{font-size:50px;}
.a{float:right;}
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
	<a href="Main.jsp"><img align="left" src="fileSave/logo.png"></a>
	<h1 align="center">TY Theater</h1>
	<%
	if(userID==null){
%>
	<ul>
		<li class="login"><a href="Signup.jsp">회원가입</a></li>
		<li class="login"><a href="Login.jsp">로그인</a></li>
	</ul>
	<%
	}else{
	%>
		<ul>
		<li class=login><a href="LogoutAction.jsp">로그아웃</a></li>
		<li class=login><a href="MyPage.jsp">마이페이지</a></li>
		<li class=login><strong><%=userID %>님</strong></li>		
	</ul>	
	<%
	}
%>
	<br>
	<hr>
</div>
<div class="container1" align="center">
	<a class="textsize" href="Reservation.jsp">예매</a>
	<a class="textsize" href="Movie.jsp">영화</a>
	<a class="textsize" href="MovieTheater.jsp">영화관</a>
</div>
<br><br>
<div class="container">
	<font size="5.5em"><strong>&nbsp;&nbsp;&nbsp;현재 상영작 TOP5</strong></font><br><br>
		<table border="1">
		<%
			MovieDAO movie = new MovieDAO();
			ArrayList<Movie> list = movie.getList();
			int size = list.size();
			for(int i=0;i<5;i++){
				if(i%5==0){
		%>
				<tr>
		<%} %>
			<td width="20%" class="center">
			<a href="viewMovie.jsp?MOVIE_NO=<%=list.get(i).getMOVIE_NO()%>">
			<img src="fileSave/<%=list.get(i).getMOVIE_IMAGE() %>" width="80%" style="margin:20px;"></a><br>
			<%=list.get(i).getMOVIE_TITLE() %>
				</td>
				<% 
				if(i%5==4){
				%>
		</tr>
		<%
				}
				%>
		<%		
			}
		%>
	</table>
	<br><br><br><br>
	<div class="a">
		<form action="MovieSearch.jsp">
			<input type="text" name="search">
			<input type="submit" value="검색">
		</form>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>