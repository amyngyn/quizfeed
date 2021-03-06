package quiz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AdminRemove
 */
@WebServlet("/AdminRemove")
public class AdminRemove extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminRemove() {
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
		int remove = Integer.parseInt(request.getParameter("removeAdmin"));
		
		Connection con = null;
		Statement statement = null;
		String query = "DELETE FROM administrators WHERE uID=" + remove + ";";
		
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);
			statement.execute(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		Database.closeConnections(con, statement);
		
		RequestDispatcher dispatch = request.getRequestDispatcher("AdminPage.jsp");
		dispatch.forward(request, response);
		
	}

}
