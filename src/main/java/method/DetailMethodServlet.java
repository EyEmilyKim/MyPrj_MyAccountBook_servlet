package method;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Method;
import utility.MethodDAO;

/**
 * Servlet implementation class DetailMethodServlet
 */
@WebServlet("/detailMethod.do")
public class DetailMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailMethodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String meth_code = request.getParameter("MCODE");
		String mod = request.getParameter("MOD");
		System.out.println("DetailMethodServlet 수신 MCODE : "+meth_code);
		MethodDAO dao = new MethodDAO();
		Method m = dao.getMethod(meth_code);
		request.setAttribute("M", m);
		String url = "";
		if(mod.equals("UPD")) { url = "updateMethod.jsp"; }
		if(mod.equals("DEL")) { url = "deleteMethod.jsp"; }
		RequestDispatcher rd = request.getRequestDispatcher(url);
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
