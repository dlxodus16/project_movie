<%@page import="review.ReviewDAO"%>
<%@page import="review.Review"%>
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
	int REVIEW_NO = 0;
	if(request.getParameter("REVIEW_NO")!=null){
		REVIEW_NO = Integer.parseInt(request.getParameter("REVIEW_NO"));
	}
	if (REVIEW_NO == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'Main_admin.jsp'");
		script.println("</script>");
	}
	Review review = new ReviewDAO().getreview(REVIEW_NO);
	String grade = Integer.toString(review.getREVIEW_GRADE());
%>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container1">
	<form action="ReviewUpdateAction.jsp?REVIEW_NO=<%=REVIEW_NO%>" method="post">
	<input type="radio" name="grade" value="5" <%="5".equals(grade)?"checked":"" %>>★★★★★&nbsp;
	<input type="radio" name="grade" value="4" <%="4".equals(grade)?"checked":"" %>>★★★★☆&nbsp;
	<input type="radio" name="grade" value="3" <%="3".equals(grade)?"checked":"" %>>★★★☆☆&nbsp;
	<input type="radio" name="grade" value="2" <%="2".equals(grade)?"checked":"" %>>★★☆☆☆&nbsp;
	<input type="radio" name="grade" value="1" <%="1".equals(grade)?"checked":"" %>>★☆☆☆☆<br><br>
	<textarea name="content" class="form-control" placeholder="내용을 입력해주세요."maxlength="1024" style="height: 100px;"required><%=review.getREVIEW_CONTENT() %></textarea><br>
	<button class="btn btn-lg btn-primary btn-block" type="submit">댓글 수정</button>
	</form>
</div>
</body>
</html>