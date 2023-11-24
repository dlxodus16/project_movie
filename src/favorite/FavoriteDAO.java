package favorite;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import movie.Movie;

public class FavoriteDAO {
	private Connection conn;
	private ResultSet result;
	
	public FavoriteDAO() {
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
	
	public int favoritecheck(String MEMBER_ID, int MOVIE_NO) {
		String sql = "SELECT * FROM FAVORITE WHERE MEMBER_ID = ? AND MOVIE_NO = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setNString(1, MEMBER_ID);
			pstmt.setInt(2, MOVIE_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				return 1;
			}else {
				return 0;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int add(String MEMBER_ID, int MOVIE_NO) {
		String sql = "INSERT INTO FAVORITE VALUES(?,?)";
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,MEMBER_ID);
			pstmt.setInt(2, MOVIE_NO);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(String MEMBER_ID, int MOVIE_NO) {
		String sql = "DELETE FROM FAVORITE WHERE MEMBER_ID=? AND MOVIE_NO=?";
		try {			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,MEMBER_ID);
			pstmt.setInt(2, MOVIE_NO);		
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Favorite> getList(String MEMBER_ID){
		String sql = "SELECT MOVIE_NO FROM FAVORITE WHERE MEMBER_ID=?";
		ArrayList<Favorite> list = new ArrayList<Favorite>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MEMBER_ID);
			result = pstmt.executeQuery();
			while(result.next()) {
				Favorite favorite = new Favorite();
				favorite.setMOVIE_NO(result.getInt(1));
				list.add(favorite);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
