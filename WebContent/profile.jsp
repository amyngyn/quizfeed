<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.User"%>
<%@ page import="quiz.Constants"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="quiz.Constants"%>
<%@ page import="quiz.TimeFormat"%>
<%@ page import="quiz.User"%>
<%
	User userToDisplay = (User) request.getAttribute("user");
	if (userToDisplay == null) {
		throw new IllegalAccessError(
				"Shouldn't be able to access profile without having a user set.");
	}
	String username = userToDisplay.getUsername();
	HashMap<Integer, User> friendsToDisplay = userToDisplay
			.getFriends();
%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="<%=userToDisplay.getUsername()%>" name="title" />
</jsp:include>
<h1><%=username%></h1>
<%
	User loggedInUser = (User) session.getAttribute("user");

	if (loggedInUser != null) {

		// If you are viewing someone else's profile
		if (loggedInUser.getID() != userToDisplay.getID()) {

			HashMap<Integer, User> existingFriends = loggedInUser
					.getFriends();
			HashMap<Integer, User> existingRequests = loggedInUser
					.getFriendRequests();
			HashMap<Integer, User> displayRequests = userToDisplay
					.getFriendRequests();

			// If you are viewing the profile of someone who has already friend requested you
			if (existingRequests.containsKey(userToDisplay.getID())) {
%>
<a
	href="request?request=<%=Constants.ACCEPT_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
	Accept Friend Request </a>

<%
	// If you are already friends with this person
			} else if (existingFriends.containsKey(userToDisplay
					.getID())) {
%>
<a
	href="request?request=<%=Constants.DELETE_FRIEND_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
	Delete Friend </a>

<%
	// If you don't already have a request waiting for this user.
			} else if (!displayRequests.containsKey(loggedInUser
					.getID())) {
%>
<a
	href="request?request=<%=Constants.SEND_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
	Add Friend </a>
<%
	}
		}
	}
%>

<h2>Friends</h2>
<%
	if (friendsToDisplay.isEmpty()) {
%>
<p><%=username%>
	doesn't have friends.
</p>
<%
	} else {
%>
<ul>
	<%
		for (Integer fID : friendsToDisplay.keySet()) {
	%>
	<li><a href="user?uid=<%=fID%>"><%=friendsToDisplay.get(fID).getUsername()%></a></li>
	<%
		}
	%>

</ul>
<%
	}
%>
<h2>Achievements</h2>
<table class="border">
<tr><td class="border"><b>Your Achievements</b></td></tr>
	<%
	{
		Integer uID = userToDisplay.getID();
	Connection con = Database.openConnection();
	Statement statement = Database.getStatement(con);
	ResultSet rs = null;
		if (uID != null) {
			String query = "Select name From achievements Where type = 0 AND uID="
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
		uID = userToDisplay.getID();
		query = "Select name From achievements Where type = 2 AND uID=" + uID + ";";
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
<% } %>
<jsp:include page="<%=Constants.FOOTER_FILE%>" />
