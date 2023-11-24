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
	String email = request.getParameter("email");

	MemberDAO user = new MemberDAO();
		int result = user.searchid(email);	
		if(result==1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('해당 이메일로 정보를 전송했습니다.')");
			script.println("location.href = 'Main.jsp'");
			script.println("</script>");	
		} else if(result==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 이메일입니다.')");
			script.println("history.back()");
			script.println("</script>");	
		}
%>
</body>
</html>