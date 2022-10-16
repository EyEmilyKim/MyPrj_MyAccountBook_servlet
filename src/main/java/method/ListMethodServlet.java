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
 * Servlet implementation class ListMethodServlet
 */
@WebServlet("/listMethod.do")
public class ListMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListMethodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//세션에서 id 정보 수신 -> 비로그인 시 로그인 요청
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("USER_ID");
		if(id == null) {
			response.sendRedirect("needLogin.jsp"); return;
		}
		MethodDAO dao = new MethodDAO();
		ArrayList<Method> list = dao.listMethod(id);
		request.setAttribute("LIST", list);
		request.setAttribute("SIZE", list.size());
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp?BODY=listMethod.jsp");
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
