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
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
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
		
		
		Statement statement = Database.statement;
		String user = request.getParameter("username");
		String password = request.getParameter("password");
		
		String query = "Select uID, password From users Where name='" + user + "';";
		
		ResultSet rs = null;
		String nextPage = "Login.html";
		try {
			rs = statement.executeQuery(query);
		
			if(rs.next()){
				int uID = rs.getInt("uID");
				
				// should all be converted to getSession right?
				getServletContext().setAttribute("userName", user);
				getServletContext().setAttribute("uID", uID);
				request.getSession().setAttribute("uID", uID);
				
				nextPage = "UserHome.jsp";
			}
		} catch (SQLException e) {e.printStackTrace();}
				
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
		
		
		
	}

}