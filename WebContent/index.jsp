<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="java.util.*"%>
<%@ page import="quiz.QuizConstants"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home - <%=QuizConstants.QUIZ_SITE_TITLE%></title>
</head>
<body>
	<jsp:include page="<%=QuizConstants.HEADER_FILE%>" />

	<%
		ServletContext context = getServletContext();
		if (context.getAttribute("userName") == null) {
	%>
	<p>
		<a href="login.jsp"><b>Login</b></a>
	</p>
	<%
		} else {
	%>
	<p>
		Hi, <%=context.getAttribute("userName")%>!
		<a href="UserHome.jsp">My Page</a>
		<a href="AdminBegin">Admin Page</a>
		<a href="Logout">Log Out</a>
	</p>
	
	<form action="UserSearch" method="post">
		User Search: <input type="text" name="username">
		<input type="submit" name="Search">
	</form>

	<%
		}
	%>

	<%
		Vector<String> names = new Vector<String>();
		Statement statement = Database.statement;
		String query = "Select name From quizzes";
		ResultSet rs = statement.executeQuery(query);
		while (rs.next()) {
			names.add(rs.getString("name"));
		}
		Vector<String> announcements = new Vector<String>();
		Vector<String> times = new Vector<String>();
		query = "Select announcement, time From announcements";
		rs = statement.executeQuery(query);
		while (rs.next()) {
			announcements.add(rs.getString("announcement"));
			times.add(rs.getString("time"));
		}
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
		Database d = new Database();
		Statement statementTwo = d.statement;
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
		<tr><th>Quiz Name</th></tr>
		<% for (int i = 0; i < names.size(); i++) { %>
		<tr><td> <a href="<%="QuizIntro?num=" + i%>"><%=names.get(i)%></a> </td></tr>
		<% } %>
	</table>
	<p><a href="CreateQuizBegin.html">Create a New Quiz</a> </p>

	<table>
		<tr><th>Announcements</th></tr>
		<% for (int i = 0; i < announcements.size(); i++) { %>
		<tr><td><%=(i + 1) + ". "%><%=announcements.get(i) + " at " + times.get(i)%></td></tr>
		<% } %>
	</table>
	
	<h4>Recent Quizzes</h4>
	<table class="border">
		<tr>
			<th class="border"><b>Name</b></th>
			<th class="border"><b>Time Created</b></th>
		</tr>
		<% for (int i = 0; i < recentNames.size(); i++) { %>
			<tr>
				<td class="border"><%=recentNames.get(i)%></td>
				<td class="border"><%=recentTimes.get(i)%></td>
			</tr>
		<% } %>
	</table>
	<h4>Popular Quizzes</h4>
	<table class="border">
		<tr>
			<th class="border"><b>Name</b></th>
			<th class="border"><b>Attempts</b></th>
		</tr>
		<% for (int i = 0; i < popularNames.size(); i++) { %>
		<tr>
			<td class="border"><%=popularNames.get(i)%></td>
			<td class="border"><%=popularCounts.get(i)%></td>
		</tr>
		<% } %>
	</table>
	<h4>Your Achievements</h4>
	<table class="border">
	<%
	
		Integer uID = (Integer) context.getAttribute("uID");
		
		if(uID == null){
		%>
			<p><a href="login.jsp">Login</a>, to view achievements.<p>
		<%
		}else{
	
		query = "Select name From achievements Where type = 0 AND uID=" + uID + ";";
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
	<%  }
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
						uID = (Integer) context.getAttribute("uID");
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
						<td title="<%=practice%>" class="pointer">Practice Makes
							Perfect</td>
					</tr>
					<%
						}
					%>

				</table> <%}%>

</body>
</html>