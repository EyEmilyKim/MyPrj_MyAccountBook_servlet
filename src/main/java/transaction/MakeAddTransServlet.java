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
import utility.CategoryDAO;
import utility.MethodDAO;
import utility.TransactionDAO;

/**
 * Servlet implementation class GetTransSeqnoServlet
 */
@WebServlet("/makeAddTrans.do")
public class MakeAddTransServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MakeAddTransServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("USER_ID");
		if(id == null) {
			System.out.println("makeAddTrans 호출됨. //로그인 아이디 없음.");
			response.sendRedirect("index.jsp?BODY=needLogin.jsp"); return;
		}
		/* 가계부 기록의 최신 일련번호 수신, 전달 */
		TransactionDAO daoT = new TransactionDAO();
		int maxSeqno = daoT.getTransSeqno();
		request.setAttribute("MSN", maxSeqno);
		/* 전체 카테고리 객체 수신, 전달 */
		CategoryDAO daoC = new CategoryDAO();
		ArrayList<Category> cateList = daoC.listCategory(id);
		request.setAttribute("CATELIST", cateList);
		/* 전체 결제수단 객체 수신, 전달 */
		MethodDAO daoM = new MethodDAO();
		ArrayList<Method> methList = daoM.listMethod(id);
		request.setAttribute("METHLIST", methList);
		/* 가계부 작성 form화면으로 이동 */
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?BODY=addTransaction.jsp");
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
