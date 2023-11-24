package member;

public class Member {
	private String MEMBER_ID;
	private String MEMBER_PW;
	private String MEMBER_EMAIL;
	private String MEMBER_BIRTH;
	private String MEMBER_CREATE;
	
	public String getMEMBER_CREATE() {
		return MEMBER_CREATE;
	}

	public void setMEMBER_CREATE(String mEMBER_CREATE) {
		MEMBER_CREATE = mEMBER_CREATE;
	}

	public Member(String id, String pw, String email, String birth) {
		this.MEMBER_ID = id;
		this.MEMBER_PW = pw;
		this.MEMBER_EMAIL = email;
		this.MEMBER_BIRTH = birth;
	}
	
	public Member() {
		
	}
	
	public String getMEMBER_ID() {
		return MEMBER_ID;
	}
	public void setMEMBER_ID(String mEMBER_ID) {
		MEMBER_ID = mEMBER_ID;
	}
	public String getMEMBER_PW() {
		return MEMBER_PW;
	}
	public void setMEMBER_PW(String mEMBER_PW) {
		MEMBER_PW = mEMBER_PW;
	}
	public String getMEMBER_EMAIL() {
		return MEMBER_EMAIL;
	}
	public void setMEMBER_EMAIL(String mEMBER_EMAIL) {
		MEMBER_EMAIL = mEMBER_EMAIL;
	}
	public String getMEMBER_BIRTH() {
		return MEMBER_BIRTH;
	}
	public void setMEMBER_BIRTH(String mEMBER_BIRTH) {
		MEMBER_BIRTH = mEMBER_BIRTH;
	}
}
