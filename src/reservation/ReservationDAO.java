package reservation;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import movie.Movie;

public class ReservationDAO {
	private Connection conn;
	private ResultSet result;
	
	public ReservationDAO() {
		try {
			String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
			String ID = "movie";
			String PW = "";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(URL,ID,PW);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNo() {
		String sql = "SELECT RESERVATION_NO FROM RESERVATION ORDER BY 1 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1)+1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int write(int SHOWING_NO,String userID,int SHOWING_ROUND,int ticketNumber,int payMoney) {
		String sql = "INSERT INTO RESERVATION VALUES(?,?,?,?,?,sysdate,?)";
		int RESERVATION_NO = getNo();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, RESERVATION_NO);
			pstmt.setInt(2, SHOWING_NO);
			pstmt.setString(3, userID);
			pstmt.setInt(4,SHOWING_ROUND);
			pstmt.setInt(5, ticketNumber);
			pstmt.setInt(6, payMoney);
			pstmt.executeUpdate();
			return RESERVATION_NO;
		
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int writedetail(int RESERVATION_NO, int RESERVATION_ROW, int RESERVATION_COLUMN) {
		String sql = "INSERT INTO RESERVATION_DETAIL VALUES(?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, RESERVATION_NO);
			pstmt.setInt(2,RESERVATION_ROW);
			pstmt.setInt(3, RESERVATION_COLUMN);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Reservation_Detail> getReservation(int SHOWING_NO, int SHOWING_ROUND){
		String sql = "SELECT * FROM RESERVATION_DETAIL WHERE RESERVATION_NO IN (SELECT RESERVATION_NO FROM RESERVATION WHERE SHOWING_NO=? AND SHOWING_ROUND=?)";
		ArrayList<Reservation_Detail> list = new ArrayList<Reservation_Detail>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
			pstmt.setInt(2, SHOWING_ROUND);
			result = pstmt.executeQuery();
			while(result.next()) {
				Reservation_Detail reservataion = new Reservation_Detail();
				reservataion.setRESERVATION_NO(result.getInt(1));
				reservataion.setRESERVATION_ROW(result.getInt(2));
				reservataion.setRESERVATION_COLUMN(result.getInt(3));
				list.add(reservataion);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public void Visitor(int SHOWING_NO, int SHOWING_ROUND, int ticketNumber) {
		ShowingVisitor(SHOWING_NO, SHOWING_ROUND, ticketNumber);
		MovieVisitor(SHOWING_NO, ticketNumber);
	}
	
	public void ShowingVisitor(int SHOWING_NO, int SHOWING_ROUND, int ticketNumber) {
		String sql = "UPDATE SHOWING_DETAIL SET SHOWING_VISITOR = SHOWING_VISITOR + ? WHERE SHOWING_NO = ? AND SHOWING_ROUND = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ticketNumber);
			pstmt.setInt(2, SHOWING_NO);
			pstmt.setInt(3, SHOWING_ROUND);
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void MovieVisitor(int SHOWING_NO, int ticketNumber) {
		String sql = "UPDATE MOVIE SET MOVIE_VISITOR = MOVIE_VISITOR + ? WHERE MOVIE_NO = (SELECT MOVIE_NO FROM SHOWING WHERE SHOWING_NO=?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ticketNumber);
			pstmt.setInt(2, SHOWING_NO);
			pstmt.executeQuery();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Reservation> getReservation(String MEMBER_ID){
		String sql = "SELECT * FROM RESERVATION WHERE MEMBER_ID= ? ORDER BY RESERVATION_DATE DESC";
		ArrayList<Reservation> list = new ArrayList<Reservation>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MEMBER_ID);
			result = pstmt.executeQuery();
			while(result.next()) {
				Reservation reservation = new Reservation();
				reservation.setRESERVATION_NO(result.getInt(1));
				reservation.setSHOWING_NO(result.getInt(2));
				reservation.setMEMBER_ID(result.getString(3));
				reservation.setSHOWING_ROUND(result.getInt(4));
				reservation.setRESERVATION_VISITOR(result.getInt(5));
				reservation.setRESERVATION_DATE(result.getString(6));
				reservation.setRESERVATION_MONEY(result.getInt(7));
				list.add(reservation);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}		
		return list;
	}
}	
