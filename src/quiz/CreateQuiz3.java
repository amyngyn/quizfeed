package quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateQuiz3
 */
@WebServlet("/CreateQuiz3")
public class CreateQuiz3 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CreateQuiz3() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	private int getNumberOfQuestions(int zID) throws SQLException {
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);
			String query = "Select count(*) as Count From questions Where zID=" + zID ;

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
		Connection con = null;
		Statement statement = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			int zID = (Integer)request.getSession().getAttribute("quizNumber");
			int sID = -1;

			sID = getNumberOfQuestions(zID);

			String question = request.getParameter("question");
			ArrayList<String> choices = new ArrayList<String>();
			String answer = "";
			int type = (Integer)request.getSession().getAttribute("type");

			// TODO make these constants
			if (type == 1 || type == 2 || type == 4) {
				answer = request.getParameter("answer");
			} else if (type == 3) {
				for (int i = 1; i < 5; i++) {
					choices.add(request.getParameter("answer" + i));
				}
				int answerIndex = Integer.parseInt(request.getParameter("correctAnswer"));
				answer = choices.get(answerIndex - 1);
			}
			String insertQ  = "INSERT INTO questions VALUES (" + zID + ", " + sID + ", '" + question + "', " + type + ");";
			String insertA = "INSERT INTO answers VALUES (" + zID + ", " + sID + ", '" + answer + "');";

			statement.execute(insertQ);
			statement.execute(insertA);

			String redirectTo = Constants.INDEX;
			if (request.getParameter("status").equals("continue")) {
				redirectTo = "CreateQuizType.html";
			}

			RequestDispatcher dispatch = request.getRequestDispatcher(redirectTo);
			dispatch.forward(request, response);
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		} finally {
			Database.closeConnections(con, statement, null);
		}
	}
}
