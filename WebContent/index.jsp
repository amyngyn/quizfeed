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
	if(user == null){
		String redirectURL = "login.jsp";
		response.sendRedirect(redirectURL);
	}
	
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
	Vector<Integer> recentIDs = new Vector<Integer>();
	query = "Select name, time, zID From quizzes Order By time DESC";
	rs = statement.executeQuery(query);
	int count = 0;
	while (rs.next()) {
		count++;
		recentNames.add(rs.getString("name"));
		recentTimes.add(rs.getTimestamp("time"));
		recentIDs.add(rs.getInt("zID"));
		if (count == 5)
			break;
	}
	Statement statementTwo = Database.getStatement(con);
	Vector<String> popularNames = new Vector<String>();
	Vector<Integer> popularID = new Vector<Integer>();
	Vector<Integer> popularCounts = new Vector<Integer>();
	query = "Select zID,count(*) as Count From scores Group By zID Order By Count DESC";
	rs = statement.executeQuery(query);
	count = 0;
	while (rs.next()) {
		count++;
		int z = rs.getInt("zID");
		popularID.add(z);
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
	Database.closeConnections(statementTwo);
%>
<br>
<table class="border">
	<tr>
		<th class="border">Quiz Name</th>
	</tr>
	<%
		for (int i = 0; i < names.size(); i++) {
	%>
	<tr>
		<td class="border"><a href="<%="QuizIntro?num=" + i%>"><%=names.get(i)%></a></td>
	</tr>
	<%
		}
	%>
</table>

<br>
<a href="CreateQuizBegin.jsp">Create a Quiz</a>
<br>
<br>

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

<br>
<table class="border">
	<tr><td colspan="2"><b>Recently Created Quizzes</b></td></tr>
	<tr>
		<th class="border"><b>Name</b></th>
		<th class="border"><b>Time Created</b></th>
	</tr>
	<%
		for (int i = 0; i < recentNames.size(); i++) {
	%>
	<tr>
		<td class="border"><a href="QuizIntro?num=<%=recentIDs.get(i)%>"><%=recentNames.get(i)%></a></td>
		<td class="border"><%=recentTimes.get(i)%></td>
	</tr>
	<%
		}
	%>
</table>
<br>


<table class="border">
	<tr><td colspan="4"><b>Popular Quizzes</b></td></tr>
	<tr>
		<th class="border"><b>Name</b></th>
		<th class="border"><b>Attempts</b></th>
	</tr>
	<%
		for (int i = 0; i < popularNames.size(); i++) {
	%>
	<tr>
		<td class="border"><a href="QuizIntro?num=<%=popularID.get(i)%>"><%=popularNames.get(i)%></a></td>
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
		query = "Select zID, score, possible, time, timeTaken from scores where uID=" + uID + " order by time DESC;";

		Vector<Integer> zIDs = new Vector<Integer>();
		Vector<Integer> scores = new Vector<Integer>();
		Vector<Integer> possible = new Vector<Integer>();
		Vector<String> quizNames = new Vector<String>();
		Vector<Timestamp> scoreTimes = new Vector<Timestamp>();
		Vector<Long> timeTaken = new Vector<Long>();

		rs = statement.executeQuery(query);
		while (rs.next()) {
			zIDs.add(rs.getInt("zID"));
			scores.add(rs.getInt("score"));
			possible.add(rs.getInt("possible"));
			scoreTimes.add(rs.getTimestamp("time"));
			timeTaken.add(rs.getLong("timeTaken"));
		}
	
		for(int i=0; i<zIDs.size(); i++){
			query = "Select name from quizzes where zID=" + zIDs.get(i) + ";";
			rs = statement.executeQuery(query);
			rs.next();
			quizNames.add(rs.getString("name"));
		}
%>
	<br>
	<table class="border">
		<tr><td colspan="5"><b>Your Recent Score, <a href="history.jsp">Scores Summary Page</a></b></td></tr>
			<tr class="border">
				<td class="wider, border"><b>Quiz Name</b></td>
				<td class="wider, border"><b>Score</b></td>
				<td class="wider, border"><b>Total</b></td>
				<td class="wider, border"><b>Time</b></td>
				<td class="wider, border"><b>TimeTaken</b></td>
			</tr>
			<%
				int max = zIDs.size() > 6 ? 6 : zIDs.size();
				for (int i = 0; i < max; i++) {
			%>
			<tr class="border">
				<td class="border"><a href="QuizIntro?num=<%=zIDs.get(i)%>"><%=quizNames.get(i)%></a></td>
				<td class="border"><%=scores.get(i)%></td>
				<td class="border"><%=possible.get(i)%></td>
				<td class="border"><%=scoreTimes.get(i)%></td>
				<td class="border"><%=((double)timeTaken.get(i))/1000%></td>
			</tr>
			<%
				}
			%>
	</table>
<%}else{%>
	<h4>Your Recent Scores</h4>
	<p><a href="login.jsp">Login</a></p>
<%}%>

<br>
<table class="border">
<tr><td class="border"><b>Your Achievements</b></td></tr>
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

		
		query = "Select name, time, zID from quizzes where uID=" + uID + " order by time;";
		Statement s = statement;

		Vector<Integer> createID = new Vector<Integer>();
		Vector<String> createNames = new Vector<String>();
		Vector<Timestamp> createTimes = new Vector<Timestamp>();

		rs = s.executeQuery(query);
		while (rs.next()) {
			createID.add(rs.getInt("zID"));
			createNames.add(rs.getString("name"));
			createTimes.add(rs.getTimestamp("time"));
		}
%>

	<br>
	<table class="border">
		<tr><td class="border" colspan="2"><b>Quizzes I've Made</b></td></tr>
		<tr class="border">
			<td class="wider, border"><b>Quiz Name</b></td>
			<td class="wider, border"><b>Time</b></td>
		</tr>
		<%
			for (int i = 0; i < createTimes.size(); i++) {
		%>
		<tr>
			<td class="border"><a href="QuizIntro?num=<%=createID.get(i) %>"><%=createNames.get(i)%></a></td>
			<td class="border"><%=createTimes.get(i)%></td>
		</tr>
		<%
			}
		%>
	</table>
<%}else{%>
	<h4>Quizzes I've Made</h4>
	<a href="login.jsp">Login</a>
<%}%>

