package quiz;


import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 * Servlet implementation class LoginCreate
 */
@WebServlet("/LoginCreate")
public class LoginCreate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginCreate() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}


	private boolean available(String username) {
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			String query = "Select count(*) as count From users Where name='" + username + "';";
			rs = statement.executeQuery(query);
			rs.next();

			int count = rs.getInt("count");
			return count == 0;
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
		return false;
	}

	private void addUsername(String username, String password) {
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			String query = "Select count(*) as count From users;";
			rs = statement.executeQuery(query);
			rs.next();

			int count = rs.getInt("count");

			String passwordHash = User.generateSaltedHash(password, null);
			String insert = "INSERT INTO users VALUES (" + count + ", '" + username + "', '" + passwordHash + "');";
			statement.execute(insert);

			getServletContext().setAttribute("userName", username);
			getServletContext().setAttribute("uID", count);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if(!available(username)){
			getServletContext().setAttribute("message", "Username already used.");

			RequestDispatcher dispatch = request.getRequestDispatcher("LoginCreate.jsp");
			dispatch.forward(request, response);
		} else {
			addUsername(username, password);
			
			getServletContext().setAttribute("message", "");

			RequestDispatcher dispatch = request.getRequestDispatcher(QuizConstants.INDEX_FILE);
			dispatch.forward(request, response);	
		}
	}
}
