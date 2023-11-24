<%@page import="movietheater.MovieTheater"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movietheater.MovieTheaterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.list{list-style-type:none; float:left; margin-left:40px; font-size:20px;}
	.text{ color:black;}
	.text:hover{color:black;}
	.a{margin:50px;font-size:16px;color:black;}
	.a:hover{color:black;}
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");	
	String city = null;
	city = request.getParameter("city");	
%>
<jsp:include page="top.jsp" flush="false"/><br><br>
<div class="container">
	<hr>
	<ul class="list">
		<li class="list"><a class="text" href="MovieTheater.jsp?city=서울">서울</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=경기">경기</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=인천">인천</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=강원">강원</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=대전/충청">대전/충청</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=대구">대구</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=부산/울산">부산/울산</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=경상">경상</a></li>
		<li class="list"><a class="text" href="MovieTheater.jsp?city=광주/전라/제주">광주/전라/제주</a></li>
	</ul>
	<br><br>
	<hr>
	
		<%
		MovieTheaterDAO movietheater = new MovieTheaterDAO();
			ArrayList<MovieTheater> list = movietheater.getList(city);
			int size = list.size();
			for(int i=0;i<size;i++){
		%>
			<a href="viewMovieTheater.jsp?MOVIETHEATER_NO=<%=list.get(i).getMOVIETHEATER_NO()%>" class="a">
			<%=list.get(i).getMOVIETHEATER_NAME() %>
		<%		
			}
		%>
</div>
</body>
</html>