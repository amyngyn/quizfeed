package quiz;

import java.sql.*;

public class Database {
	public static final String USE_STATEMENT = "USE " + DatabaseInfo.MYSQL_DATABASE_NAME;

	public static Connection openConnection() throws SQLException {
		return (Connection) DriverManager.getConnection(
				"jdbc:mysql://" + DatabaseInfo.MYSQL_DATABASE_SERVER,
				DatabaseInfo.MYSQL_USERNAME,
				DatabaseInfo.MYSQL_PASSWORD);
	}

	public static Statement getStatement(Connection con) throws SQLException {
		Statement statement = (Statement) con.createStatement();
		statement.executeQuery(USE_STATEMENT);
		return statement;
	}

	public static void closeConnections(Connection con, Statement statement, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (statement != null) {
				statement.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}