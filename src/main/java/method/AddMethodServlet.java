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
 * Servlet implementation class AddMethodServlet
 */
@WebServlet("/addMethod.do")
public class AddMethodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMethodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String Sseqno = request.getParameter("SEQNO");
		int seqno = Integer.parseInt(Sseqno);
		String mncrd = request.getParameter("MNCRD");
		String meth_name = request.getParameter("MNAME");
		String meth_code = mncrd + Sseqno;
		Method m = new Method();
		m.setSeqno(seqno);
		m.setMncrd(mncrd);
		m.setMeth_name(meth_name);
		m.setMeth_code(meth_code);
		MethodDAO dao = new MethodDAO();
		boolean flag = dao.insertMethod(m);
		response.sendRedirect("addMethodResult.jsp?R="+flag);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
