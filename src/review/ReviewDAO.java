package review;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import movie.Movie;

public class ReviewDAO {
	private Connection conn;
	private ResultSet result;
	
	public ReviewDAO() {
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
		String sql = "SELECT REVIEW_NO FROM REVIEW ORDER BY 1 DESC";
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
	
	public int write(int MOVIE_NO, String MEMBER_ID, int REVIEW_GRADE, String REVIEW_CONTENT) {
		String sql = "INSERT INTO REVIEW VALUES(?,?,?,?,?)";
		try {
		
		PreparedStatement pstmt = conn.prepareStatement(sql);		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,getNo());
		pstmt.setInt(2, MOVIE_NO);
		pstmt.setString(3, MEMBER_ID);
		pstmt.setInt(4, REVIEW_GRADE);
		pstmt.setString(5, REVIEW_CONTENT);
		
		return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Review> getList(int MOVIE_NO){
		String sql = "SELECT * FROM REVIEW WHERE MOVIE_NO=? order by REVIEW_NO";
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,MOVIE_NO);
			result = pstmt.executeQuery();
			while(result.next()) {
				Review review = new Review();
				review.setREVIEW_NO(result.getInt(1));
				review.setMOVIE_NO(result.getInt(2));
				review.setMEMBER_ID(result.getString(3));
				review.setREVIEW_GRADE(result.getInt(4));
				review.setREVIEW_CONTENT(result.getString(5));
				list.add(review);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public Review getreview(int REVIEW_NO) {
		String sql = "SELECT * FROM REVIEW WHERE REVIEW_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, REVIEW_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				Review review = new Review();
				review.setREVIEW_NO(result.getInt(1));
				review.setMOVIE_NO(result.getInt(2));
				review.setMEMBER_ID(result.getString(3));
				review.setREVIEW_GRADE(result.getInt(4));
				review.setREVIEW_CONTENT(result.getString(5));

				return review;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}  return null;
	}
	
	public int update(int REVIEW_NO, int REVIEW_GRADE, String REVIEW_CONTENT) {
			String sql = "UPDATE REVIEW SET REVIEW_GRADE=?, REVIEW_CONTENT=? WHERE REVIEW_NO=?";
			try {	
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, REVIEW_GRADE);
				pstmt.setString(2, REVIEW_CONTENT);
				pstmt.setInt(3, REVIEW_NO);
			
				return pstmt.executeUpdate();
			} catch(Exception e) {
			e.printStackTrace();
		}
			return -1;
	}
	
	public int delete(int REVIEW_NO) {
		String sql = "DELETE FROM REVIEW WHERE REVIEW_NO=?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, REVIEW_NO);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} return -1;
	}
	
	public Review getAvg(int MOVIE_NO) {
		String sql = "SELECT AVG(REVIEW_GRADE) FROM REVIEW WHERE MOVIE_NO=?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, MOVIE_NO);
			result = pstmt.executeQuery();
			if(result.next()) {
				Review review = new Review();
				review.setREVIEW_AVG(result.getFloat(1));

				return review;
				}
			} catch(Exception e) {
				e.printStackTrace();
		} return null;
	}
}
