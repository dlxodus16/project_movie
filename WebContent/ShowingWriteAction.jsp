<%@page import="movie.Movie"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="showing.ShowingDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String movietheater = request.getParameter("movietheater");
	String theater = request.getParameter("theater");
	String movie = request.getParameter("movie");
	String show_date = request.getParameter("show_date");
	String show_time = request.getParameter("show_time");
	ShowingDAO show = new ShowingDAO();
	int result = show.write(movietheater,movie,theater,show_date,show_time);
		if(result==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='Main_admin.jsp'");		
			script.println("</script>");
		}

%>
</body>
</html>