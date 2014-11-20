package quiz;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GetQuiz
 */
@WebServlet("/GetQuiz")
public class GetQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetQuiz() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int quizNumber = Integer.parseInt(request.getParameter("num"));
		
		Statement statement = Database.statement;
		ResultSet rs;
		
		// Query for quiz data

		// Query for questions
		Vector<String> questions = new Vector<String>();
		Vector<Integer> types = new Vector<Integer>();
		try {
			rs = statement.executeQuery("SELECT * FROM questions WHERE zID='" + quizNumber + "' ORDER BY sID");
			while(rs.next()){
				questions.add(rs.getString("question"));
				types.add(rs.getInt("type"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("questions", questions);
		request.setAttribute("types", types);
		request.getSession().setAttribute("types", types);
		
		
		// Query for choices
		Vector<String> choices = new Vector<String>();
		Vector<Integer> choicesTo = new Vector<Integer>();
		try {
			rs = statement.executeQuery("SELECT * FROM choices WHERE zID=" + quizNumber + " ORDER BY sID");
			while(rs.next()){
				choices.add(rs.getString("choice"));
				choicesTo.add(rs.getInt("sID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.setAttribute("choices", choices);
		request.setAttribute("choicesTo", choicesTo);
		
		
		
		// Query for answers
		Vector<String> answers = new Vector<String>();
		Vector<Integer> answersTo = new Vector<Integer>();
		try {
			rs = statement.executeQuery("SELECT * FROM answers WHERE zID='" + quizNumber + "' ORDER BY sID");
			while(rs.next()){
				answers.add(rs.getString("answer"));
				answersTo.add(rs.getInt("sID"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		request.getSession().setAttribute("answers", answers);
		request.getSession().setAttribute("answersTo", answersTo);
		request.getSession().setAttribute("zID", quizNumber);
	
		RequestDispatcher dispatch = request.getRequestDispatcher("quiz.jsp");
		dispatch.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
