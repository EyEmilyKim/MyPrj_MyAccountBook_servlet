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
		String str_slc = request.getParameter("SLC");
		int slc = Integer.parseInt(str_slc);
		//page 파라미터 수신
		int pageNo = 1;
		//if(page != "")
		int start = (pageNo -1)* slc;
		int end = ( (pageNo -1)* slc ) + (slc +1);
		System.out.println("listTrans.do"+"\n start : "+start+"\n end : "+end);
		//
		TransactionDAO dao = new TransactionDAO();
		ArrayList<Transaction> list = dao.listCountedTrans(start, end);
		request.setAttribute("LIST", list);
		request.setAttribute("SIZE", list.size());
		RequestDispatcher rd = request.getRequestDispatcher("listTransaction.jsp");
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
