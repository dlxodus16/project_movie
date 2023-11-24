<%@page import="review.ReviewDAO"%>
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
	int REVIEW_NO = 0;
	if(request.getParameter("REVIEW_NO")!=null){
		REVIEW_NO = Integer.parseInt(request.getParameter("REVIEW_NO"));
	}
	if (REVIEW_NO== 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 댓글 입니다.')");
		script.println("location.href = 'Main.jsp'");
		script.println("</script>");
	}
	int grade = Integer.parseInt(request.getParameter("grade"));
	String content = request.getParameter("content");
	
	ReviewDAO review = new ReviewDAO();
	int result = review.update(REVIEW_NO,grade,content);
	if(result==-1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글 수정에 실패했습니다')");
			script.println("history.back()");
				script.println("</script>");
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='Main.jsp'");		
			script.println("</script>");
	}
%>
</body>
</html>