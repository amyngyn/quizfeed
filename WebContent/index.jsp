<%@page import="quiz.Announcement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="java.util.*"%>
<%@ page import="quiz.Constants"%>
<%@ page import="quiz.TimeFormat"%>
<%@ page import="quiz.User"%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Home" name="title" />
</jsp:include>

<%
	User user = (User) session.getAttribute("user");

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

<h4>Recently Created Quizzes</h4>
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


<%
	Object o = session.getAttribute("user");

	if(o != null){
		
		user = (User) session.getAttribute("user");
		Integer uID = user.getID();

		if (uID == null) return;
		query = "Select zID, score, possible, time from scores where uID=" + uID + " order by time;";
		con = Database.openConnection();
		Statement s = Database.getStatement(con);

		Vector<Integer> zIDs = new Vector<Integer>();
		Vector<Integer> scores = new Vector<Integer>();
		Vector<Integer> possible = new Vector<Integer>();
		Vector<String> quizNames = new Vector<String>();
		Vector<Timestamp> scoreTimes = new Vector<Timestamp>();

		rs = s.executeQuery(query);
		while (rs.next()) {
			zIDs.add(rs.getInt("zID"));
			scores.add(rs.getInt("score"));
			possible.add(rs.getInt("possible"));
			scoreTimes.add(rs.getTimestamp("time"));
		}
	
		for(int i=0; i<zIDs.size(); i++){
			query = "Select name from quizzes where zID=" + zIDs.get(i) + ";";
			rs = s.executeQuery(query);
			rs.next();
			quizNames.add(rs.getString("name"));
		}
%>

	<h4>Your Recent Scores</h4>
	<table class="border">
			<tr class="border">
				<td class="wider, border"><b>Quiz Name</b></td>
				<td class="wider, border"><b>Score</b></td>
				<td class="wider, border"><b>Total</b></td>
				<td class="wider, border"><b>Time</b></td>
			</tr>
			<%
				for (int i = 0; i < zIDs.size(); i++) {
			%>
			<tr class="border">
				<td class="border"><%=quizNames.get(i)%></td>
				<td class="border"><%=scores.get(i)%></td>
				<td class="border"><%=possible.get(i)%></td>
				<td class="border"><%=scoreTimes.get(i)%></td>
			</tr>
			<%
				}
			%>
	</table>
<%}else{%>
	<h4>Your Recent Scores</h4>
	<p><a href="login.jsp">Login</a></p>
<%}%>

<h4>Your Achievements</h4>
<table class="border">
	<%
		Object j = session.getAttribute("user");
	
		if(j != null){	
		user = (User) session.getAttribute("user");
		Integer uID = user.getID();

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
		}}
	%>
</table>
	<%}else{ %>
	<a href="login.jsp">Login</a>
	<%} %>

<%
	Object b = session.getAttribute("user");

	if(b != null){
		
		user = (User) session.getAttribute("user");
		Integer uID = user.getID();

		
		query = "Select name, time from quizzes where uID=" + uID + " order by time;";
		con = Database.openConnection();
		Statement s = Database.getStatement(con);

		Vector<String> createNames = new Vector<String>();
		Vector<Timestamp> createTimes = new Vector<Timestamp>();

		rs = s.executeQuery(query);
		while (rs.next()) {
			createNames.add(rs.getString("name"));
			createTimes.add(rs.getTimestamp("time"));
		}
%>

	<h4>Quizzes I've Made</h4>
	<table class="border">
			<tr class="border">
				<td class="wider, border"><b>Quiz Name</b></td>
				<td class="wider, border"><b>Time</b></td>
			</tr>
			<%
				for (int i = 0; i < createTimes.size(); i++) {
			%>
			<tr class="border">
				<td class="border"><%=createNames.get(i)%></td>
				<td class="border"><%=createTimes.get(i)%></td>
			</tr>
			<%
				}
			%>
	</table>
<%}else{%>
	<h4>Quizzes I've Made</h4>
<%}%>




<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>