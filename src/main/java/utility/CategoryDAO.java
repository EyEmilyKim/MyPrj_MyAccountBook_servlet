package utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.Category;

public class CategoryDAO{
	private String driver = "oracle.jdbc.OracleDriver";
	private String url = "jdbc:oracle:thin:@//localhost:1521/xe";
	private Connection con = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	//cate_code로 카테고리 삭제 메서드
	public boolean deleteCategory(String cate_code) {
		boolean flag = false;
		String delete = "delete mab_categories where cate_code = ?";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(delete);
			pstmt.setString(1, cate_code);
			pstmt.executeUpdate();
			con.commit();
			flag = true;
			System.out.println("deleteCategory() delete done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("deleteCategory() end");
		return flag;
	}
	
	//cate_code로 카테고리 수정 메서드
	public boolean updateCategory(Category c) {
		boolean flag = false;
		String update = "update mab_categories set cate_name = ? where cate_code = ? ";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(update);
			pstmt.setString(1, c.getCate_name());
			pstmt.setString(2, c.getCate_code());
			pstmt.executeUpdate();
			con.commit();
			flag = true;
			System.out.println("updateCategory() update done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try { pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("updateCategory() end");
		return flag;
	}
	
	//cate_code로 카테고리 검색 메서드
	public Category getCategory(String cate_code) {
		Category c = null;
		String select = "select seqno, inex, cate_name, cate_code from mab_categories where cate_code = ?";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			pstmt.setString(1, cate_code);
			rs = pstmt.executeQuery();
			System.out.println("getCategory() select done");
			if(rs.next()) {
				c = new Category();
				c.setSeqno(rs.getInt(1));
				c.setInex(rs.getString(2));
				c.setCate_name(rs.getString(3));
				c.setCate_code(rs.getString(4));
				System.out.println(rs.getInt(1));
				System.out.println(rs.getString(2));
				System.out.println(rs.getString(3));
				System.out.println(rs.getString(4));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try { rs.close(); pstmt.close(); con.close(); }
			catch(Exception e) {}
		}
		System.out.println("getCategory() end");
		return c;
	}
	
	//전체 카테고리 검색 메서드
	public ArrayList<Category> listCategory() {
		ArrayList<Category> list = new ArrayList<Category>();
		String select = "select seqno, inex, cate_name, cate_code from mab_categories";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(select);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Category c = new Category();
				c.setSeqno(rs.getInt(1));
				c.setInex(rs.getString(2));
				c.setCate_name(rs.getString(3));
				c.setCate_code(rs.getString(4));
				list.add(c);
//				System.out.println("listCategory() rs true");
//				System.out.println(rs.getInt(1));
//				System.out.println(rs.getString(2));
//				System.out.println(rs.getString(3));
//				System.out.println(rs.getString(4));
			}
			System.out.println("listCategory() select done");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close(); pstmt.close(); con.close();
			} catch (Exception e2) {			}
		}
		System.out.println("listCategory() end");
		return list;
	}
	
	//카테고리 삽입 메서드
	public boolean insertCategory(Category c) {
		boolean flag = false;
		String insert = "insert into mab_categories values(?, ?, ?, ?)";
		try {
			Class.forName(driver);
			con = DriverManager.getConnection(url,"hr","hr");
			pstmt = con.prepareStatement(insert);
			pstmt.setInt(1, c.getSeqno());
			pstmt.setString(2, c.getInex());
			pstmt.setString(3, c.getCate_name());
			pstmt.setString(4, c.getCate_code());
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
	
	//Categories 테이블의 최신 일련번호 검색
	public int getCateSeqno() {
		String select = "select max(seqno) from mab_categories";
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
