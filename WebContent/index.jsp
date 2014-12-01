<%@page import="quiz.Announcement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="java.util.*"%>
<%@ page import="quiz.Constants"%>
<%@ page import="quiz.TimeFormat"%>
<%@ page import="quiz.User"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home - <%=Constants.QUIZ_SITE_TITLE%></title>
<link rel="icon" href="/favicon.ico" type="image/x-icon" />
</head>
<body>

	<jsp:include page="<%=Constants.HEADER_FILE%>" />

	<%
		User user = (User) session.getAttribute("user");
		if (user == null) {
	%>
	<%
		} else {
	%>
	<p>
		Hi,
		<%=user.getUsername()%>! <a href="UserHome.jsp">My Page</a> <a
			href="AdminBegin">Admin Page</a> <a href="Logout">Log Out</a>
	</p>

	<form action="UserSearch" method="post">
		User Search: <input type="text" name="username"> <input
			type="submit" name="Search">
	</form>

	<%
		}
	%>

	<%
		ArrayList<String> names = new ArrayList<String>();
		Connection con = null;
		Statement statement = null;
		try {
			con = Database.openConnection();
			statement = Database.getStatement(con);
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		String query = "Select name From quizzes";
		ResultSet rs = statement.executeQuery(query);
		while (rs.next()) {
			names.add(rs.getString("name"));
		}

		ArrayList<Announcement> announcements = Announcement
				.getAnnouncements(5);

		Vector<String> recentNames = new Vector<String>();
		Vector<Timestamp> recentTimes = new Vector<Timestamp>();
		query = "Select name, time From quizzes Order By time ASC";
		rs = statement.executeQuery(query);
		int count = 0;
		while (rs.next()) {
			count++;
			recentNames.add(rs.getString("name"));
			recentTimes.add(rs.getTimestamp("time"));
			if (count == 5)
				break;
		}
		Statement statementTwo = Database.getStatement(con);
		Vector<String> popularNames = new Vector<String>();
		Vector<Integer> popularCounts = new Vector<Integer>();
		query = "Select zID,count(*) as Count From scores Group By zID Order By Count DESC";
		rs = statement.executeQuery(query);
		count = 0;
		while (rs.next()) {
			count++;
			int z = rs.getInt("zID");
			String queryTwo = "Select name From quizzes Where zID =" + z
					+ ";";
			ResultSet rsTwo = statementTwo.executeQuery(queryTwo);
			rsTwo.next();
			String name = rsTwo.getString("name");
			popularNames.add(name);
			popularCounts.add(rs.getInt("Count"));
			if (count == 5)
				break;
		}
	%>

	<table>
		<tr>
			<th>Quiz Name</th>
		</tr>
		<%
			for (int i = 0; i < names.size(); i++) {
		%>
		<tr>
			<td><a href="<%="QuizIntro?num=" + i%>"><%=names.get(i)%></a></td>
		</tr>
		<%
			}
		%>
	</table>
	<p>
		<a href="CreateQuizBegin.html">Create a New Quiz</a>
	</p>

	<table>
		<tr>
			<th>Announcements</th>
		</tr>
		<%
			for (int i = 0; i < announcements.size(); i++) {
				Announcement a = announcements.get(i);
		%>
		<tr>
			<td><%=(i + 1) + ". "%><%=a.getAnnouncementText() + " at " + a.getHumanTime()%></td>
		</tr>
		<%
			}
		%>
	</table>

	<h4>Recent Quizzes</h4>
	<table class="border">
		<tr>
			<th class="border"><b>Name</b></th>
			<th class="border"><b>Time Created</b></th>
		</tr>
		<%
			for (int i = 0; i < recentNames.size(); i++) {
		%>
		<tr>
			<td class="border"><%=recentNames.get(i)%></td>
			<td class="border"><%=recentTimes.get(i)%></td>
		</tr>
		<%
			}
		%>
	</table>
	<h4>Popular Quizzes</h4>
	<table class="border">
		<tr>
			<th class="border"><b>Name</b></th>
			<th class="border"><b>Attempts</b></th>
		</tr>
		<%
			for (int i = 0; i < popularNames.size(); i++) {
		%>
		<tr>
			<td class="border"><%=popularNames.get(i)%></td>
			<td class="border"><%=popularCounts.get(i)%></td>
		</tr>
		<%
			}
		%>
	</table>
	<h4>Your Achievements</h4>
	<table class="border">
		<%
			Integer uID = (Integer) session.getAttribute("uID");

			if (uID != null) {

				query = "Select name From achievements Where type = 0 AND uID="
						+ uID + ";";
				rs = statement.executeQuery(query);
				Vector<String> created = new Vector<String>();
				while (rs.next()) {
					created.add(rs.getString("name"));
				}
				int size = created.size();
				int AMATEUR_AUTHOR = 1;
				if (size >= AMATEUR_AUTHOR) {
					String title = "";
					for (int i = 0; i < AMATEUR_AUTHOR; i++) {
						title += created.get(i);
						if (i != AMATEUR_AUTHOR - 1)
							title += ", ";
					}
		%>

		<tr class="border">
			<td title="<%=title%>" class="pointer">Amateur Author</td>
		</tr>
		<%
			}
				int PROLIFIC_AUTHOR = 5;
				if (size >= PROLIFIC_AUTHOR) {
					String title = "";
					for (int i = 0; i < PROLIFIC_AUTHOR; i++) {
						title += created.get(i);
						if (i != PROLIFIC_AUTHOR - 1)
							title += ", ";
					}
		%>
		<tr class="border">
			<td title="<%=title%>" class="pointer">Prolific Author</td>
		</tr>
		<%
			}
		%>

		<%
			int PRODIGIOUS_AUTHOR = 10;
				if (size >= PRODIGIOUS_AUTHOR) {
					String title = "";
					for (int i = 0; i < PRODIGIOUS_AUTHOR; i++) {
						title += created.get(i);
						if (i != PRODIGIOUS_AUTHOR - 1)
							title += ", ";
					}
		%>
		<tr class="border">
			<td title="<%=title%>" class="pointer">Prodigious Author</td>
		</tr>
		<%
			}
		%>

		<%
			query = "Select name From achievements Where type = 1 AND uID="
						+ uID + ";";
				rs = statement.executeQuery(query);
				Vector<String> taken = new Vector<String>();
				while (rs.next()) {
					taken.add(rs.getString("name"));
				}
				size = taken.size();
				int QUIZ_MACHINE = 10;
				if (size >= QUIZ_MACHINE) {
					String title = "";
					for (int i = 0; i < QUIZ_MACHINE; i++) {
						title += taken.get(i);
						if (i != QUIZ_MACHINE - 1)
							title += ", ";
					}
		%>
		<tr class="border">
			<td title="<%=title%>" class="pointer">Quiz Machine</td>
		</tr>
		<%
			}
		%>

		<%
			uID = (Integer) session.getAttribute("uID");
				query = "Select name From achievements Where type = 2 AND uID="
						+ uID + ";";
				rs = statement.executeQuery(query);
		%>
		<%
			if (rs.next()) {
					String high = rs.getString("name");
		%>
		<tr class="border">
			<td title="<%=high%>" class="pointer">I am the Greatest</td>
		</tr>
		<%
			}
		%>

		<%
			// TO-DO: award this achievement when practice mode works
				// For achievements, finished all but this last step. Figured we'd find this while testing.
				query = "Select name From achievements Where type = 3 AND uID="
						+ uID + ";";
				rs = statement.executeQuery(query);
		%>
		<%
			if (rs.next()) {
					String practice = rs.getString("name");
		%>
		<tr class="border">
			<td title="<%=practice%>" class="pointer">Practice Makes Perfect</td>
		</tr>
		<%
			}
		%>

	</table>
	<%
		}
	%>

</body>
</html>