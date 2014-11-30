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
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;


		String user = request.getParameter("username");
		String password = request.getParameter("password");

		String query = "Select uID, password, salt From users Where name='" + user + "';";

		String nextPage = "login.jsp";
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			rs = statement.executeQuery(query);
			if (!rs.next()) {
				context.setAttribute("error", "That user does not exist.");
				return;
			}
			
			String passwordDatabase = rs.getString("password");
			String salt = rs.getString("salt");
			if (!passwordDatabase.equals(User.generateSaltedHash(password, salt))) {
				context.setAttribute("error", "Password was invalid. password: " + password + ", " + salt);
			} else {
				context.setAttribute("message", "FYI: Password was valid.");
				int uID = rs.getInt("uID");

				// should all be converted to getSession right?
				context.setAttribute("userName", user);
				context.setAttribute("uID", uID);
				request.getSession().setAttribute("uID", uID);

				nextPage = "UserHome.jsp";
			}
			RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
			dispatch.forward(request, response);
		} catch (SQLException e){
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
	}
}
