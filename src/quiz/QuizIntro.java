package quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class QuizIntro
 */
@WebServlet("/QuizIntro")
public class QuizIntro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuizIntro() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		
		int num = Integer.parseInt(request.getParameter("num"));
				
		int zID = -1;
		String name = "";
		String description = "";
		int uID = -1;
		Timestamp time = null;
			    
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);
			rs = statement.executeQuery("SELECT * FROM quizzes WHERE zID='" + num + "'");
			rs.next();
			zID = rs.getInt("zID");
			name = rs.getString("name");
			description = rs.getString("description");
			uID = rs.getInt("uID");
			time = rs.getTimestamp("time");
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
				
		request.setAttribute("zID", zID);
		request.setAttribute("name", name);
		request.setAttribute("description", description);
		request.setAttribute("uID", uID);
		request.setAttribute("time", time);
		
		request.getSession().setAttribute("zID", zID);
				
		RequestDispatcher dispatch = request.getRequestDispatcher("QuizIntro.jsp");
		dispatch.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { }

}
