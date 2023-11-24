<%@page import="showing.Showing_Detail"%>
<%@page import="showing.Showing"%>
<%@page import="java.util.ArrayList"%>
<%@page import="showing.ShowingDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="theater.TheaterDAO"%>
<%@page import="movietheater.MovieTheaterDAO"%>
<%@page import="movietheater.MovieTheater"%>
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
.form-control2 {
  display: inline-block;
  width: 95%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
.center{text-align:center; padding:10px;}
</style>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<%
	request.setCharacterEncoding("utf-8");
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	int MOVIETHEATER_NO = 0;
	if(request.getParameter("MOVIETHEATER_NO")!=null){
		MOVIETHEATER_NO= Integer.parseInt(request.getParameter("MOVIETHEATER_NO"));
	}
	if (MOVIETHEATER_NO == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("location.href = 'Main.jsp'");
		script.println("</script>");
	}

	String search_date = request.getParameter("date");	
	MovieTheater movietheater = new MovieTheaterDAO().getmovietheater(MOVIETHEATER_NO);
	TheaterDAO theater = new TheaterDAO();
	int theater_count = theater.theater_count(MOVIETHEATER_NO);
	int seat_count = theater.seat_count(MOVIETHEATER_NO);
	SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
	Date time = new Date();
	String time1 = format1.format(time);
%>
<div class="container1">		
	<font size="6.5em"><strong><%=movietheater.getMOVIETHEATER_NAME() %></strong></font><br><br>
	<font size="4em">총 상영관  <%=theater_count %>개관   |  총 좌석수 <%=seat_count %>석<br></font><br>
	<font size="4em"><%=movietheater.getMOVIETHEATER_ADDRESS() %><br></font><br>
</div>
<div class="container">
<hr>
<form action="viewMovieTheater.jsp?MOVIETHEATER_NO=<%=MOVIETHEATER_NO%>">
	<input type="date" name="date" class="form-control2" min="<%=time1 %>">&nbsp;
	<input type="hidden" name="MOVIETHEATER_NO" value="<%=MOVIETHEATER_NO %>">
	<button class="btn btn-sm btn-primary" type="submit">검색</button><br><br>
</form>
<%
	if(search_date != null){
		ShowingDAO showing = new ShowingDAO();
		ArrayList<Showing> list = showing.search(MOVIETHEATER_NO,search_date);
		if(list!=null){
			int size = list.size();
			%>
				<font size="5em"><strong><%=search_date %></strong></font><br>
			<%
			for(int i=0;i<size;i++){
				String movie_title = showing.getMovieTitle(list.get(i).getMOVIE_NO());
				ArrayList<Showing_Detail> lists = showing.search_detail(list.get(i).getSHOWING_NO());
				%>
				<font size="4em"><%=movie_title%></font><br>
				<%
				for(int j=0;j<lists.size();j++){
					int theater_name = showing.getTheaterName(lists.get(j).getTHEATER_NO());
					String theater_names = theater_name + "관";
					int seat = showing.seat(lists.get(j).getTHEATER_NO());
					int remain_seat = seat - lists.get(j).getSHOWING_VISITOR();
					String seats = remain_seat + "/" + seat;

				
%>
<table border="1">
<td class="center">			
	<%=lists.get(j).getSHOWING_TIME().substring(11,16) %><br>
	<%=theater_names %>&nbsp;<%=seats %>

			</td>
</table>
<br>					
<% 
				}
			}
		}
	}
%>
</div>
</body>
</html>