package quiz;


import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginCreate
 */
@WebServlet("/signup")
public class UserSignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserSignupServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher(Constants.SIGNUP_PAGE);
		dispatch.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (User.addUserToDatabase(username, password)) {			
			getServletContext().setAttribute("message", "");

			RequestDispatcher dispatch = request.getRequestDispatcher(Constants.INDEX);
			dispatch.forward(request, response);
		} else {
			getServletContext().setAttribute("message", "Username unavailable.");

			RequestDispatcher dispatch = request.getRequestDispatcher("LoginCreate.jsp");
			dispatch.forward(request, response);
		}
	}
}
