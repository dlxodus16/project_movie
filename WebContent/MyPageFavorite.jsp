<%@page import="movie.Movie"%>
<%@page import="movie.MovieDAO"%>
<%@page import="favorite.Favorite"%>
<%@page import="java.util.ArrayList"%>
<%@page import="favorite.FavoriteDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.text{color:black; margin:10px;}
.text:hover{color:black;}
</style>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br><br>
<%
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
%>
<div class="container">
	<font size="6em"><strong><%=userID %>님의 마이페이지</strong></font><br>
	<hr>
	<font size="5em"><a href="MyPageReservation.jsp" class="text">예매내역</a>&nbsp;&nbsp;&nbsp;<a href="MyPageFavorite.jsp" class="text">찜목록</a><br></font><br>
<table class="table table-striped">
<thead>
	<tr>
		<th width="10%" class="text-center">No.</th>
		<th width="30%" class="text-center">영화제목</th>
	</tr>
</thead>
<tbody>
<%
	FavoriteDAO favorite = new FavoriteDAO();
	ArrayList<Favorite> list = favorite.getList(userID);
	for(int i=0;i<list.size();i++){
		Movie movie = new MovieDAO().getmovie(list.get(i).getMOVIE_NO());
%>
	<tr>
		<th width="10%" class="text-center"><%=i+1%></th>
		<th width="30%" class="text-center"><a href="viewMovie.jsp?MOVIE_NO=<%=movie.getMOVIE_NO()%>"><%=movie.getMOVIE_TITLE() %></a></th>
	</tr>
		<%
		}
		%>
</tbody>
</table>

</div>

</body>
</html>