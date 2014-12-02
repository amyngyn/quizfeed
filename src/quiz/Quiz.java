package quiz;

import java.sql.*;
import java.util.*;

public class Quiz {
	private int zID;
	private String quizName;
	private String description;

	public Quiz(int zID, String quizName, String description) {
		this.zID = zID;
		this.quizName = quizName;
		this.description = description;
	}

	public int getID() {
		return zID;
	}

	public String getName() {
		return quizName;
	}

	public String getDescription() {
		return description;
	}

	// TODO use skip and amount params in query!
	public static ArrayList<Quiz> getQuizzes() {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();

		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);

			String query = "Select zID, name, description From quizzes Order by zID;";
			rs = statement.executeQuery(query);

			while (rs.next()) {
				String name = rs.getString("name");
				String description = rs.getString("description");
				int zID = rs.getInt("zID");
				quizzes.add(new Quiz(zID, name, description));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}
		return null;
	}

	public static ArrayList<Quiz> findQuizzes(String queryTerm) {
		ArrayList<Quiz> quizzes = new ArrayList<Quiz>();

		String query = "SELECT * FROM quizzes WHERE " 
				+ "name like '%" + queryTerm + "%'" 
				+ "OR description like '%" + queryTerm + "%'";

		Connection con = null;
		Statement statement = null;
		ResultSet rs = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);
			rs = statement.executeQuery(query);
			while (rs.next()) {
				int zID = rs.getInt("zID");
				String name = rs.getString("name");
				String description = rs.getString("description");
				quizzes.add(new Quiz(zID, name, description));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			Database.closeConnections(con, statement, rs);
		}


		return quizzes;
	}
}