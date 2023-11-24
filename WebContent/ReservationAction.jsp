<%@page import="java.io.PrintWriter"%>
<%@page import="reservation.ReservationDAO"%>
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
	String userID = null;
	if(session.getAttribute("userID") != null)
	{
		userID = (String) session.getAttribute("userID");
	}
	int payMoney = Integer.parseInt(request.getParameter("payMoney")); //총금액
	int ticketNumber = Integer.parseInt(request.getParameter("ticketNumber")); //인원수
	String selectedSeat = request.getParameter("selectedSeat"); //좌석번호
	int SHOWING_NO = 0;
	if(request.getParameter("SHOWING_NO")!=null){
		SHOWING_NO= Integer.parseInt(request.getParameter("SHOWING_NO"));
	}
	int SHOWING_ROUND = 0;
	if(request.getParameter("SHOWING_ROUND")!=null){
		SHOWING_ROUND= Integer.parseInt(request.getParameter("SHOWING_ROUND"));
	}
	ReservationDAO reservation = new ReservationDAO();
	int result = reservation.write(SHOWING_NO,userID,SHOWING_ROUND,ticketNumber,payMoney);
	reservation.Visitor(SHOWING_NO, SHOWING_ROUND, ticketNumber);
	
	if(result==-1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('예매에 실패했습니다')");
		script.println("history.back()");
			script.println("</script>");
	} else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='Main.jsp'");		
		script.println("</script>");
	}
	
	String[] seat = selectedSeat.split(",");
	for(int i=0; i<seat.length; i++){
		int row	= Integer.parseInt(seat[i].substring(1,2));
		int column = 0;
		String col = seat[i].substring(0,1);
		if(col.equals("A")){
			column = 0;
		} else if(col.equals("B")){
			column = 1;
		} else if(col.equals("C")){
			column = 2;
		} else if(col.equals("D")){
			column = 3;
		} else if(col.equals("E")){
			column = 4;
		} else if(col.equals("F")){
			column = 5;
		} else if(col.equals("G")){
			column = 6;
		} else if(col.equals("H")){
			column = 7;
		} else if(col.equals("I")){
			column = 8;
		} else if(col.equals("J")){
			column = 9;
		} else if(col.equals("K")){
			column = 10;
		}
		reservation.writedetail(result, row, column);
	}
%>
</body>
</html>