package category;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Category;
import utility.CategoryDAO;

/**
 * Servlet implementation class DetailCategoryServlet
 */
@WebServlet("/detailCategory.do")
public class DetailCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DetailCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String cate_code = request.getParameter("CCODE");
		String mod = request.getParameter("MOD");
		System.out.println("DetailCategoryServlet 수신 CCODE : "+cate_code);
		CategoryDAO dao = new CategoryDAO();
		Category c = dao.getCategory(cate_code);
		request.setAttribute("C", c);
		String url = "";
		if(mod.equals("UPD")) { url = "updateCategory.jsp"; }
		if(mod.equals("DEL")) { url = "deleteCategory.jsp"; }
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
