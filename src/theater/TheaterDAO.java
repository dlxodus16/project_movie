package theater;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import movietheater.MovieTheater;

public class TheaterDAO {
	private Connection conn;
	private ResultSet result;
	
	public TheaterDAO() {
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
		String sql = "SELECT THEATER_NO FROM THEATER ORDER BY 1 DESC";
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
	
	public int getMovieTheaterNO(String MOVIETHEATER_NAME) {
		String sql = "SELECT MOVIETHEATER_NO FROM MOVIETHEATER WHERE MOVIETHEATER_NAME=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setNString(1, MOVIETHEATER_NAME);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getTheaterNO(int MOVIETHEATER_NO) {
		String sql = "SELECT THEATER_NAME FROM THEATER WHERE MOVIETHEATER_NO=? ORDER BY 1 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
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
	
	public int write(int MOVIETHEATER_NO, int THEATER_ROW, int THEATER_COLUMN) {
		String sql = "INSERT INTO THEATER VALUES(?,?,?,?,?)";
		try {						
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,getNo());
			pstmt.setInt(2, MOVIETHEATER_NO);
			pstmt.setInt(3, getTheaterNO(MOVIETHEATER_NO));
			pstmt.setInt(4, THEATER_ROW);
			pstmt.setInt(5, THEATER_COLUMN);
		
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int theater_count(int MOVIETHEATER_NO) {
		String sql = "SELECT COUNT(*) FROM THEATER WHERE MOVIETHEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int seat_count(int MOVIETHEATER_NO) {
		String sql = "SELECT SUM(THEATER_ROW*THEATER_COLUMN) FROM THEATER WHERE MOVIETHEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<Theater> getList(int MOVIETHEATER_NO){
			String sql = "SELECT * FROM THEATER WHERE MOVIETHEATER_NO = ? ORDER BY THEATER_NAME";
			ArrayList<Theater> list = new ArrayList<Theater>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, MOVIETHEATER_NO);
				result = pstmt.executeQuery();
				while(result.next()) {
					Theater theater = new Theater();
					theater.setTHEATER_NO(result.getInt(1));
					theater.setMOVIETHEATER_NO(result.getInt(2));
					theater.setTHEATER_NAME(result.getInt(3));
					theater.setTHEATER_ROW(result.getInt(4));
					theater.setTHEATER_COLUMN(result.getInt(5));
					list.add(theater);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
	}
	
	public int delete(int THEATER_NO) {
		String sql = "DELETE FROM THEATER WHERE THEATER_NO=?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, THEATER_NO);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} return -1;
	}
}
