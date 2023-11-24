package movietheater;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import movie.Movie;

public class MovieTheaterDAO {
	private Connection conn;
	private ResultSet result;
	
	public MovieTheaterDAO() {
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
		String sql = "SELECT MOVIETHEATER_NO FROM MOVIETHEATER ORDER BY 1 DESC";
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
	
	public int write(String MOVIETHEATER_NAME, String MOVIETHEATER_CITY, String MOVIETHEATER_ADDRESS) {
		String sql = "INSERT INTO MOVIETHEATER VALUES(?,?,?,?)";
		try {						
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,getNo());
			pstmt.setString(2, MOVIETHEATER_NAME);
			pstmt.setString(3, MOVIETHEATER_CITY);
			pstmt.setString(4, MOVIETHEATER_ADDRESS);
		
			return pstmt.executeUpdate();			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<MovieTheater> getList(String MOVIETHEATER_CITY){
		if(MOVIETHEATER_CITY != "null") {
			String sql = "SELECT * FROM MOVIETHEATER WHERE MOVIETHEATER_CITY = ? ORDER BY MOVIETHEATER_NAME";
			ArrayList<MovieTheater> list = new ArrayList<MovieTheater>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MOVIETHEATER_CITY);
				result = pstmt.executeQuery();
				while(result.next()) {
					MovieTheater movietheater = new MovieTheater();
					movietheater.setMOVIETHEATER_NO(result.getInt(1));
					movietheater.setMOVIETHEATER_NAME(result.getString(2));
					movietheater.setMOVIETHEATER_CITY(result.getString(3));
					movietheater.setMOVIETHEATER_ADDRESS(result.getString(4));
					list.add(movietheater);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
		} return null;
	}
	
	public ArrayList<MovieTheater> getList(){
			String sql = "SELECT * FROM MOVIETHEATER ORDER BY MOVIETHEATER_NAME";
			ArrayList<MovieTheater> list = new ArrayList<MovieTheater>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				result = pstmt.executeQuery();
				while(result.next()) {
					MovieTheater movietheater = new MovieTheater();
					movietheater.setMOVIETHEATER_NO(result.getInt(1));
					movietheater.setMOVIETHEATER_NAME(result.getString(2));
					movietheater.setMOVIETHEATER_CITY(result.getString(3));
					movietheater.setMOVIETHEATER_ADDRESS(result.getString(4));
					list.add(movietheater);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return list;
	}
	
	public MovieTheater getmovietheater(int MOVIETHEATER_NO) {
		String sql = "SELECT * FROM MOVIETHEATER WHERE MOVIETHEATER_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				MovieTheater movietheater = new MovieTheater();
				movietheater.setMOVIETHEATER_NO(result.getInt(1));
				movietheater.setMOVIETHEATER_NAME(result.getString(2));
				movietheater.setMOVIETHEATER_CITY(result.getString(3));
				movietheater.setMOVIETHEATER_ADDRESS(result.getString(4));
				
				return movietheater;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}  return null;
	}
	
	public int update(int MOVIETHEATER_NO, String MOVIETHEATER_NAME, String MOVIETHEATER_CITY, String MOVIETHEATER_ADDRESS) {
			String sql = "UPDATE MOVIETHEATER SET MOVIETHEATER_NAME=?,MOVIETHEATER_CITY=?,MOVIETHEATER_ADDRESS=? WHERE MOVIETHEATER_NO = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MOVIETHEATER_NAME);
				pstmt.setString(2, MOVIETHEATER_CITY);
				pstmt.setString(3, MOVIETHEATER_ADDRESS);
				pstmt.setInt(4, MOVIETHEATER_NO);
			
				return pstmt.executeUpdate();
			} catch(Exception e) {
			e.printStackTrace();
		}
			return -1;
	}
	
	public int delete(int MOVIETHEATER_NO) {
		String sql = "DELETE FROM MOVIETHEATER WHERE MOVIETHEATER_NO=?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} return -1;
	}
	
	public String[] getName(String MOVIETHEATER_CITY){
		if(MOVIETHEATER_CITY != "null") {
			int size = getSize(MOVIETHEATER_CITY);
			if(size != 0) {
			String sql = "SELECT * FROM MOVIETHEATER WHERE MOVIETHEATER_CITY = ? ORDER BY MOVIETHEATER_NAME";
			String[] array = new String[size];
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MOVIETHEATER_CITY);
				result = pstmt.executeQuery();
				for(int i=0;result.next();i++) {
					array[i] = result.getString(2);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
				return array;
			}
		} return null;
	}
	
	public int getSize(String MOVIETHEATER_CITY) {
		String sql = "SELECT COUNT(*) FROM MOVIETHEATER WHERE MOVIETHEATER_CITY = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,MOVIETHEATER_CITY);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		} return 0;
	}
	
	public String[] getName_Condition(String MOVIETHEATER_CITY){
		if(MOVIETHEATER_CITY != "null") {
			int size = getSize_Condition(MOVIETHEATER_CITY);
			if(size != 0) {
			String sql = "SELECT * FROM MOVIETHEATER WHERE MOVIETHEATER_CITY = ? AND MOVIETHEATER_NO IN (SELECT MOVIETHEATER_NO FROM THEATER) ORDER BY MOVIETHEATER_NAME";
			String[] array = new String[size];
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MOVIETHEATER_CITY);
				result = pstmt.executeQuery();
				for(int i=0;result.next();i++) {
					array[i] = result.getString(2);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
				return array;
			}
		} return null;
	}
	
	public int getSize_Condition(String MOVIETHEATER_CITY) {
		String sql = "SELECT COUNT(*) FROM MOVIETHEATER WHERE MOVIETHEATER_CITY = ? AND MOVIETHEATER_NO IN (SELECT MOVIETHEATER_NO FROM THEATER)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,MOVIETHEATER_CITY);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		} return 0;
	}
	
	public int[] getTheater(String MOVIETHEATER_CITY){
		if(MOVIETHEATER_CITY != "null") {
			int size = getSize_Condition(MOVIETHEATER_CITY);
			if(size != 0) {
			String sql = "select a.movietheater_no, b.movietheater_name, count(*)\r\n" + 
					"from theater a, movietheater b\r\n" + 
					"where a.movietheater_no = b.movietheater_no and b.movietheater_city=?\r\n" + 
					"group by a.movietheater_no, b.movietheater_name\r\n" + 
					"order by 2";
			int[] array = new int[size];
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MOVIETHEATER_CITY);
				result = pstmt.executeQuery();
				for(int i=0;result.next();i++) {
					array[i] = result.getInt(3);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
				return array;
			}
		} return null;
	}
}
