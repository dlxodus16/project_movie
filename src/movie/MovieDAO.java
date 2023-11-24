package movie;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class MovieDAO {
	private Connection conn;
	private ResultSet result;
	
	public MovieDAO() {
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
		String sql = "SELECT MOVIE_NO FROM MOVIE ORDER BY 1 DESC";
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
	
	public int write(String MOVIE_TITLE, String MOVIE_DIRECTOR, String MOVIE_ACTOR, String MOVIE_TYPE, String MOVIE_OPEN, String MOVIE_CLOSE,
						int MOVIE_AGE, int MOVIE_TIME, String MOVIE_IMAGE, String MOVIE_CONTENT) {
		String sql = "SELECT * FROM MOVIE WHERE MOVIE_IMAGE = ?";
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,MOVIE_IMAGE);
			result = pstmt.executeQuery();
			if(!result.next()) {
			sql = "INSERT INTO MOVIE VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,getNo());
			pstmt.setString(2, MOVIE_TITLE);
			pstmt.setString(3, MOVIE_DIRECTOR);
			pstmt.setString(4, MOVIE_ACTOR);
			pstmt.setString(5, MOVIE_TYPE);
			pstmt.setString(6, MOVIE_OPEN);
			pstmt.setString(7, MOVIE_CLOSE);
			pstmt.setInt(8, MOVIE_AGE);
			pstmt.setInt(9, MOVIE_TIME);
			pstmt.setString(10, MOVIE_IMAGE);
			pstmt.setInt(11, 0);
			pstmt.setString(12, MOVIE_CONTENT);
			
			return pstmt.executeUpdate();
			} else{
				return 0;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Movie> getList(){
		String sql = "SELECT * FROM MOVIE order by MOVIE_VISITOR desc";
		ArrayList<Movie> list = new ArrayList<Movie>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			result = pstmt.executeQuery();
			while(result.next()) {
				Movie movie = new Movie();
				movie.setMOVIE_NO(result.getInt(1));
				movie.setMOVIE_TITLE(result.getString(2));
				movie.setMOVIE_DIRECTOR(result.getString(3));
				movie.setMOVIE_ACTOR(result.getString(4));
				movie.setMOVIE_TYPE(result.getString(5));
				movie.setMOVIE_OPEN(result.getString(6));
				movie.setMOVIE_CLOSE(result.getString(7));
				movie.setMOVIE_AGE(result.getInt(8));
				movie.setMOVIE_TIME(result.getInt(9));
				movie.setMOVIE_IMAGE(result.getString(10));
				movie.setMOVIE_VISITOR(result.getInt(11));
				movie.setMOVIE_CONTENT(result.getString(12));
				list.add(movie);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Movie getmovie(int MOVIE_NO) {
		String sql = "SELECT * FROM MOVIE WHERE MOVIE_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				Movie movie = new Movie();
				movie.setMOVIE_NO(result.getInt(1));
				movie.setMOVIE_TITLE(result.getString(2));
				movie.setMOVIE_DIRECTOR(result.getString(3));
				movie.setMOVIE_ACTOR(result.getString(4));
				movie.setMOVIE_TYPE(result.getString(5));
				movie.setMOVIE_OPEN(result.getString(6));
				movie.setMOVIE_CLOSE(result.getString(7));
				movie.setMOVIE_AGE(result.getInt(8));
				movie.setMOVIE_TIME(result.getInt(9));
				movie.setMOVIE_IMAGE(result.getString(10));
				movie.setMOVIE_VISITOR(result.getInt(11));
				movie.setMOVIE_CONTENT(result.getString(12));
				
				return movie;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}  return null;
	}
	
	public int update(int MOVIE_NO, String MOVIE_TITLE, String MOVIE_DIRECTOR, String MOVIE_ACTOR, String MOVIE_TYPE, String MOVIE_OPEN, String MOVIE_CLOSE,
			int MOVIE_AGE, int MOVIE_TIME, String MOVIE_IMAGE, String MOVIE_CONTENT) {
			String sql = "UPDATE MOVIE SET MOVIE_TITLE=?,MOVIE_DIRECTOR=?,MOVIE_ACTOR=?,MOVIE_TYPE=?,MOVIE_OPEN=?,MOVIE_CLOSE=?,MOVIE_AGE=?,MOVIE_TIME=?,MOVIE_IMAGE=?,MOVIE_CONTENT=? WHERE MOVIE_NO = ?";
			try {
			
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, MOVIE_TITLE);
				pstmt.setString(2, MOVIE_DIRECTOR);
				pstmt.setString(3, MOVIE_ACTOR);
				pstmt.setString(4, MOVIE_TYPE);
				pstmt.setString(5, MOVIE_OPEN);
				pstmt.setString(6, MOVIE_CLOSE);
				pstmt.setInt(7, MOVIE_AGE);
				pstmt.setInt(8, MOVIE_TIME);
				pstmt.setString(9, MOVIE_IMAGE);
				pstmt.setString(10, MOVIE_CONTENT);
				pstmt.setInt(11, MOVIE_NO);
			
				return pstmt.executeUpdate();
			} catch(Exception e) {
			e.printStackTrace();
		}
			return -1;
	}
	
	public int delete(int MOVIE_NO) {
		String sql = "DELETE FROM MOVIE WHERE MOVIE_NO=?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} return -1;
	}
	
	public ArrayList<Movie> getShowingList(){
		String sql = "select * from movie where sysdate<=movie_close and sysdate>=movie_open";
		ArrayList<Movie> list = new ArrayList<Movie>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			result = pstmt.executeQuery();
			while(result.next()) {
				Movie movie = new Movie();
				movie.setMOVIE_NO(result.getInt(1));
				movie.setMOVIE_TITLE(result.getString(2));
				movie.setMOVIE_DIRECTOR(result.getString(3));
				movie.setMOVIE_ACTOR(result.getString(4));
				movie.setMOVIE_TYPE(result.getString(5));
				movie.setMOVIE_OPEN(result.getString(6));
				movie.setMOVIE_CLOSE(result.getString(7));
				movie.setMOVIE_AGE(result.getInt(8));
				movie.setMOVIE_TIME(result.getInt(9));
				movie.setMOVIE_IMAGE(result.getString(10));
				movie.setMOVIE_VISITOR(result.getInt(11));
				movie.setMOVIE_CONTENT(result.getString(12));
				list.add(movie);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<Movie> getShowingList(int MOVIETHEATER_NO){
		String sql = "SELECT * FROM MOVIE WHERE MOVIE_NO IN (SELECT DISTINCT MOVIE_NO FROM SHOWING WHERE MOVIETHEATER_NO=? AND SYSDATE-1<SHOWING_DATE)";
		ArrayList<Movie> list = new ArrayList<Movie>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIETHEATER_NO);
			result = pstmt.executeQuery();
			while(result.next()) {
				Movie movie = new Movie();
				movie.setMOVIE_NO(result.getInt(1));
				movie.setMOVIE_TITLE(result.getString(2));
				movie.setMOVIE_DIRECTOR(result.getString(3));
				movie.setMOVIE_ACTOR(result.getString(4));
				movie.setMOVIE_TYPE(result.getString(5));
				movie.setMOVIE_OPEN(result.getString(6));
				movie.setMOVIE_CLOSE(result.getString(7));
				movie.setMOVIE_AGE(result.getInt(8));
				movie.setMOVIE_TIME(result.getInt(9));
				movie.setMOVIE_IMAGE(result.getString(10));
				movie.setMOVIE_VISITOR(result.getInt(11));
				movie.setMOVIE_CONTENT(result.getString(12));
				list.add(movie);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
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
			return "";
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	public int getMoney(int MOVIE_NO) {
		String sql="SELECT SUM(RESERVATION_MONEY) FROM RESERVATION WHERE RESERVATION_NO IN (SELECT RESERVATION_NO FROM RESERVATION WHERE SHOWING_NO IN (SELECT SHOWING_NO FROM SHOWING WHERE MOVIE_NO=?))";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return result.getInt(1);
			}
			return 0;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
	
	public ArrayList<Movie> search(String search){
		String sql = "SELECT * FROM MOVIE WHERE MOVIE_TITLE LIKE ? order by MOVIE_VISITOR desc";
		ArrayList<Movie> list = new ArrayList<Movie>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			result = pstmt.executeQuery();
			while(result.next()) {
				Movie movie = new Movie();
				movie.setMOVIE_NO(result.getInt(1));
				movie.setMOVIE_TITLE(result.getString(2));
				movie.setMOVIE_DIRECTOR(result.getString(3));
				movie.setMOVIE_ACTOR(result.getString(4));
				movie.setMOVIE_TYPE(result.getString(5));
				movie.setMOVIE_OPEN(result.getString(6));
				movie.setMOVIE_CLOSE(result.getString(7));
				movie.setMOVIE_AGE(result.getInt(8));
				movie.setMOVIE_TIME(result.getInt(9));
				movie.setMOVIE_IMAGE(result.getString(10));
				movie.setMOVIE_VISITOR(result.getInt(11));
				movie.setMOVIE_CONTENT(result.getString(12));
				list.add(movie);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
