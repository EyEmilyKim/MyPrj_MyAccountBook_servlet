package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Category;
import model.Method;

public class MethodDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//메서드 삽입 메서드
	public boolean insertMethod(Method m) {
		boolean flag = false;
		String insert = "insert into mab_methods values(?, ?, ?, ?)";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(insert);
			pstmt.setInt(1, m.getSeqno());
			pstmt.setString(2, m.getMncrd());
			pstmt.setString(3, m.getMeth_name());
			pstmt.setString(4, m.getMeth_code());
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
		
	//Methods 테이블의 최신 일련번호 검색
		public int getMethSeqno() {
			String select = "select max(seqno) from mab_methods";
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
		
	//전체 결제수단 검색 메서드
	public ArrayList<Method> listMethod() {
		ArrayList<Method> list = new ArrayList<Method>();
		String select = "select seqno, mncrd, meth_name, meth_code from mab_methods";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Method m = new Method();
				m.setSeqno(rs.getInt(1));
				m.setMncrd(rs.getString(2));
				m.setMeth_name(rs.getString(3));
				m.setMeth_code(rs.getString(4));
				list.add(m);
				System.out.println("listMethod() rs true");
				System.out.println(rs.getInt(1));
				System.out.println(rs.getString(2));
				System.out.println(rs.getString(3));
				System.out.println(rs.getString(4));
			}
			System.out.println("listMethod() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listMethod() end");
		return list;
	}
}
