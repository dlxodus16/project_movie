<%@page import="showing.Showing_Detail"%>
<%@page import="showing.ShowingDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="movie.Movie"%>
<%@page import="movie.MovieDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="movietheater.MovieTheater"%>
<%@page import="movietheater.MovieTheaterDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.reserve-container {
    margin-top: 20px;
    display: flex;
    justify-content: center;
    height: 600px;
    /* border: 1px solid #dddddd; */
}

.reserve-container>div {
    border: 1px solid #dddddd;
}

.reserve-title {
    border-bottom: 1px solid #dddddd;
    background-color: #444444;
    text-align: center;
    color: #dddddd;
    padding: 5px;
    font-size: 13px;
    font-weight: bold;
}

.movie-part {
    width: 284px;
}

.theater-part {
    width: 364px;
}

.day-part {
    width: 475px;
}


.sort-wrapper {
    margin: 10px 6px 6px 10px;
    /* padding: 3px; */
    display: flex;
    border-bottom: 1px solid #dddddd;
    font-size: 12px;
}

.sort-wrapper>div {
    padding: 3px;
}

.sort-wrapper>div:hover {
    border-bottom: 1px solid #111111;
}

.sort-selected {
    font-weight: bold;
    border-bottom: 1px solid #111111;
}

.sort-korean {
    margin-left: 6px;
}

/* .reserve-date {
    padding-top: 5px;
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 770px;
    overflow: scroll;
    overflow-x: hidden;
} */

.movie-date-wrapper {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 5px 2px;
}

.movie-week-of-day {
    margin-left: 5px;
    font-size: 10px;
    width: 12px;
    height: 22px;
    line-height: 22px;
}

.movie-day {
    text-align: center;
    width: 34px;
    height: 22px;
    font-size: 17px;
    font-weight: bold;
}

.movie-date-wrapper-active {
    background-color: #333333;
}

.movie-date-wrapper-active>* {
    color: white;
}
.form-control2 {
  display: inline-block;
  width: 80%;
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
.textsize2{color:black; font-size:20px; margin:10px;}
.textsize3{color:black; font-size:20px;}
.center{text-align:center; padding:10px;}
.a{margin-left:10px;}

</style>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br>
<%
	request.setCharacterEncoding("utf-8");
	String city = request.getParameter("city");
	MovieTheaterDAO movietheaterdao = new MovieTheaterDAO();
	ArrayList<MovieTheater> movietheater = movietheaterdao.getList(city);
	
	int MOVIETHEATER_NO = 0;
	if(request.getParameter("MOVIETHEATER_NO")!=null){
		MOVIETHEATER_NO= Integer.parseInt(request.getParameter("MOVIETHEATER_NO"));
	}
	MovieDAO movie = new MovieDAO();
	ArrayList<Movie> list = movie.getShowingList(MOVIETHEATER_NO);
	
	int MOVIE_NO = 0;
	if(request.getParameter("MOVIE_NO")!=null){
		MOVIE_NO= Integer.parseInt(request.getParameter("MOVIE_NO"));
	}
	
	String search_date = request.getParameter("date");
	SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");
	Date time = new Date();
	String time1 = format1.format(time);
	String movie_title = movie.getMovieTitle(MOVIE_NO);
	
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
%>
    <div class="reserve-container">
            <div class="theater-part">
            <div class="reserve-title">극장</div>
            <div>
            	<form action="Reservation_Theater.jsp">
            		<br>&nbsp;<select name="city" id="city" class="form-control2">
              <option value="서울">서울</option>
              <option value="경기">경기</option>
              <option value="인천">인천</option>
              <option value="강원">강원</option>
              <option value="대전/충청">대전/충청</option>
              <option value="대구">대구</option>
              <option value="부산/울산">부산/울산</option>
              <option value="경상">경상</option>
              <option value="광주/전라/제주">광주/전라/제주</option>
              </select>
              <button class="btn btn-sm btn-primary" type="submit">검색</button><br><br>
            	</form>
            	<%
            		for(int i=0; i<movietheater.size(); i++){
            	%>
            	<a class="textsize2" href="Reservation_Movie.jsp?city=<%=city %>&MOVIETHEATER_NO=<%=movietheater.get(i).getMOVIETHEATER_NO()%>"><%=movietheater.get(i).getMOVIETHEATER_NAME() %></a><br>
            	<%
            		}
            	%>
            </div>
        </div>
        <div class="movie-part">
            <div class="reserve-title">영화</div>
            <div class="movie-list"> </div>
            <div>
            <br>
            	<%
            		for(int i=0; i<list.size(); i++){
            			int age = list.get(i).getMOVIE_AGE();
            			String age_string = "";
            			if(age==0){
            				age_string = "(ALL) "; 
            			}else if(age==19){
            				age_string="(청불) ";
            			}else{
            				age_string = "(" + age + ") ";
            			}
            	%>
            	<a class="textsize2" href="Reservation_Date.jsp?city=<%=city %>&MOVIETHEATER_NO=<%=MOVIETHEATER_NO%>&MOVIE_NO=<%=list.get(i).getMOVIE_NO()%>"><%=age_string%><%=list.get(i).getMOVIE_TITLE() %></a><br>
            	<%
            		}
            	%>
            </div>
        </div>
        <div class="day-part">
            <div class="reserve-title">날짜</div>
            <div>
            	<form method="post" action="Reservation_Date.jsp?city=<%=city %>&MOVIETHEATER_NO=<%=MOVIETHEATER_NO%>&MOVIE_NO=<%=MOVIE_NO%>"> <br>&nbsp;            	           
		<input type="date" name="date" class="form-control2" min="<%=time1 %>">
		<button class="btn btn-sm btn-primary" type="submit">검색</button><br><br>
</form>
			&nbsp;&nbsp;<font size="4em"><%=movie_title %></font>
			<%
				if(search_date != null){
					ShowingDAO showing = new ShowingDAO();
					ArrayList<Showing_Detail> lists = showing.search_reservation(MOVIE_NO,MOVIETHEATER_NO,search_date);

					for(int j=0;j<lists.size();j++){
						int theater_name = showing.getTheaterName(lists.get(j).getTHEATER_NO());
						String theater_names = theater_name + "관";
						int seat = showing.seat(lists.get(j).getTHEATER_NO());
						int remain_seat = seat - lists.get(j).getSHOWING_VISITOR();
						String seats = remain_seat + "/" + seat;
					

					
	%>
	<table border="1" class="a">
	
<td class="center">	
<a href="Seat.jsp?SHOWING_NO=<%=lists.get(j).getSHOWING_NO() %>&SHOWING_ROUND=<%=lists.get(j).getSHOWING_ROUND() %>" class="textsize3" onclick="return confirm('이 영화를 예매하시겠습니까?');">
	<%=lists.get(j).getSHOWING_TIME().substring(11,16) %><br>
	<%=theater_names %>&nbsp;<%=seats %>
</a>		
			</td>
</table>
<br>
<%
					}
				}
			%>
            </div>
        </div>
    </div>
</body>
</html>