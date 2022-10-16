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

	//조건에 맞는 모든 '지출'내역 총 건수 검색 메서드
	public Integer getTotalOfSearchEXTrans(String fr, String to, String it, String cn, String mn ) {
		String select = "select count(*) "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, cate_code, item, amount, meth_name, meth_code, r_date "
				+ "from ( "
				+ "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, t.cate_code cate_code, cate_name, item, "
				+ "amount, t.meth_code meth_code, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "and t.inex = 'EX') "
				+ "where "
				+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
				+ "and item like ? and cate_name like ? and meth_name like ? ) " ;
		Integer total = 0;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, fr);
			pstmt.setString(2, to);
			pstmt.setString(3, it);
			pstmt.setString(4, cn);
			pstmt.setString(5, mn);
			rs = pstmt.executeQuery();
			if(rs.next()) total = rs.getInt(1);
			System.out.println("getTotalOfSearchEXTrans() total : "+total);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e){}
		}
		System.out.println("getTotalOfSearchEXTrans() end");
		return total;
	}
		
	//지정된 '건수'의 '지출'내역 '조건'검색 메서드
	public ArrayList<Transaction> searchCountedEXTrans(String fr, String to, String it, String cn, String mn, int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, item, "
				+ "amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "and t.inex = 'EX' "
				+ "order by t_date desc, t.seqno desc "
				+ ") "
				+ "where "
				+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
				+ "and item like ? and cate_name like ? and meth_name like ? "
				+ "order by rn "
				+ ") " 
				+ "where rn > ? and rn < ? ";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, fr);
			pstmt.setString(2, to);
			pstmt.setString(3, it);
			pstmt.setString(4, cn);
			pstmt.setString(5, mn);
			pstmt.setInt(6, start);
			pstmt.setInt(7, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Transaction t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
				t.setRownum(rs.getInt(9));
				list.add(t);
				System.out.println("searchCountedEXTrans() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//						System.out.println(rs.getString(2));
//						System.out.println(rs.getString(3));
				System.out.println("cate_name : "+rs.getString(4));
//						System.out.println(rs.getString(5));
//						System.out.println(rs.getInt(6));
				System.out.println("meth_name : "+rs.getString(7));
//						System.out.println(rs.getString(8));
				System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("searchCountedEXTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("searchCountedEXTrans() end");
		return list;
	}	
		
	//전체 '지출'내역 건수 검색 메서드 
	public Integer getTotalofEXTrans() {
		String select = "select count(*) from mab_transactions where inex = 'EX'";
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
		
	//지정된 건수의 '지출'내역 검색 메서드
	public ArrayList<Transaction> listCountedEXTrans(int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno seqno, t.inex inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, "
				+ "item, amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "and t.inex = 'EX' "
				+ "order by t_date desc, t.seqno desc "
				+ ") "
				+ "order by rn"
				+ ") "
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
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
				t.setRownum(rs.getInt(9));
				list.add(t);
//						System.out.println("listCountedEXTrans() rs true");
//						System.out.println("seqno : "+rs.getInt(1));
//						System.out.println(rs.getString(2));
//						System.out.println(rs.getString(3));
//						System.out.println(rs.getString(4));
//						System.out.println(rs.getString(5));
//						System.out.println(rs.getInt(6));
//						System.out.println(rs.getString(7));
//						System.out.println(rs.getString(8));
//						System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("listCountedEXTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listCountedEXTrans() end");
		return list;
	}		
	
	//조건에 맞는 모든 '수입'내역 총 건수 검색 메서드
	public Integer getTotalOfSearchINTrans(String from, String to, String it, String cn) {
		String select = "select count(*) "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, cate_code, item, amount, meth_name, meth_code, r_date "
				+ "from ( "
				+ "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, t.cate_code cate_code, cate_name, item, "
				+ "amount, t.meth_code meth_code, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "and t.inex = 'IN') "
				+ "where "
				+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
				+ "and item like ? and cate_name like ? ) ";
		
		Integer total = 0;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, from);
			pstmt.setString(2, to);
			pstmt.setString(3, it);
			pstmt.setString(4, cn);
			rs = pstmt.executeQuery();
			if(rs.next()) total = rs.getInt(1);
			System.out.println("getTotalOfSearchINTrans() total : "+total);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e){}
		}
		System.out.println("getTotalOfSearchINTrans() end");
		return total;
	}
	
	//지정된 '건수'의 '수입'내역 '조건'검색 메서드
	public ArrayList<Transaction> searchCountedINTrans(String fr, String to, String it, String cn, int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, item, "
				+ "amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "and t.inex = 'IN'"
				+ "order by t_date desc, t.seqno desc "
				+ ") "
				+ "where "
				+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
				+ "and item like ? and cate_name like ? "
				+ "order by rn "
				+ ") " 
				+ "where rn > ? and rn < ? " ;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, fr);
			pstmt.setString(2, to);
			pstmt.setString(3, it);
			pstmt.setString(4, cn);
			pstmt.setInt(5, start);
			pstmt.setInt(6, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Transaction t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
				t.setRownum(rs.getInt(9));
				list.add(t);
				System.out.println("searchCountedINTrans() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//					System.out.println(rs.getString(2));
//					System.out.println(rs.getString(3));
				System.out.println("cate_name : "+rs.getString(4));
//					System.out.println(rs.getString(5));
//					System.out.println(rs.getInt(6));
				System.out.println("meth_name : "+rs.getString(7));
//					System.out.println(rs.getString(8));
				System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("searchCountedINTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("searchCountedINTrans() end");
		return list;
	}	
	
	//전체 '수입'내역 건수 검색 메서드 
	public Integer getTotalofINTrans() {
		String select = "select count(*) from mab_transactions where inex = 'IN'";
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
	
	//지정된 건수의 '수입'내역 검색 메서드
	public ArrayList<Transaction> listCountedINTrans(int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno seqno, t.inex inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, "
				+ "item, amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "and t.inex = 'IN' "
				+ "order by t_date desc, t.seqno desc "
				+ ") "
				+ "order by rn "
				+ ") "
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
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
				t.setRownum(rs.getInt(9));
				list.add(t);
//					System.out.println("listCountedINTrans() rs true");
//					System.out.println("seqno : "+rs.getInt(1));
//					System.out.println(rs.getString(2));
//					System.out.println(rs.getString(3));
//					System.out.println(rs.getString(4));
//					System.out.println(rs.getString(5));
//					System.out.println(rs.getInt(6));
//					System.out.println(rs.getString(7));
//					System.out.println(rs.getString(8));
//					System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("listCountedINTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listCountedINTrans() end");
		return list;
	}	
	
	//거래내역 가장 최신 날짜 조회
		public String getNewestTransDate() {
			String t_from = "";
			String select = "select to_char(max(trans_date),'YYYY-MM-DD') from mab_transactions";
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url,"hr","hr");
				pstmt = con.prepareStatement(select);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					t_from = rs.getString(1);
					System.out.println("getNewestTransDate() t_to:"+rs.getString(1));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				try { rs.close(); pstmt.close(); con.close(); }
				catch(Exception e) {}
			}
			System.out.println("getNewestTransDate() end");
			return t_from;
		}
		
		//거래내역 가장 옛날 날짜 조회
	public String getOldestTransDate() {
		String t_from = "";
		String select = "select to_char(min(trans_date),'YYYY-MM-DD') from mab_transactions";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				t_from = rs.getString(1);
				System.out.println("getOldestTransDate() t_from:"+rs.getString(1));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("getOldestTransDate() end");
		return t_from;
	}
	
	//지정된 '건수'의 거래내역 '조건'검색 메서드
	public ArrayList<Transaction> searchCountedTrans(String fr, String to, String it, int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, item, "
				+ "amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "order by t_date desc, t.seqno desc "
				+ ") "
				+ "where "
				+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
				+ "and item like ? " 
				+ "order by rn ) "
				+ "where rn > ? and rn < ? " ;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, fr);
			pstmt.setString(2, to);
			pstmt.setString(3, it);
			pstmt.setInt(4, start);
			pstmt.setInt(5, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Transaction t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
				t.setRownum(rs.getInt(9));
				list.add(t);
				System.out.println("searchCountedTrans() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
				System.out.println("cate_name : "+rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getInt(6));
				System.out.println("meth_name : "+rs.getString(7));
//				System.out.println(rs.getString(8));
				System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("searchCountedTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("searchCountedTrans() end");
		return list;
	}
	
	//조건에 맞는 모든 거래내역 총 건수 검색 메서드
	public Integer getTotalOfSearchTrans(String from, String to, String item) {
		String select = "select count(*) "
			+ "from ( "
			+ "select rownum rn, seqno, inex, t_date, cate_code, item, amount, meth_code, r_date "
			+ "from ( "
			+ "select seqno, inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_code, item, "
			+ "amount, meth_code, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
			+ "from mab_transactions "
			+ "order by trans_date desc, seqno desc ) "
			+ "where "
			+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
			+ "and item like ? " 
			+ " ) " ;
		Integer total = 0;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, from);
			pstmt.setString(2, to);
			pstmt.setString(3, item);
			rs = pstmt.executeQuery();
			if(rs.next()) total = rs.getInt(1);
			System.out.println("getTotalOfSearchTrans() total : "+total);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e){}
		}
		System.out.println("getTotalOfSearchTrans() end");
		return total;
	}
	
	//조건에 맞는 모든 거래내역 검색 메서드
	public ArrayList<Transaction> searchAllTrans(String from, String to, String item){
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date, rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, item, "
				+ "amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "where "
				+ "t_date between to_date(?,'YYYY-MM-DD') and to_date(?,'YYYY-MM-DD') "
				+ "and item like ? " 
				+ " ) " ;
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, from);
			pstmt.setString(2, to);
			pstmt.setString(3, item);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Transaction t = new Transaction();
				t.setSeqno(rs.getInt(1));
				t.setInex(rs.getString(2));
				t.setTrans_date(rs.getString(3));
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
//				t.setRownum(rs.getInt(9));
				list.add(t);
				System.out.println("searchAllTrans() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
				System.out.println(rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getInt(6));
				System.out.println(rs.getString(7));
//				System.out.println(rs.getString(8));
//				System.out.println("rownum : "+rs.getInt(9));
			}
			System.out.println("searchAllTrans() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("searchAllTrans() end");
		return list;
	}
	
	//지정된 건수의 거래내역 검색 메서드
	public ArrayList<Transaction> listCountedTrans(int start, int end) {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select seqno, inex, t_date, cate_name, item, amount, meth_name, r_date , rn "
				+ "from ( "
				+ "select rownum rn, seqno, inex, t_date, cate_name, item, amount, meth_name, r_date "
				+ "from ( "
				+ "select t.seqno seqno, t.inex inex, to_char(trans_date, 'YYYY-MM-DD') t_date, t.cate_code cate_code, cate_name, "
				+ "item, amount, t.meth_code, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "order by t_date desc, t.seqno desc "
				+ ") "
				+ "order by rn"
				+ ") "
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
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
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
	public Integer getTotalofTrans() {
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
	public Transaction selectOneTransaction(Integer seqno) {
		Transaction t = null;
		String select = "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, t.cate_code, item, "
				+ "amount, t.meth_code, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date, cate_name, meth_name "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code and t.seqno = ?";
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
				t.setCate_name(rs.getString(9));
				t.setMeth_name(rs.getString(10));
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
	public ArrayList<Transaction> listAllTransaction() {
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		String select = "select t.seqno, t.inex, to_char(trans_date, 'YYYY-MM-DD') t_date, cate_name, "
				+ "item, amount, meth_name, to_char(reg_date, 'YYYY-MM-DD HH24:MI:SS') r_date "
				+ "from mab_transactions t , mab_categories c , mab_methods m "
				+ "where t.cate_code = c.cate_code "
				+ "and t.meth_code = m.meth_code "
				+ "order by t_date desc, seqno desc";
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
				t.setCate_name(rs.getString(4));
				t.setItem(rs.getString(5));
				t.setAmount(rs.getInt(6));
				t.setMeth_name(rs.getString(7));
				t.setReg_date(rs.getString(8));
				list.add(t);
//				System.out.println("listAllTransaction() rs true");
				System.out.println("seqno : "+rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
//				System.out.println(rs.getString(4));
//				System.out.println(rs.getString(5));
//				System.out.println(rs.getInt(6));
//				System.out.println(rs.getString(7));
				System.out.println("reg_date : "+rs.getString(8));
			}
			System.out.println("listAllTransaction() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listAllTransaction() end");
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
