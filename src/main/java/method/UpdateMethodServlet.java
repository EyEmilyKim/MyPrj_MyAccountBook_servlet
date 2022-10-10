package method;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Method;
import utility.MethodDAO;

/**
 * Servlet implementation class UpdateMethodServlet
 */
@WebServlet("/updateMethod.do")
public class UpdateMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateMethodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String meth_code = request.getParameter("MCODE");
		String meth_name = request.getParameter("N_MNAME");
		Method m = new Method();
		m.setMeth_code(meth_code);
		m.setMeth_name(meth_name);
		MethodDAO dao = new MethodDAO();
		boolean flag = dao.updateMethod(m);
		response.sendRedirect("updateMethodResult.jsp?R="+flag);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
