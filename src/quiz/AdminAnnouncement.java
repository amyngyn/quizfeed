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
 * Servlet implementation class AdminAnnoucement
 */
@WebServlet("/AdminAnnouncement")
public class AdminAnnouncement extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAnnouncement() {
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
		String text = request.getParameter("announcement");
		int uID = (Integer)request.getServletContext().getAttribute("uID");
		
		String insert = "INSERT INTO announcements VALUES ("+uID+ ", '" + text + "', null);";
		
		if(!text.equals("")){
			try {
				statement.execute(insert);
			} catch (SQLException e) {e.printStackTrace();}
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher("AdminPage.jsp");
		dispatch.forward(request, response);
	}

}
