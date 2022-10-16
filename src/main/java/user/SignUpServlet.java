package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import utility.UserDAO;

/**
 * Servlet implementation class SignUpServlet
 */
@WebServlet("/signUp.do")
public class SignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignUpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("ID");
		String pwd = request.getParameter("PWD");
		String nname = request.getParameter("NNAME");
		String email = request.getParameter("EMAIL");
		String bday = request.getParameter("BDAY");
		
		User u = new User();
		u.setId(id); 
		u.setPwd(pwd);
		u.setNickname(nname);
		u.setEmail(email);
		u.setBirthday(bday);
		UserDAO dao = new UserDAO();
		boolean flag = dao.insertUser(u);
		response.sendRedirect("signUpResult.jsp?R="+flag);
	}

}
