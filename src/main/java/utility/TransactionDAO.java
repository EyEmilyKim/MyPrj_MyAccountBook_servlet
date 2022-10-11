package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TransactionDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
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
