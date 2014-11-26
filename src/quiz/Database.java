package quiz;

import java.sql.*;

public class Database {

	public static Statement statement; // TODO(amyng): why is this public?

	/**
	 * 	Establishes database connection and makes a Statement variable available
	 **/
	public Database(){
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = (Connection) DriverManager.getConnection("jdbc:mysql://" + DatabaseInfo.MYSQL_DATABASE_SERVER, DatabaseInfo.MYSQL_USERNAME, DatabaseInfo.MYSQL_PASSWORD);
			statement = (Statement) con.createStatement();
			statement.executeQuery("USE " + DatabaseInfo.MYSQL_DATABASE_NAME);
		} catch (SQLException e) {	
			e.printStackTrace();
			System.exit(0);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			System.exit(0);
		}
	}	

}