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
 * Servlet implementation class GradeQuiz
 */
@WebServlet("/GradeQuiz")
public class GradeQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GradeQuiz() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }

	private void recordScore(int uID, int zID, int score, int possible){
		Connection con = null;
		Statement statement = null;
		String timestamp = TimeFormat.getTimestamp();
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);
			String insertQuery = "INSERT INTO scores VALUES ("
					+ uID + ", "
					+ zID + ", "
					+ score + ", "
					+ possible + ", '"
					+ timestamp + "');";
			statement.execute(insertQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, null);
		}
	}

	private void addQuizMachineAchievement(int uID, int zID) {
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			String query = "Select name From quizzes Where zID=" + zID + ";";

			rs = statement.executeQuery(query);
			rs.next();
			String name = rs.getString("name");

			int QUIZMACHINE_TYPE = 1;
			String insert = "INSERT INTO achievements VALUES (" + uID + ", " + QUIZMACHINE_TYPE + ", '" + name + "');"; 
			statement.execute(insert);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
	}

	private void addHighScoreAchievement(int score, int uID, int zID) {
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			int HIGHSCORE_TYPE = 2;

			String query = "Select name From quizzes Where zID=" + zID + ";";
			rs = statement.executeQuery(query);
			rs.next();
			String name = rs.getString("name");

			query = "Select max(score) as score From scores Where zID=" + zID + ";";
			rs = statement.executeQuery(query);
			if (!rs.next()) {
				String insert = "INSERT INTO achievements VALUES (" + uID + ", " + HIGHSCORE_TYPE + ", '" + name + "');"; 
				statement.execute(insert);
				return;
			}
			int high = rs.getInt("score");
			if(score < high) return;

			String insert = "INSERT INTO achievements VALUES (" + uID + ", " + HIGHSCORE_TYPE + ", '" + name + "');"; 
			statement.execute(insert);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int zID = (int)request.getSession().getAttribute("zID");
		Quiz q = null;
		ArrayList<Integer> types = null;
		try {
			q = new Quiz(zID);
			types = q.getQuestionTypes();
		} catch (SQLException e1) {e1.printStackTrace();}
		
		//(ArrayList<Integer>) request.getSession().getAttribute("types");
		request.setAttribute("size", types.size());
		//ArrayList<String> answers = (ArrayList<String>) request.getSession().getAttribute("answers");
		//ArrayList<Integer> answersTo = (ArrayList<Integer>) request.getSession().getAttribute("answersTo");
		//int answersSize = answers.size();

		int questions = types.size();
		int score = 0;
		int possible = 0;

		for (int i = 0; i < questions; i++) {
			if (types.get(i) == 1) { // text
				String userAnswer = (String) request.getParameter(i + "");
				//int index = answersTo.indexOf(i);
				//String correct = answers.get(index);
				String correct;
				
				try {
					correct = q.getAnswers(i).get(0);
					if (correct.equals(userAnswer)) score++;
				} catch (SQLException e) {e.printStackTrace();}
				possible++;

			} else if (types.get(i) == 2) { // multiple choice
				String userAnswer = (String) request.getParameter(i + "");
				//int index = answersTo.indexOf(i);
				//String correct = answers.get(index);
				String correct;
				try {
					correct = q.getAnswers(i).get(0);
					if (correct.equals(userAnswer)) score++;
				} catch (SQLException e) {e.printStackTrace();}
			
				possible++;

			} else if (types.get(i) == 3) { // multiple choice
				String userAnswer = (String) request.getParameter(i + "");
				String correct;
				try {
					correct = q.getAnswers(i).get(0);
					if (correct.equals(userAnswer)) score++;
				} catch (SQLException e) {e.printStackTrace();}
				
				possible++;

			} else if (types.get(i) == 4) { // picture response
				String userAnswer = (String) request.getParameter(i + "");
				String correct;
				try {
					correct = q.getAnswers(i).get(0);
					if (correct.equals(userAnswer)) score++;
				} catch (SQLException e) {e.printStackTrace();}
				
				possible++;

			} else if (types.get(i) == 5) { // multi text
				ArrayList<String> theAnswers = null; 
				
				try {
					theAnswers = q.getAnswers(i);
				} catch (SQLException e) {e.printStackTrace();}
				
				int count = theAnswers.size();
				for (int j = 0; j < count; j++) {
					String name = i + "-" + j;
					String userText = request.getParameter(name);
					if (theAnswers.contains(userText)) score++;
					possible++;
				}

			} else if (types.get(i) == 6) { // multi answer multi choice
				
				ArrayList<String> theAnswers = null; 
				int count = 0;
				
				try {
					theAnswers = q.getAnswers(i);
					count = q.getChoicesCount(i);
				} catch (SQLException e) {e.printStackTrace();}
				
				possible += theAnswers.size();
				//request.setAttribute("test", theAnswers.get(3));
				// must know choices to precisely get this answer
				
				for (int j=0; j<count; j++) {
					String name = i + "-" + j;
					String userText = request.getParameter(name);	
					if (theAnswers.contains(userText)) {
						score++;
					}
				}
			} else if(types.get(i) == 7) {
				ArrayList<String> theAnswers= null;// = new ArrayList<String>();
				
				
				try {
					theAnswers = q.getAnswers(i);
				} catch (SQLException e) {e.printStackTrace();}
				
				possible += theAnswers.size();
				int count = theAnswers.size();
				
				for (int j = 0; j < count; j++) {
					String name = i + "-" + j;
					String userText = request.getParameter(name);	
					if (theAnswers.get(j).equals(userText)) {
						score++;
					}
				}
			}
		}

		request.setAttribute("score", score);
		request.setAttribute("possible", possible);
		User user = (User) request.getSession().getAttribute("user");
		zID = (Integer)request.getSession().getAttribute("zID");

		if (user != null) {
			int uID = user.getID();
			recordScore(uID, (Integer)request.getSession().getAttribute("zID"), score, possible);
			addQuizMachineAchievement(uID, zID);
			addHighScoreAchievement(score, uID, (Integer)request.getSession().getAttribute("zID"));
		} else {
			throw new IllegalStateException("Somehow a quiz is being graded without a logged in user?? Fix this!");
		}

		RequestDispatcher dispatch = request.getRequestDispatcher("GradedQuiz.jsp");
		dispatch.forward(request, response);	
	}
}





