package quiz;

import java.io.IOException;
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
	
	private int getNumberOfQuestions(int zID) throws SQLException{
		Statement statement = Database.statement;
		String query = "Select count(*) as Count From questions Where zID=" + zID ;
		
		ResultSet rs = statement.executeQuery(query);
		rs.next();
        
		return rs.getInt("Count");
	}
	
    
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Statement statement = Database.statement;
		int zID = (Integer)request.getSession().getAttribute("quizNumber");
		int sID = -1;
		try {
            sID = getNumberOfQuestions(zID);
		} catch (SQLException e) {e.printStackTrace();}
		
		String question = request.getParameter("question");
		ArrayList<String> choices = new ArrayList<String>();
		String answer = "";
		int type = (Integer)request.getSession().getAttribute("type");
		
		if (type == 1 || type == 2 || type == 4) {
			answer = request.getParameter("answer");
		}
		else if (type == 3) {
			for (int i = 1; i < 5; i++) {
				choices.add(request.getParameter("answer" + i));
			}
			int answerIndex = Integer.parseInt(request.getParameter("correctAnswer"));
			answer = choices.get(answerIndex - 1);
		}
		String insertQ  = "INSERT INTO questions VALUES (" + zID + ", " + sID + ", '" + question + "', " + type + ");";
		String insertA = "INSERT INTO answers VALUES (" + zID + ", " + sID + ", '" + answer + "');";
		System.out.println(insertA + "\n\n\n\n\n\n\n");
		try {
			statement.execute(insertQ);
			statement.execute(insertA);
		} catch (SQLException e) {e.printStackTrace();}
		
		String redirectTo = QuizConstants.INDEX_FILE;
		if (request.getParameter("status").equals("continue")) {
			redirectTo = "CreateQuizType.html";
		}

		RequestDispatcher dispatch = request.getRequestDispatcher(redirectTo);
		dispatch.forward(request, response);
	}
    
	
	
	
}
