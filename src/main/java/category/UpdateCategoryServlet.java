package category;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Category;
import utility.CategoriesDAO;

/**
 * Servlet implementation class UpdateCategoryServlet
 */
@WebServlet("/updateCategory.do")
public class UpdateCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cate_code = request.getParameter("CCODE");
		String cate_name = request.getParameter("N_CNAME");
		Category c = new Category();
		c.setCate_code(cate_code);
		c.setCate_name(cate_name);
		CategoriesDAO dao = new CategoriesDAO();
		boolean flag = dao.updateCategory(c);
		response.sendRedirect("updateCategoryResult.jsp?R="+flag);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
