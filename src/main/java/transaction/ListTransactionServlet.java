package transaction;

import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Transaction;
import utility.TransactionDAO;

/**
 * Servlet implementation class ListTransactionServlet
 */
@WebServlet("/listTransaction.do")
public class ListTransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListTransactionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("listTransaction.do 호출됨.");
		//slc 파라미터(N줄 보기) 수신
		int slc = 5;
		String slcParam = (String)request.getParameter("SLC");
		if(slcParam != null) slc = Integer.parseInt(slcParam);
		//검색 조건 파라미터 수신
				String d_from = (String)request.getParameter("D_FROM");
				String d_to = (String)request.getParameter("D_TO");
				String item = (String)request.getParameter("ITEM");
				String[] srch_v = {d_from, d_to, item};
				request.setAttribute("SRCH_V", srch_v);
		//page 파라미터 수신
		int pageNo = 1;
		String pageParam = (String)request.getParameter("PG");
		if(pageParam != null) pageNo = Integer.parseInt(pageParam);
		//조회할 거래내역 덩어리 계산
		int start = (pageNo -1)* slc;
		int end = ( (pageNo -1)* slc ) + (slc +1);
		System.out.println("listTrans.do > start : "+start+" / end : "+end);
		TransactionDAO dao = new TransactionDAO();
		ArrayList<Transaction> list = new ArrayList<Transaction>();
		int totalCount = 0;
		boolean search = false;
		System.out.println("여기1");
		
		if(d_from == null && d_to == null && item == null) { //검색 조건 없을 때 : 
			list = dao.listCountedTrans(start, end);
			totalCount = dao.getTotalofTrans();
		}else if(d_from != null || d_to != null || item == null) { //검색 조건 있을 때 : 
//			//거래내역 가장 옛날 & 최신 날짜 검색
//			String t_from = dao.getOldestTransDate();
//			String t_to = dao.getNewestTransDate();
			//거래내역 테이블에서 N건의 최근 조건부합 내역 검색
			list = dao.searchCountedTrans(d_from, d_to, "%"+item+"%", start, end);
			totalCount = dao.getTotalOfSearchTrans(d_from, d_to, "%"+item+"%");
			search = true;
		}
		request.setAttribute("LIST", list);
		System.out.println("여기3");
		//필요한 페이지 수 계산
		int pageCount = totalCount / slc;
		if(totalCount % slc != 0) pageCount++;
		request.setAttribute("PAGES", pageCount);	
		request.setAttribute("TOTAL", totalCount);
		//각 페이지 표시글 번호
		int startRn = (pageNo -1)*slc + 1; //현 페이지의 첫 표시건 rn
		int endRn = pageNo * slc; //현 페이지의 마지막 표시건 rn
		if(totalCount == 0 ) startRn = 0; 
		if(endRn > totalCount) endRn = totalCount;
		request.setAttribute("STARTRN", startRn);
		request.setAttribute("ENDRN", endRn);
		//jsp로 데이터 전달
		RequestDispatcher rd = request.getRequestDispatcher("listTransaction.jsp?SLC="+slc+"&SRCH="+search);
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
