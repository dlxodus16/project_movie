<%@page import="java.io.PrintWriter"%>
<%@page import="movietheater.MovieTheaterDAO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	
	String name = request.getParameter("name");
	String city = request.getParameter("city");
	String address = request.getParameter("address");
	
	MovieTheaterDAO movietheater = new MovieTheaterDAO();
	int result = movietheater.write(name,city,address);
	if(result==0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 사용중인 파일 이름입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	else if(result==-1){
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