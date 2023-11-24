<%@page import="review.Review"%>
<%@page import="java.util.ArrayList"%>
<%@page import="review.ReviewDAO"%>
<%@page import="favorite.FavoriteDAO"%>
<%@page import="movie.MovieDAO"%>
<%@page import="movie.Movie"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.container1 {
  padding-right: 600px;
  padding-left: 600px;
  margin-right: auto;
  margin-left: auto;
}
	.pull-right {
  	float: right !important;
  	margin-left: 10px;
}
</style>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<%
	request.setCharacterEncoding("utf-8");
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	int MOVIE_NO = 0;
	if(request.getParameter("MOVIE_NO")!=null){
		MOVIE_NO= Integer.parseInt(request.getParameter("MOVIE_NO"));
	}
	if (MOVIE_NO == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'Main.jsp'");
		script.println("</script>");
	}
	Movie movie = new MovieDAO().getmovie(MOVIE_NO);
	FavoriteDAO favorite = new FavoriteDAO();
	ReviewDAO review = new ReviewDAO();
	float avg = review.getAvg(MOVIE_NO).getREVIEW_AVG();
	String num = String.format("%.1f",avg);
	int favorite_check = favorite.favoritecheck(userID,MOVIE_NO);
	String open = movie.getMOVIE_OPEN();
	open = open.substring(0,10);
%>
<div class="container">		
	<img src="fileSave/<%=movie.getMOVIE_IMAGE() %>" align="left" width="25%" style="margin:20px;"><br>
	<font size="6.5em"><strong><%=movie.getMOVIE_TITLE() %></strong></font><br><br>
	<font size="5em">평점 : <%=num %>/5.0점&nbsp;&nbsp;&nbsp;&nbsp;누적 관객수 : <%=movie.getMOVIE_VISITOR() %>명<br></font><hr>
	<font size="4em">장르 : <%=movie.getMOVIE_TYPE() %>   |   <%=open %> 개봉   |   <%=movie.getMOVIE_TIME() %>분</font><br>
	<font size="4em">감독 : <%=movie.getMOVIE_DIRECTOR() %></font><br>
	<font size="4em">배우 : <%=movie.getMOVIE_ACTOR() %></font><br><br>
	<form action="Reservation.jsp" method="post">
	<%if(userID!=null){ 
	if(favorite_check == 0){%>
	<a href="FavoriteAdd.jsp?userID=<%=userID%>&MOVIE_NO=<%=MOVIE_NO%>"><img src="fileSave/heart_no.PNG" width="40" height="32" style="margin-left:20px;margin-right:20px;"></a>
	<%} else if(favorite_check == 1){ %>
	<a href="FavoriteDelete.jsp?userID=<%=userID%>&MOVIE_NO=<%=MOVIE_NO%>"><img src="fileSave/heart_yes.PNG" width="40" height="32" style="margin-left:20px;margin-right:20px;"></a>
	<%} %>
	<button class="btn btn-lg btn-danger" type="submit">예매</button>
	</form>
	<%} %>
			<table class="table">
		<tbody>
			<tr>
				<td style="width:20%;">영화정보</td>
			</tr>
			<tr>
				<td colspan="2" style="min-height:200px;text-align:left;"><%=movie.getMOVIE_CONTENT() %></td>
			</tr>
		</tbody>
	</table>
	<br>
	<font size="5em">평점 및 관람평</font>
	<hr>
	<%
		if(userID!=null && !userID.equals("admin")){
	%>
	<form action="ReviewWrite.jsp?MOVIE_NO=<%=MOVIE_NO%>" method="post">
	<input type="radio" name="grade" value="5" checked>★★★★★&nbsp;
	<input type="radio" name="grade" value="4">★★★★☆&nbsp;
	<input type="radio" name="grade" value="3">★★★☆☆&nbsp;
	<input type="radio" name="grade" value="2">★★☆☆☆&nbsp;
	<input type="radio" name="grade" value="1">★☆☆☆☆<br><br>
	<textarea name="content" class="form-control" placeholder="내용을 입력해주세요."maxlength="1024" style="height: 100px;"required></textarea><br>
	<button class="btn btn-sm btn-info pull-right" type="submit">댓글 등록</button>
	</form>
	<%} %>
	<br><br>
		<%
		ArrayList<Review> list = review.getList(MOVIE_NO);
		for(int i=0;i<list.size();i++){
	%>
	<table class="table">
		<tbody>
			<tr>
				<td colspan="2"><%=list.get(i).getMEMBER_ID()%> | ★<%=list.get(i).getREVIEW_GRADE() %> <br><%=list.get(i).getREVIEW_CONTENT() %></td>	
				</tr>
				<tr>
				<td></td>
				<td>	
				<%
					if(userID!=null && userID.equals(list.get(i).getMEMBER_ID())) {
				%>
				<a onclick="return confirm('정말로 삭제하시겠습니가?')" href="ReviewDelete.jsp?REVIEW_NO=<%=list.get(i).getREVIEW_NO()%>" class="btn btn-sm btn-primary pull-right">삭제</a>
				<a href="ReviewUpdate.jsp?REVIEW_NO=<%=list.get(i).getREVIEW_NO()%>" class="btn btn-sm btn-primary pull-right">수정</a>
				<%
					} 
				if (userID!=null && userID.equals("admin")) {
				%>
				<a onclick="return confirm('정말로 삭제하시겠습니가?')" href="ReviewDelete.jsp?REVIEW_NO=<%=list.get(i).getREVIEW_NO()%>" class="btn btn-sm btn-primary pull-right">삭제</a>
				<%
					}
				%>
				</td>	
			</tr>							
	<%
		}
	%>		
		</tbody>
	</table>
	<br><br>
	</div>
</body>
</html>