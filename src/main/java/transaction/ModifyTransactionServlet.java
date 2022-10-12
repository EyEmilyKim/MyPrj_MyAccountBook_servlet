package transaction;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Category;
import model.Method;
import model.Transaction;
import utility.CategoryDAO;
import utility.MethodDAO;
import utility.TransactionDAO;

/**
 * Servlet implementation class ModifyTransactionServlet
 */
@WebServlet("/modifyTransaction.do")
public class ModifyTransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifyTransactionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* 수신한 seqno로 거래내역 객체 수신, 전달 */
		String seqno = request.getParameter("SN");
		TransactionDAO daoT = new TransactionDAO();
		Transaction trans = daoT.getTransaction(Integer.parseInt(seqno));
		request.setAttribute("TRANS", trans);
		/* 전체 카테고리 객체 수신, 전달 */
		CategoryDAO daoC = new CategoryDAO();
		ArrayList<Category> cateList = daoC.listCategory();
		request.setAttribute("CATELIST", cateList);
		/* 전체 결제수단 객체 수신, 전달 */
		MethodDAO daoM = new MethodDAO();
		ArrayList<Method> methList = daoM.listMethod();
		request.setAttribute("METHLIST", methList);
		/* 가계부 수정 form화면으로 이동 */
		RequestDispatcher rd = request.getRequestDispatcher("updateTransaction.jsp");
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
