package transaction;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Transaction;
import utility.TransactionDAO;

/**
 * Servlet implementation class UpdateTransactionServlet
 */
@WebServlet("/updateTransaction.do")
public class UpdateTransactionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateTransactionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String seqno = request.getParameter("SEQNO");
		String inex = request.getParameter("INEX");
		String date = request.getParameter("DATE");
		String ccode = request.getParameter("CCODE");
		String item = request.getParameter("ITEM");
		String amount = request.getParameter("AMOUNT");
		String mcode = request.getParameter("MCODE");
	System.out.println("form수신> ccode: "+ccode+" / mcode: "+mcode);
		if(ccode.equals("")) ccode = "caNN0";//카테고리 미선택 디폴트: '미지정'
		if(mcode.equals("")) { //결제수단 미선택 디폴트: '미지정'
			if(inex.equals("EX")) mcode = "meNN0";  //지출이면 '미지정'
			else if(inex.equals("IN")) mcode = "meNN1";//수입이면 '해당없음' 
		}
		System.out.println("서블렛 MCODE : "+mcode);
		if(item == "") item = "내용없음"; //내용 미입력 디폴트: '내용없음'
		Transaction t = new Transaction();
		t.setSeqno(Integer.parseInt(seqno));
		t.setInex(inex);
		t.setTrans_date(date);
		t.setCate_code(ccode);
		t.setItem(item);
		t.setAmount(Integer.parseInt(amount));
		t.setMeth_code(mcode);
		TransactionDAO dao = new TransactionDAO();
		boolean flag = dao.updateTransaction(t);
		response.sendRedirect("updateTransactionResult.jsp?R="+flag+"&SN="+seqno);
		System.out.println("서블렛 끝");
	}

}
