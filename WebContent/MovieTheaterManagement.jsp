<%@page import="theater.TheaterDAO"%>
<%@page import="movietheater.MovieTheater"%>
<%@page import="movietheater.MovieTheaterDAO"%>
<%@page import="movie.Movie"%>
<%@page import="movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.Member"%>
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
h1{font-size:50px;}
.menu{
	backgroud-color:#FFDAB9;
	width: 200px;
	list-style-type:none;
	margin:0;
	padding:0;
	borader:solid 1px black;
}
.menu_list{border-bottom:solid 1px black;}
.menu_list:last-child{border-bottom:none;}
.menu_list a{
	display:block;
	color:#000000;
	padding:8px;
	text-align:left;
	text-decoration:none;
	font-weight:bold;
	font-size:24px;
}
.menu_list a.current{background-color:#FF6347; color:white;}
.menu_list a:hover:not{backgroud-color:#CD853F; color:white;}
.a { border-right: 1px solid black; width: 1px; height: 500px; padding-right:210px; text-align:justify }
.container1 {
  padding-right: 400px;
  padding-left: 700px;
  margin-right: auto;
  margin-left: auto;
}
</style>
<script>
	function check(){
		var result = confirm ('삭제하겠습니까?');
		if(result){
			return true;
		} else{
			return false;
		}
	}
</script>
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
	<a href="Main_admin.jsp"><img align="left" src="fileSave/logo.png"></a>
	<h1 align="center">TY Theater</h1>
<ul>
		<li class=login><a href="LogoutAction.jsp">로그아웃</a></li>
</ul>
	<br>
	<hr>
</div>
<div class="container" align="center">
	<a class="textsize" href="Reservation.jsp">예매</a>
	<a class="textsize" href="Movie.jsp">영화</a>
	<a class="textsize" href="MovieTheater.jsp">영화관</a>
	<hr>
</div>
<div class="container">
<div class="a">
<ul class="menu">
	<li class="menu_list"><a href="MovieWrite.jsp" >영화 등록</a></li>
	<li class="menu_list"><a href="MovieTheaterWrite.jsp" >영화관 등록</a></li>
	<li class="menu_list"><a href="MemberManagement.jsp" >회원 관리</a></li>
	<li class="menu_list"><a href="MovieManagement.jsp" >영화 관리</a></li>
	<li class="menu_list"><a href="MovieTheaterManagement.jsp" >영화관 관리</a></li>
	<li class="menu_list"><a href="TheaterWrite.jsp" >상영관 등록</a></li>
	<li class="menu_list"><a href="ShowingWrite.jsp" >상영 정보 등록</a></li>
	<li class="menu_list"><a href="ShowingManagement.jsp" >등록된 영화 정보</a></li>
</ul>
</div>
</div>
<div class="container1">
<table class="table table-striped" style="position:relative;bottom:450px;">
<thead>
	<tr>
		<th width="10%" class="text-center">No.</th>
		<th width="20%" class="text-center">영화관 이름</th>
		<th width="20%" class="text-center">지역</th>
		<th width="30%" class="text-center">주소</th>
		<th width="10%" class="text-center">관수</th>
		<th width="10%" class="text-center">수정</th>
		<th width="10%" class="text-center">삭제</th>
	</tr>
</thead>
<tbody>
<%
	MovieTheaterDAO movietheater = new MovieTheaterDAO();
	ArrayList<MovieTheater> list = movietheater.getList();
	for(int i=0;i<list.size();i++){
		TheaterDAO theater = new TheaterDAO();
		int theater_count = theater.theater_count(list.get(i).getMOVIETHEATER_NO());
%>
	<tr>
		<th width="10%" class="text-center"><%=i+1%></th>
		<th width="20%" class="text-left"><a href="TheaterManagement.jsp?MOVIETHEATER_NO=<%=list.get(i).getMOVIETHEATER_NO()%>"><%=list.get(i).getMOVIETHEATER_NAME() %></a></th>
		<th width="20%" class="text-center"><%=list.get(i).getMOVIETHEATER_CITY() %></th>
		<th width="30%" class="text-left"><%=list.get(i).getMOVIETHEATER_ADDRESS() %></th>
		<th width="10%" class="text-center"><%=theater_count %></th>
		<form method="post" action="MovieTheaterUpdate.jsp?MOVIETHEATER_NO=<%=list.get(i).getMOVIETHEATER_NO() %>">
		<th width="10%" class="text-center"><input type="submit" value="수정"></th></form>
		<form method="post" action="MovieTheaterDelete.jsp?MOVIETHEATER_NO=<%=list.get(i).getMOVIETHEATER_NO() %>" onsubmit="return check()">
		<th width="10%" class="text-center"><input type="submit" value="삭제"></th></form>
	</tr>
		<%
		}
		%>
</tbody>
</table>
</div>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>