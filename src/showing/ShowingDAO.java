package showing;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import movie.Movie;
import theater.Theater;

public class ShowingDAO {
	private Connection conn;
	private ResultSet result;
	
	public ShowingDAO() {
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
	
	public int getMovieNo(String MOVIE_TITLE) {
		String sql = "SELECT MOVIE_NO FROM MOVIE WHERE MOVIE_TITLE=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MOVIE_TITLE);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getMovieTheaterNo(String MOVIETHEATER_NAME) {
		String sql = "SELECT MOVIETHEATER_NO FROM MOVIETHEATER WHERE MOVIETHEATER_NAME=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			result = null;
			pstmt.setString(1, MOVIETHEATER_NAME);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getTheaterNo(String THEATER_NAME, int MOVIETHEATER_NO) {
		String sql = "SELECT THEATER_NO FROM THEATER WHERE THEATER_NAME=? AND MOVIETHEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, THEATER_NAME);
			pstmt.setInt(2, MOVIETHEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
			return 0;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int getNo() {
		String sql = "SELECT SHOWING_NO FROM SHOWING ORDER BY 1 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet re = pstmt.executeQuery();
			if(re.next()) {
				return re.getInt(1)+1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int getRound(int SHOWING_NO) {
		String sql = "SELECT SHOWING_ROUND FROM SHOWING_DETAIL WHERE SHOWING_NO=? ORDER BY 1 DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
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

	public int write(String MOVIETHEATER_NAME, String MOVIE_TITLE, String THEATER_NAME, String SHOWING_DATE, String SHOWING_TIME) {
		int MOVIETHEATER_NO = getMovieTheaterNo(MOVIETHEATER_NAME);
		int MOVIE_NO = getMovieNo(MOVIE_TITLE);
		int THEATER_NO = getTheaterNo(THEATER_NAME, MOVIETHEATER_NO);
		String time = SHOWING_DATE + " " + SHOWING_TIME;
		String sql= "SELECT SHOWING_NO FROM SHOWING WHERE MOVIE_NO =? AND MOVIETHEATER_NO = ? AND SHOWING_DATE = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			pstmt.setInt(2, MOVIETHEATER_NO);
			pstmt.setString(3, SHOWING_DATE);
			result = pstmt.executeQuery();
			if(result.next()) {
				int SHOWING_NO = result.getInt(1);
				int SHOWING_ROUND = getRound(SHOWING_NO);
				sql = "INSERT INTO SHOWING_DETAIL VALUES(?,?,?,0,to_date(?, 'yyyy-mm-dd hh24:mi'))";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, SHOWING_NO);
				pstmt.setInt(2, SHOWING_ROUND);
				pstmt.setInt(3, THEATER_NO);
				pstmt.setString(4, time);
				return pstmt.executeUpdate();
			}else {
				int SHOWING_NO = getNo();
				sql = "INSERT INTO SHOWING VALUES(?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, SHOWING_NO);
				pstmt.setInt(2, MOVIE_NO);
				pstmt.setInt(3, MOVIETHEATER_NO);
				pstmt.setString(4, SHOWING_DATE);
				pstmt.executeUpdate();
				
				sql = "INSERT INTO SHOWING_DETAIL VALUES(?,1,?,0,to_date(?, 'yyyy-mm-dd hh24:mi'))";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, SHOWING_NO);
				pstmt.setInt(2, THEATER_NO);
				pstmt.setString(3, time);
				return pstmt.executeUpdate();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<Showing> search(int MOVIETHEATER_NO, String SHOWING_DATE) {
		String sql = "SELECT * FROM SHOWING WHERE MOVIETHEATER_NO = ? AND SHOWING_DATE = ? ORDER BY SHOWING_NO";
		ArrayList<Showing> list = new ArrayList<Showing>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			pstmt.setString(2, SHOWING_DATE);
			result = pstmt.executeQuery();
			while(result.next()) {
				Showing showing = new Showing();
				showing.setSHOWING_NO(result.getInt(1));
				showing.setMOVIE_NO(result.getInt(2));
				showing.setMOVIETHEATER_NO(result.getInt(3));
				showing.setSHOWING_DATE(result.getString(4));
				list.add(showing);
			}
			return list;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String getMovieTitle(int MOVIE_NO) {
		String sql = "SELECT MOVIE_TITLE FROM MOVIE WHERE MOVIE_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String getMovieTheaterName(int MOVIETHEATER_NO) {
		String sql = "SELECT MOVIETHEATER_NAME FROM MOVIETHEATER WHERE MOVIETHEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public ArrayList<Showing_Detail> search_detail(int SHOWING_NO) {
		String sql = "SELECT * FROM SHOWING_DETAIL WHERE SHOWING_NO=? ORDER BY SHOWING_ROUND";
		ArrayList<Showing_Detail> list = new ArrayList<Showing_Detail>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
			result = pstmt.executeQuery();
			while(result.next()) {
				Showing_Detail showing = new Showing_Detail();
				showing.setSHOWING_NO(result.getInt(1));
				showing.setSHOWING_ROUND(result.getInt(2));
				showing.setTHEATER_NO(result.getInt(3));
				showing.setSHOWING_VISITOR(result.getInt(4));
				showing.setSHOWING_TIME(result.getString(5));
				list.add(showing);
			}
			return list;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int getTheaterName(int THEATER_NO) {
		String sql = "SELECT THEATER_NAME FROM THEATER WHERE THEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, THEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public int seat(int THEATER_NO) {
		String sql="SELECT * FROM THEATER WHERE THEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, THEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(4) * result.getInt(5);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<Showing_Detail> search_reservation(int MOVIE_NO, int MOVIETHEATER_NO, String SHOWING_DATE) {
		String sql = "SELECT * FROM SHOWING_DETAIL WHERE SHOWING_NO IN (SELECT DISTINCT SHOWING_NO FROM SHOWING WHERE MOVIE_NO=? AND MOVIETHEATER_NO=? AND SHOWING_DATE=?) ORDER BY SHOWING_TIME";
		ArrayList<Showing_Detail> list = new ArrayList<Showing_Detail>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			pstmt.setInt(2, MOVIETHEATER_NO);
			pstmt.setString(3, SHOWING_DATE);
			result = pstmt.executeQuery();
			while(result.next()) {
				Showing_Detail showing = new Showing_Detail();
				showing.setSHOWING_NO(result.getInt(1));
				showing.setSHOWING_ROUND(result.getInt(2));
				showing.setTHEATER_NO(result.getInt(3));
				showing.setSHOWING_VISITOR(result.getInt(4));
				showing.setSHOWING_TIME(result.getString(5));
				list.add(showing);
			}
			return list;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<Showing> getShowingList() {
		String sql = "SELECT * FROM SHOWING WHERE SYSDATE-1<SHOWING_DATE";
		ArrayList<Showing> list = new ArrayList<Showing>();
		try{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			result = pstmt.executeQuery();
			while(result.next()) {
				Showing showing = new Showing();
				showing.setSHOWING_NO(result.getInt(1));
				showing.setMOVIE_NO(result.getInt(2));
				showing.setMOVIETHEATER_NO(result.getInt(3));
				showing.setSHOWING_DATE(result.getString(4));
				list.add(showing);
			}
			return list;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public Theater getTheater(int SHOWING_NO, int SHOWING_ROUND) {
		String sql="SELECT * FROM THEATER WHERE THEATER_NO=?";
		int THEATER_NO = aaa(SHOWING_NO, SHOWING_ROUND);
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, THEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				Theater theater = new Theater();
				theater.setTHEATER_NO(result.getInt(1));
				theater.setMOVIETHEATER_NO(result.getInt(2));
				theater.setTHEATER_NAME(result.getInt(3));
				theater.setTHEATER_ROW(result.getInt(4));
				theater.setTHEATER_COLUMN(result.getInt(5));
				return theater;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int aaa(int SHOWING_NO, int SHOWING_ROUND) {
		String sql = "SELECT THEATER_NO FROM SHOWING_DETAIL WHERE SHOWING_NO=? AND SHOWING_ROUND=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
			pstmt.setInt(2, SHOWING_ROUND);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public String getMovie(int SHOWING_NO) {
		String sql="SELECT MOVIE_TITLE FROM MOVIE WHERE MOVIE_NO in (SELECT MOVIE_NO FROM SHOWING WHERE SHOWING_NO=?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public String getMovietheater(int SHOWING_NO) {
		String sql="SELECT MOVIETHEATER_NAME FROM MOVIETHEATER WHERE MOVIETHEATER_NO in (SELECT MOVIETHEATER_NO FROM SHOWING WHERE SHOWING_NO=?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public Showing_Detail getShowingDetail(int SHOWING_NO, int SHOWING_ROUND) {
		String sql="SELECT * FROM SHOWING_DETAIL WHERE SHOWING_NO=? AND SHOWING_ROUND=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, SHOWING_NO);
			pstmt.setInt(2, SHOWING_ROUND);
			result = pstmt.executeQuery();
			if(result.next()) {
				Showing_Detail showing_detail = new Showing_Detail();
				showing_detail.setSHOWING_NO(result.getInt(1));
				showing_detail.setSHOWING_ROUND(result.getInt(2));
				showing_detail.setTHEATER_NO(result.getInt(3));
				showing_detail.setSHOWING_VISITOR(result.getInt(4));
				showing_detail.setSHOWING_TIME(result.getString(5));
				return showing_detail;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
