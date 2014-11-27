package quiz;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import java.io.IOException;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;
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
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Statement statement = Database.statement;
		String text = request.getParameter("announcement");
		int uID = (Integer)request.getServletContext().getAttribute("uID");
		
		TimeString time = new TimeString();
		String string = time.string;
		
		String insert = "INSERT INTO announcements VALUES (" +uID+ ", '" + text + "', '" + string + "');";
		
		
		if(!text.equals("")){
			try {
				statement.execute(insert);
			} catch (SQLException e) {e.printStackTrace();}
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher("AdminPage.jsp");
		dispatch.forward(request, response);
	}

}
