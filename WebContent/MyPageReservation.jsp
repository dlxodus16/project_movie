<%@page import="showing.ShowingDAO"%>
<%@page import="reservation.Reservation"%>
<%@page import="reservation.ReservationDAO"%>
<%@page import="movie.MovieDAO"%>
<%@page import="favorite.Favorite"%>
<%@page import="movie.Movie"%>
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
		<th width="25%" class="text-center">영화제목</th>
		<th width="25%" class="text-center">영화관명</th>
		<th width="25%" class="text-center">인원수</th>
		<th width="25%" class="text-center">예매일</th>
	</tr>
</thead>
<tbody>
<%
	ReservationDAO reservation = new ReservationDAO();
	ArrayList<Reservation> list = reservation.getReservation(userID);
	for(int i=0;i<list.size();i++){
		ShowingDAO showing = new ShowingDAO();
		String movietitle = showing.getMovie(list.get(i).getSHOWING_NO());
		String movietheatername = showing.getMovietheater(list.get(i).getSHOWING_NO());
		int visitor = list.get(i).getRESERVATION_VISITOR();
		String date = list.get(i).getRESERVATION_DATE();
%>
	<tr>
		<th width="10%" class="text-center"><%=i+1%></th>
		<th width="25%" class="text-center"><%=movietitle %></th>
		<th width="25%" class="text-center"><%=movietheatername%></th>
		<th width="25%" class="text-center"><%=visitor%></th>
		<th width="25%" class="text-center"><%=date%></th>
	</tr>
		<%
		}
		%>
</tbody>
</table>

</div>
</body>
</html>