<%
// YOUR FRIENDS' SCORES
Vector<Integer> frienduIDs = new Vector<Integer>();
Vector<String> friendNames = new Vector<String>();
Vector<Integer> friendScores = new Vector<Integer>();
Vector<Integer> friendPossible = new Vector<Integer>();
Vector<Double> friendTimes = new Vector<Double>();
Vector<Timestamp> friendDates = new Vector<Timestamp>();
Vector<Integer> friends = new Vector<Integer>();

Object a = session.getAttribute("user");
if(a != null){
int uID = ((User)a).getID();

// get all of friends uIDs
String friendQuery = "Select * from friendships where uID=" + uID + ";";
ResultSet r = statement.executeQuery(friendQuery);
while(r.next()){
	friends.add(r.getInt("friendID"));
}

// query for friend's scores 
for(int i=0; i<friends.size(); i++){
	query = "Select * from scores where uID=" + friends.get(i) + " order by time DESC;";
	rs = statement.executeQuery(query);
	
	
	while(rs.next()){
		int frienduID = rs.getInt("uID");
		frienduIDs.add(frienduID);
		friendScores.add(rs.getInt("score"));
		friendPossible.add(rs.getInt("possible"));
		friendTimes.add(Double.parseDouble((Long.toString(rs.getLong("timeTaken"))))/1000);
		friendDates.add(rs.getTimestamp("time"));
		// query for friends name
	}
	
	for(int x=0; x<frienduIDs.size(); x++){
		query ="select * from users where uID=" + frienduIDs.get(x) + ";";
		ResultSet result = statement.executeQuery(query);
		if(result.next()){
			friendNames.add(result.getString("username"));
		}else{
			friendNames.add("Former User");
		}
	}	
}
%>
<br>
<table class="border">
<tr><td  class="border" colspan="5"><b>Your Friends' Scores</b></td></tr>
<tr><td  class="border"><b>User</b></td><td  class="border"><b>Score</b></td><td  class="border"><b>Possible</b></td><td  class="border"><b>Time</b></td><td  class="border"><b>Date</b></td></tr>
<%
int friendSize = friendScores.size() > 6 ? 6 : friendScores.size();
for(int i=0; i<friendSize; i++){ %>
<tr><td  class="border"><a href="user?uid=<%=frienduIDs.get(i)%>"><%= friendNames.get(i)%></a></td><td  class="border"><%=friendScores.get(i)%></td>
<td  class="border"><%=friendPossible.get(i)%></td><td  class="border"><%=friendTimes.get(i)%></td><td  class="border"><%=friendDates.get(i)%></td></tr>
<%} 
}%>
</table>



<% Database.closeConnections(con, statement); %>
<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>