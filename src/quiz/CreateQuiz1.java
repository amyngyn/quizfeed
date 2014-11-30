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
 * Servlet implementation class CreateQuiz1
 */
@WebServlet("/CreateQuiz1")
public class CreateQuiz1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateQuiz1() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }


	private int getNumberOfQuizzes() throws SQLException{
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			String query = "Select count(*) as Count From quizzes";
			rs = statement.executeQuery(query);
			rs.next();
			return rs.getInt("Count");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
		return -1;
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		int user = 0;
		String timestamp = TimeFormat.getTime();

		Connection con = null;
		Statement statement = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			int quizNumber = getNumberOfQuizzes();

			String insertValues= "'" + name + "'" + ", "
					+ "'" + description + "'" + ", "
					+ user + ", "
					+ "'" + timestamp + "'";
			String insertQuery = "INSERT INTO quizzes VALUES (" +  quizNumber + ", "+ insertValues+ ");";
			statement.execute(insertQuery);

			//add tuple to achievements
			int AUTHOR_TYPE = 0;
			Integer uID = (Integer) request.getSession().getAttribute("uID");
			if (uID != null) {
				insertQuery = "INSERT INTO achievements VALUES (" + uID + ", " + AUTHOR_TYPE + ", '" + name + "');";
				statement.execute(insertQuery);
			}

			request.getSession().setAttribute("quizNumber", quizNumber);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, null);
		}

		RequestDispatcher dispatch = request.getRequestDispatcher("CreateQuizType.html");
		dispatch.forward(request, response);
	}

}
