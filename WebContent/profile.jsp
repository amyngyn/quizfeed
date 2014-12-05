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
<%
	ArrayList<String> achievements = userToDisplay.getAchievements();
	if (achievements.isEmpty()) {
%>
You have no achievements!
<%
	} else {
%>
<ol>
	<%
		for (String achievement : achievements) {
	%>
	<li><%=achievement%></li>
</ol>
<%
		}
%>
<%
	}
%>
<jsp:include page="<%=Constants.FOOTER_FILE%>" />
