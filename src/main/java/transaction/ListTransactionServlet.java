package transaction;

import java.io.IOException;
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
		//slc 파라미터(N줄 보기) 수신
		int slc = 5;
		String slcParam = (String)request.getParameter("SLC");
		if(slcParam != null) slc = Integer.parseInt(slcParam);
		//page 파라미터 수신
		int pageNo = 1;
		String pageParam = (String)request.getParameter("PAGE");
		if(pageParam != null) pageNo = Integer.parseInt(pageParam);
		//조회할 거래내역 덩어리 계산
		int start = (pageNo -1)* slc;
		int end = ( (pageNo -1)* slc ) + (slc +1);
		System.out.println("listTrans.do"+"\n start : "+start+"\n end : "+end);
		//거래내역 테이블에서 N건의 최근 내역 검색
		TransactionDAO dao = new TransactionDAO();
		ArrayList<Transaction> list = dao.listCountedTrans(start, end);
		request.setAttribute("LIST", list);
		//전체 거래내역 건수와 필요한 페이지 수 계산
		int totalCount = dao.getTotalTransCount();
		int pageCount = totalCount / slc;
		if(totalCount % slc != 0) pageCount++;
		request.setAttribute("PAGES", pageCount);	
		request.setAttribute("TOTAL", totalCount);
		//각 페이지 표시글 번호
		int startRn = (pageNo -1)*slc + 1; //현 페이지의 첫 표시건 rn
		int endRn = pageNo * slc; //현 페이지의 마지막 표시건 rn
		if(endRn > totalCount) endRn = totalCount;
		request.setAttribute("STARTRN", startRn);
		request.setAttribute("ENDRN", endRn);
		//jsp로 데이터 전달
		RequestDispatcher rd = request.getRequestDispatcher("listTransaction.jsp?SLC="+slc);
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
