<%@page import="java.io.PrintWriter"%>
<%@page import="theater.TheaterDAO"%>
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
	int row = Integer.parseInt(request.getParameter("row"));
	int column = Integer.parseInt(request.getParameter("column"));
	TheaterDAO theater = new TheaterDAO();
	int Theaterno = theater.getMovieTheaterNO(movietheater);
	int result = theater.write(Theaterno,row,column);
	if(result==-1){
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