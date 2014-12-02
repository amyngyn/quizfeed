<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.User"%>
<%@ page import="quiz.Constants"%>
<%@ page import="java.util.*"%>
<%
	User user = (User) request.getAttribute("user");
	String username = user.getUsername();
	ArrayList<User> friends = user.getFriends();
	ArrayList<User> friendRequests = user.getFriendRequests();
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
		<jsp:param value="<%=user.getUsername()%>" name="title" />
	</jsp:include>
	<h1><%=username%></h1>
	<h2>Friends</h2>
	<%
		if (friends.isEmpty()) {
	%>
	<p><%=username%>
		doesn't have friends.
	</p>
	<%
		} else {
	%>
	<ul>
		<%
			for (User f : friends) {
		%>
		<li><a href="user?uid=<%=f.getID()%>"><%=f.getUsername()%></a></li>
		<%
			}
		%>
	</ul>
	<%
		}
	%>

	<h2>Friend Requests</h2>
	<%
		if (friendRequests.isEmpty()) {
	%>
	<p><%=username%>
		doesn't have friend requests.
	</p>
	<%
		} else {
	%>
	<ul>
		<%
			for (User f : friendRequests) {
		%>
		<li><a href="user?uid=<%=f.getID()%>"><%=f.getUsername()%></a></li>
		<%
			}
		%>
	</ul>
	<%
		}
	%>

</body>
</html>