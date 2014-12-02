<%@ page import="quiz.*"%>
<%@ page import="java.util.*"%>
<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Home" name="title" />
</jsp:include>

<%
	User user = (User) session.getAttribute("user");
	HashMap<Integer, User> friendRequests = user.getFriendRequests();
	if (user == null) {
%>
<h1>You must be logged in to view this page!</h1>
<%
	} else {
%>
<h1>Messages</h1>
TODO: Implement!

<h1>Friend Requests</h1>
<%
	if (friendRequests.isEmpty()) {
%>
No one wants to be your friend right now.
<%
	} else {
%>
<ul>
	<%
		for (Integer requesterID : friendRequests.keySet()) {
	%>
	<li><a href="user?uid=<%=requesterID%>"><%=friendRequests.get(requesterID).getUsername()%></a>
		- <a
		href="request?request=<%=Constants.ACCEPT_REQUEST%>&friendid=<%=requesterID%>">Accept</a>
		| <a
		href="request?request=<%=Constants.REJECT_REQUEST%>&friendid=<%=requesterID%>">Reject</a></li>
	<%
		}
	%>
</ul>
<%
	}
	}
%>
<jsp:include page="<%=Constants.FOOTER_FILE%>" />