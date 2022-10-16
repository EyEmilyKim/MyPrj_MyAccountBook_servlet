package transaction;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import model.Method;
import model.Transaction;
import utility.CategoryDAO;
import utility.MethodDAO;
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
		//세션에서 id 정보 수신 -> 비로그인 시 로그인 요청
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("USER_ID");
		if(id == null) {
			response.sendRedirect("needLogin.jsp"); return;
		}
		//INEX 파라미터(수입/지출) 수신
		String inex = "ALL";
		String inexParam = (String)request.getParameter("INEX");
		if(inexParam != null) inex = inexParam;
		//slc 파라미터(N줄 보기) 수신
		int slc = 5;
		String slcParam = (String)request.getParameter("SLC");
		if(slcParam != null) slc = Integer.parseInt(slcParam);
		//검색 조건 파라미터 수신
				String d_from = (String)request.getParameter("D_FROM");
				String d_to = (String)request.getParameter("D_TO");
				String item = (String)request.getParameter("ITEM");
				String cate = (String)request.getParameter("CATE");
				String meth = (String)request.getParameter("METH");
				System.out.println("SEARCH_V > \nd_from / d_to : "+d_from+" / "+d_to+"\nitem : "+item+" / cate : "+cate+" / meth : "+meth);
				String[] srch_v = {d_from, d_to, item, cate, meth};
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
		String url = "index.jsp?BODY=";
		CategoryDAO daoC = null;
		MethodDAO daoM = null;
		ArrayList<Category> cateList = null;
		ArrayList<Method> methList = null;
		//////// DB 연동 ////////
		switch(inex) {
		case "ALL" : //전체내역 보기
			System.out.println("INEX = ALL");
			url = url+"listALLTransaction.jsp";
			if(d_from == null && d_to == null && item == null) {
			//검색 조건 하나도 없을 때 : 
				list = dao.listCountedTrans(start, end, id);
				totalCount = dao.getTotalofTrans(id);
			}else {
			//검색 조건 있을 때 : 
				//거래내역 가장 옛날 & 최신 날짜 검색
				String t_from = dao.getOldestTransDate(id);
				String t_to = dao.getNewestTransDate(id);
				if(d_from == "") d_from = t_from;
				if(d_to == "") d_to = t_to;
				//거래내역 테이블에서 N건의 최근 조건부합 내역 검색
				list = dao.searchCountedTrans(d_from, d_to, "%"+item+"%", start, end, id);
				totalCount = dao.getTotalOfSearchTrans(d_from, d_to, "%"+item+"%", id);
				search = true;
			}
			break;
		case "EX" : 
			System.out.println("INEX = EX");
			url = url+"listEXTransaction.jsp";
			if(d_from == null && d_to == null && item == null && cate == null && meth == null) {
			//검색 조건 하나도 없을 때 : 
				list = dao.listCountedEXTrans(start, end, id);
				totalCount = dao.getTotalofEXTrans(id);
			}else { 
			//검색 조건 있을 때 : 
				//거래내역 가장 옛날 & 최신 날짜 검색
				String t_from = dao.getOldestTransDate(id);
				String t_to = dao.getNewestTransDate(id);
				if(d_from == "") d_from = t_from;
				if(d_to == "") d_to = t_to;
				list = dao.searchCountedEXTrans(d_from, d_to, "%"+item+"%", "%"+cate+"%", "%"+meth+"%", start, end, id);
				totalCount = dao.getTotalOfSearchEXTrans(d_from, d_to, "%"+item+"%", "%"+cate+"%", "%"+meth+"%", id);
				System.out.println("totalCount : "+totalCount);
				search = true;
			}
			/* 전체 카테고리 객체 수신, 전달 */
			daoC = new CategoryDAO();
			cateList = daoC.listCategory(id);
			request.setAttribute("CATELIST", cateList);
			/* 전체 결제수단 객체 수신, 전달 */
			daoM = new MethodDAO();
			methList = daoM.listMethod(id);
			request.setAttribute("METHLIST", methList);
			break;
		case "IN" : 
			System.out.println("INEX = IN");
			url = url+"listINTransaction.jsp";
			if(d_from == null && d_to == null && item == null && cate == null ) {
			//검색 조건 없을 때 : 
				list = dao.listCountedINTrans(start, end, id);
				totalCount = dao.getTotalofINTrans(id);
			}else {
			//검색 조건 있을 때 : 
				//거래내역 가장 옛날 & 최신 날짜 검색
				String t_from = dao.getOldestTransDate(id);
				String t_to = dao.getNewestTransDate(id);
				if(d_from == "") d_from = t_from;
				if(d_to == "") d_to = t_to;
				list = dao.searchCountedINTrans(d_from, d_to, "%"+item+"%", "%"+cate+"%", start, end, id);
				totalCount = dao.getTotalOfSearchINTrans(d_from, d_to, "%"+item+"%", "%"+cate+"%", id);
				search = true;
			}
			/* 전체 카테고리 객체 수신, 전달 */
			daoC = new CategoryDAO();
			cateList = daoC.listCategory(id);
			request.setAttribute("CATELIST", cateList);
			break;
		
		}
		////////DB 연동 끝////////
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
		RequestDispatcher rd = request.getRequestDispatcher(url+"?SLC="+slc+"&SRCH="+search);
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
