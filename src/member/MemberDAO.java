package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import movie.Movie;

public class MemberDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet result;
	
	public MemberDAO() {
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
	
	public int login(String MEMBER_ID,String MEMBER_PW) {
		String SQL = "SELECT MEMBER_PW FROM MEMBER WHERE MEMBER_ID=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,MEMBER_ID);
			result = pstmt.executeQuery();
			if(result.next()) {							
				if(result.getString(1).equals(MEMBER_PW)) {
					return 1; //�α��� ����
				} else {
					return 0; //�α��� ����
				}
				
			} return -1;  //���̵� ���� X
						
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(Member user) {
		int result = -1;
		String SQL = "INSERT INTO MEMBER VALUES(?,?,?,?,sysdate)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,user.getMEMBER_ID());
			pstmt.setString(2,user.getMEMBER_PW());
			pstmt.setString(3,user.getMEMBER_EMAIL());
			pstmt.setString(4,user.getMEMBER_BIRTH());
			result = pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
	
	public int doublecheck(String id) {
		String SQL = "SELECT * FROM MEMBER WHERE MEMBER_ID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,id);
			result = pstmt.executeQuery();
			if(result.next()) {
				return 0; //�ߺ�
			} else {
				return 1; //��� ����
			}
		} catch(Exception e) {
			e.printStackTrace();
		} return -1;
	}
	
	public int searchid(String email) {
		String SQL = "SELECT MEMBER_ID FROM MEMBER WHERE MEMBER_EMAIL=?";
		String id = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,email);
			result = pstmt.executeQuery();
			if(!result.next()) {
				return 0;
			}
			id = result.getString(1);
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		// mail server ����
		String host = "smtp.naver.com";
		String user = "dlxodus16@naver.com"; // �ڽ��� ���̹� ����
		String password = "!lee00824";// �ڽ��� ���̹� �н�����

		// SMTP ���� ������ �����Ѵ�.
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.debug", "true");


		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// email ����
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "TY Theater"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

			// ���� ����
			msg.setSubject("���̵� ã�� �����Դϴ�.");
			// ���� ����
			msg.setText("ã���÷��� ���̵�� "+ id +"�Դϴ�.");

			Transport.send(msg);
			System.out.println("�̸��� ����");

		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}

		return 1;
	}
	
	public int searchpw(String email,String id) {
		String SQL = "SELECT MEMBER_PW FROM MEMBER WHERE MEMBER_EMAIL=? AND MEMBER_ID=?";
		String pw = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,email);
			pstmt.setString(2,id);
			result = pstmt.executeQuery();
			if(!result.next()) {
				return 0;
			}
			pw = result.getString(1);
		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}
		// mail server ����
		String host = "smtp.naver.com";
		String user = "dlxodus16@naver.com"; // �ڽ��� ���̹� ����
		String password = "!lee00824";// �ڽ��� ���̹� �н�����

		// SMTP ���� ������ �����Ѵ�.
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.debug", "true");


		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});

		// email ����
		try {
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user, "TY Theater"));
			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

			// ���� ����
			msg.setSubject("��й�ȣ ã�� �����Դϴ�.");
			// ���� ����
			msg.setText("ã���÷��� ��й�ȣ�� "+ pw +"�Դϴ�.");

			Transport.send(msg);
			System.out.println("�̸��� ����");

		} catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}

		return 1;
	}
	
	public ArrayList<Member> getList(){
		String sql = "SELECT * FROM MEMBER order by MEMBER_CREATE desc";
		ArrayList<Member> list = new ArrayList<Member>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			result = pstmt.executeQuery();
			while(result.next()) {
				Member member = new Member();
				member.setMEMBER_ID(result.getString(1));
				member.setMEMBER_PW(result.getString(2));
				member.setMEMBER_EMAIL(result.getString(3));
				member.setMEMBER_BIRTH(result.getString(4));
				member.setMEMBER_CREATE(result.getString(5));
				list.add(member);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int Secession(String MEMBER_ID) {
		int result = -1;
		String sql = "DELETE FROM MEMBER WHERE MEMBER_ID = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MEMBER_ID);
			result = pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		return result;
	}
}
