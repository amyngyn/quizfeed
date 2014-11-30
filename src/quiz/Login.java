package quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Login() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatch = request.getRequestDispatcher("login.jsp");
		dispatch.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ServletContext context = getServletContext();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		int uID = User.validateUser(username, password);

		if (uID != -1) {
			Cookie uIDCookie = new Cookie("uID", "" + uID);
			uIDCookie.setMaxAge(60 * 60); // 1 hour
			response.addCookie(uIDCookie);
			
			Cookie usernameCookie = new Cookie("username", username);
			uIDCookie.setMaxAge(60 * 60); // 1 hour
			response.addCookie(usernameCookie);
			
			System.out.println("added cookie username with value " + username);
			RequestDispatcher dispatch = request.getRequestDispatcher("UserHome.jsp");
			dispatch.forward(request, response);
		} else {
			context.setAttribute("error", "Password was invalid. password: " + password);
			RequestDispatcher dispatch = request.getRequestDispatcher("login.jsp");
			dispatch.forward(request, response);
		}
	}
}
