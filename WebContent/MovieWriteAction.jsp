<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="movie.MovieDAO"%>
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
	String fileSave= "/fileSave";		
	String real = application.getRealPath(fileSave);
	int max = 1024*1024*10;
	MultipartRequest multi = new MultipartRequest(request, real, max, "utf-8", new DefaultFileRenamePolicy());
	String title = multi.getParameter("title");
	String director = multi.getParameter("director");
	String actor = multi.getParameter("actor");
	String type = multi.getParameter("type");	
	String open = multi.getParameter("open");
	String close = multi.getParameter("close");
	int age = Integer.parseInt(multi.getParameter("age"));
	int time = Integer.parseInt(multi.getParameter("time"));
	String content = multi.getParameter("content");
	String image = multi.getOriginalFileName("image");
	
	SimpleDateFormat fDate = new SimpleDateFormat("yyyy-MM-dd");
	Date opens = fDate.parse(open);
	Date closes = fDate.parse(close);
	int compare = opens.compareTo(closes);

	if(compare == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('개봉일보다 종영일이 빠릅니다.')");		
		script.println("history.back()");
		script.println("</script>");
	} else{
		MovieDAO movie = new MovieDAO();
		int result = movie.write(title,director,actor,type,open,close,age,time,image,content);
			if(result==0){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 사용중인 파일 이름입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else if(result==-1){
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
	}
%>
</body>
</html>