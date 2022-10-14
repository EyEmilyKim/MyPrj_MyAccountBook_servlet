package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Transaction;

public class TransactionDAO {
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//지정된 건수의 거래내역 검색 메서드
	public ArrayList<Transaction> listCountedTrans(int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_code, item, amount, meth_code, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_code, item, amount, meth_code, r_date "
				+ "from ( "
				+ "select seqno, inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_code, item, "
				+ "amount, meth_code, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions "
				+ "order by trans_date desc, seqno desc ) ) "
				+ "where rn > ? and rn < ? ";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Transaction t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_code(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_code(rs.getString(7));
				t.setReg_date(rs.getString(8));
				t.setRownum(rs.getInt(9));
				list.add(t);
//				System.out.println("listCountedTrans() rs true");
//				System.out.println("seqno : "+rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
//				System.out.println(rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getInt(6));
//				System.out.println(rs.getString(7));
//				System.out.println(rs.getString(8));
//				System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("listCountedTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listCountedTrans() end");
		return list;
	}
	
	//전체 거래내역 건수 검색 메서드 
	public Integer getTotalTransCount() {
		String select = "select count(*) from mab_transactions";
		Integer total = 0;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			if(rs.next()) total = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e){}
		}
		return total;
	}
	
	//seqno로 거래내역 수정 메서드
	public boolean updateTransaction(Transaction t) {
		boolean flag = false;
		String update = "update mab_transactions set inex=?, trans_date=to_date(?, 'YYYY-MM-DD'), "
				+ "cate_code=?, item=?, amount=?, meth_code=?, reg_date=sysdate where seqno = ?";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(update);
			pstmt.setString(1, t.getInex());
			pstmt.setString(2, t.getTrans_date());
			pstmt.setString(3, t.getCate_code());
			pstmt.setString(4, t.getItem());
			pstmt.setInt(5, t.getAmount());
			pstmt.setString(6, t.getMeth_code());
			pstmt.setInt(7, t.getSeqno());
			pstmt.executeUpdate();
			con.commit();
			flag = true;
			System.out.println("updateTransaction() update done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("updateTransaction() end");
		return flag;
	}
		
	//seqno로 거래내역 삭제 메서드
	public boolean deleteTransaction(Integer seqno) {
		boolean flag = false;
		String delete = "delete mab_transactions where seqno = ?";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(delete);
			pstmt.setInt(1, seqno);
			pstmt.executeUpdate();
			con.commit();
			flag = true;
			System.out.println("deleteTransaction() delete done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("deleteTransaction() end");
		return flag;
	}
	
	//seqno로 가계부내역 검색 메서드
	public Transaction getTransaction(Integer seqno) {
		Transaction t = null;
		String select = "select seqno, inex, to_char(trans_date, 'YYYY-MM-DD'), "
				+ "cate_code, item, amount, meth_code, "
				+ "to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS')  "
				+ "from mab_transactions where seqno = ?";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setInt(1, seqno);
			rs = pstmt.executeQuery();
			System.out.println("getTransaction() select done");
			System.out.println("seqno :"+seqno);
			if(rs.next()) {
				t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_code(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_code(rs.getString(7));
				t.setReg_date(rs.getString(8));
				System.out.println("getTransaction() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
//				System.out.println(rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getInt(6));
//				System.out.println(rs.getString(7));
				System.out.println("reg_date : "+rs.getString(8));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("getTransaction() end");
		return t;
	}	
	
	//전체 가계부내역 검색 메서드
	public ArrayList<Transaction> listTransaction() {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, to_char(trans_date, 'YYYY-MM-DD'), "
				+ "cate_code, item, amount, meth_code, "
				+ "to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS')  "
				+ "from mab_transactions order by trans_date desc, reg_date desc";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Transaction t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_code(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_code(rs.getString(7));
				t.setReg_date(rs.getString(8));
				list.add(t);
				System.out.println("listTransaction() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
//				System.out.println(rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getInt(6));
//				System.out.println(rs.getString(7));
				System.out.println("reg_date : "+rs.getString(8));
			}
			System.out.println("listTransaction() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listTransaction() end");
		return list;
	}
	
	//거래 삽입 메서드
	public boolean insertTransaction(Transaction t) {
		boolean flag = false;
		String insert = "insert into mab_transactions values(?,?,"
				+ "to_date(?,'YYYY-MM-DD'),?,?,?,?,sysdate)";
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
			System.out.println("insertTransaction() insert done");
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("insertTransaction() end");
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
				System.out.println("getTransSeqno() max:"+rs.getInt(1));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("getTransSeqno() end");
		return max;
	}
}
