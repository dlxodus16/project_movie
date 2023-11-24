<%@page import="member.MemberDAO"%>
<%@page import="java.io.PrintWriter"%>
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
	String id = request.getParameter("id");

	MemberDAO user = new MemberDAO();
		int result = user.doublecheck(id);	
		if(result==1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('사용가능한 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");	
		} else if(result==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 사용중인 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");	
		}
%>
</body>
</html>