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
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	
	private int getNumberOfQuizzes() throws SQLException{
		
		Statement statement = Database.statement;
		String query = "Select count(*) as Count From quizzes";
		
		ResultSet rs = statement.executeQuery(query);
		rs.next();
	
		return rs.getInt("Count");
	}
	
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String description = request.getParameter("description");
		int user = 0;
		int time = 0;
		
		Statement statement = Database.statement;
		
		String insert = ("'" + name + "'" + ", ");
		insert += ("'" + description + "'" + ", ");
		insert += (user + ", ");
		
		TimeString t = new TimeString();
		String string = t.string;
		insert += ("'" + string + "'");
		
		int quizNumber = -1;
		try {
			quizNumber = getNumberOfQuizzes();
			insert = "INSERT INTO quizzes VALUES (" +  quizNumber + ", "+ insert + ");";
			statement.execute(insert);
			
			// add tuple to achievements
			int AUTHOR_TYPE = 0;
			Integer uID = (Integer)request.getSession().getAttribute("uID");
			if(uID != null){
				insert = "INSERT INTO achievements VALUES (" + uID + ", " + AUTHOR_TYPE + ", '" + name + "');";
				statement.execute(insert);
			}
		} catch (SQLException e) {e.printStackTrace();}
		
		request.getSession().setAttribute("quizNumber", quizNumber);
		
		RequestDispatcher dispatch = request.getRequestDispatcher("CreateQuizType.html");
		dispatch.forward(request, response);
		
		// TODO Auto-generated method stub
	}

}
