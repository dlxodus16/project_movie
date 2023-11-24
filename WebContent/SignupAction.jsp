<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.Member"%>
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
	String pw = request.getParameter("pw");
	String pwcheck = request.getParameter("pwcheck");
	String email = request.getParameter("email");
	String birth = request.getParameter("birth");
	
	SimpleDateFormat fDate = new SimpleDateFormat("yyyy-MM-dd");
	Date births = fDate.parse(birth);
	Date time = new Date();
	int compare = births.compareTo(time);

	
	Member member = new Member(id,pw,email,birth);

	MemberDAO user = new MemberDAO();
	if(pw.equals(pwcheck)){
		if(email.contains("@"))
			if(compare<0){
				int result = user.join(member);	
				if(result==-1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디 입니다.')");
					script.println("history.back()");
					script.println("</script>");	
				} else{
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'Main.jsp'");
					script.println("</script>");	
				}
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('생년월일을 확인해주세요.')");		
				script.println("history.back()");
				script.println("</script>");
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이메일 형식을 확인해주세요.')");
			script.println("history.back()");
			script.println("</script>");
		}
	} else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.')");		
		script.println("history.back()");
		script.println("</script>");
	}
%>
</body>
</html>