package review;

public class Review {
	private int REVIEW_NO;
	private int MOVIE_NO;
	private String MEMBER_ID;
	private int REVIEW_GRADE;
	private String REVIEW_CONTENT;
	public int getREVIEW_NO() {
		return REVIEW_NO;
	}
	public void setREVIEW_NO(int rEVIEW_NO) {
		REVIEW_NO = rEVIEW_NO;
	}
	public int getMOVIE_NO() {
		return MOVIE_NO;
	}
	public void setMOVIE_NO(int mOVIE_NO) {
		MOVIE_NO = mOVIE_NO;
	}
	public String getMEMBER_ID() {
		return MEMBER_ID;
	}
	public void setMEMBER_ID(String mEMBER_ID) {
		MEMBER_ID = mEMBER_ID;
	}
	public int getREVIEW_GRADE() {
		return REVIEW_GRADE;
	}
	public void setREVIEW_GRADE(int rEVIEW_GRADE) {
		REVIEW_GRADE = rEVIEW_GRADE;
	}
	public String getREVIEW_CONTENT() {
		return REVIEW_CONTENT;
	}
	public void setREVIEW_CONTENT(String rEVIEW_CONTENT) {
		REVIEW_CONTENT = rEVIEW_CONTENT;
	}
	private float REVIEW_AVG;
	public float getREVIEW_AVG() {
		return REVIEW_AVG;
	}
	public void setREVIEW_AVG(float rEVIEW_AVG) {
		REVIEW_AVG = rEVIEW_AVG;
	}
}
