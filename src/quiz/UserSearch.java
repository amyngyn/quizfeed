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
 * Servlet implementation class UserSearch
 */
@WebServlet("/UserSearch")
public class UserSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSearch() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = (String)request.getParameter("username");
		
		Statement statement = Database.statement;
		String query = "Select uID From users Where name='" + name + "'";
		
		ResultSet rs;
		Boolean next = false;
		try {
			rs = statement.executeQuery(query);
			next = rs.next();
		} catch (SQLException e) {e.printStackTrace();}
		
		
		
		if(!next){
			RequestDispatcher dispatch = request.getRequestDispatcher(QuizConstants.INDEX_FILE);
			dispatch.forward(request, response);
			return;
		}
		
		
		getServletContext().setAttribute("search", name);
		RequestDispatcher dispatch = request.getRequestDispatcher("UserProfile.jsp");
		dispatch.forward(request, response);
		
	}

}