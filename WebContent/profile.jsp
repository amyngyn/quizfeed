<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.User"%>
<%@ page import="quiz.Constants"%>
<%@ page import="java.util.*"%>
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<title><%=username%> - <%=Constants.QUIZ_SITE_TITLE%></title>
</head>
<body>
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
				} else if (existingFriends.containsKey(userToDisplay.getID())) {
				%>
	<a
		href="request?request=<%=Constants.DELETE_FRIEND_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
		Delete Friend </a>
		
	<%
				// If you don't already have a request waiting for this user.
				} else if (!displayRequests.containsKey(loggedInUser.getID())) {
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

</body>
</html>