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
<style>
	.container1 {
  padding-right: 600px;
  padding-left: 600px;
  margin-right: auto;
  margin-left: auto;
}
.center{text-align:center;}
</style>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container">
	<table border="1">
		<%
			MovieDAO movie = new MovieDAO();
			ArrayList<Movie> list = movie.getList();
			int size = list.size();
			for(int i=0;i<size;i++){
				if(i%4==0){
		%>
				<tr>
		<%} %>
			<td width="25%" class="center">
			<a href="viewMovie.jsp?MOVIE_NO=<%=list.get(i).getMOVIE_NO()%>">
			<img src="fileSave/<%=list.get(i).getMOVIE_IMAGE() %>" width="80%" style="margin:20px;"></a><br>
			<%=list.get(i).getMOVIE_TITLE() %>
				</td>
				<% 
				if(i%4==3){
				%>
		</tr>
		<%
				}
				%>
		<%		
			}
		%>
	</table>
	<br><br>
</div>
</body>
</html>