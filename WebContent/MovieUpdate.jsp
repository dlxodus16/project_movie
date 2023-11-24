<%@page import="movie.Movie"%>
<%@page import="movie.MovieDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
</style>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	int MOVIE_NO = 0;
	if(request.getParameter("MOVIE_NO")!=null){
		MOVIE_NO = Integer.parseInt(request.getParameter("MOVIE_NO"));
	}
	if (MOVIE_NO == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'Main_admin.jsp'");
		script.println("</script>");
	}
	Movie movie = new MovieDAO().getmovie(MOVIE_NO);
	String age = Integer.toString(movie.getMOVIE_AGE());
%>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container1">
	<form action="MovieUpdateAction.jsp?MOVIE_NO=<%=MOVIE_NO%>" method="post" enctype="multipart/form-data">
		영화 제목<input type="text" name="title" class="form-control" placeholder="영화 제목을 입력해주세요." value="<%=movie.getMOVIE_TITLE() %>" required autofocus><br>
		감독<input type="text" name="director" class="form-control" placeholder="감독을 입력해주세요." value="<%=movie.getMOVIE_DIRECTOR() %>" required><br>
		출연자<input type="text" name="actor" class="form-control" placeholder="출연자를 입력해주세요." value="<%=movie.getMOVIE_ACTOR() %>" required><br>
		장르<input type="text" name="type" class="form-control" placeholder="장르를 입력해주세요." value="<%=movie.getMOVIE_TYPE() %>" required><br>
		개봉일<input type="date" name="open" class="form-control" value="<%=movie.getMOVIE_OPEN().substring(0,10) %>"><br><br>
		종영일<input type="date" name="close" class="form-control" value="<%=movie.getMOVIE_CLOSE().substring(0,10) %>"><br><br>
              관람등급<select name="age" class="form-control" value="<%=movie.getMOVIE_AGE()%>">
              <option value="00" <%="0".equals(age)?"selected":"" %>>ALL</option>
              <option value="07" <%="7".equals(age)?"selected":"" %>>7</option>
              <option value="12" <%="12".equals(age)?"selected":"" %>>12</option>
              <option value="15" <%="15".equals(age)?"selected":"" %>>15</option>
              <option value="19" <%="19".equals(age)?"selected":"" %>>19</option>
              </select><br>
              관람시간<input type="number" name="time" class="form-control" maxlength="3" oninput="maxLengthCheck(this)" value="<%=movie.getMOVIE_TIME() %>"required><br>
		상세 설명<textarea name="content" class="form-control" placeholder="내용을 입력해주세요."maxlength="2048" style="height: 200px;" required><%=movie.getMOVIE_CONTENT() %></textarea><br>
		<input type="file" name="image"><br><br>
		<button class="btn btn-lg btn-primary btn-block" type="submit">수정</button><br><br>
	</form>
</div>
</body>
</html>