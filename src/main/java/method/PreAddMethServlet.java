package method;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Method;
import utility.MethodDAO;

/**
 * Servlet implementation class GetMethSeqnoServlet
 */
@WebServlet("/preAddMeth.do")
public class PreAddMethServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PreAddMethServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("USER_ID");
		MethodDAO dao = new MethodDAO();
		int maxSeqno = dao.getMethSeqno();
		ArrayList<Method> list = dao.listMethod(id);
		request.setAttribute("LIST", list);
		System.out.println("list.size() : "+list.size());
		RequestDispatcher rd = request.getRequestDispatcher("addMethod.jsp?MSN="+maxSeqno);
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
