package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import model.Transaction;

public class TransactionDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//거래 삽입 메서드
	public boolean insertTransaction(Transaction t) {
		boolean flag = false;
		String insert = "insert into mab_transactions values(?,?,"
				+ "to_date(?,'YYYY-MM-DD'),?,?,?,?)";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(insert);
			pstmt.setInt(1, t.getSeqno());
			pstmt.setString(2, t.getInex());
			pstmt.setString(3, t.getTrans_date());
			pstmt.setString(4, t.getCate_code());
			pstmt.setString(5, t.getItem());
			pstmt.setInt(6, t.getAmount());
			pstmt.setString(7, t.getMeth_code());
			System.out.println("1 Seqno : "+t.getSeqno());
			System.out.println("2 Inex : "+t.getInex());
			System.out.println("3 Trans_date : "+t.getTrans_date());
			System.out.println("4 getCate_code : "+t.getCate_code());
			System.out.println("5 getItem : "+t.getItem());
			System.out.println("6 getAmount : "+t.getAmount());
			System.out.println("7 Meth_code : "+t.getMeth_code());
			pstmt.executeUpdate();
			con.commit();
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		return flag;
	}
	
	//Transactions 테이블의 최신 일련번호 검색
	public Integer getTransSeqno() {
		String select = "select max(seqno) from mab_transactions";
		int max = 0;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				max = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		return max;
	}
}
