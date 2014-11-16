package quiz;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

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
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		
		int zID = (Integer)request.getSession().getAttribute("quizNumber");
		
		try {
		int sID = getNumberOfQuestions(zID);
		} catch (SQLException e) {e.printStackTrace();}
		
		String question = request.getParameter("question");
		int type = (Integer)request.getSession().getAttribute("type");
		
		String insert = "";
		
		
		
		
	}

	
	
	
}
