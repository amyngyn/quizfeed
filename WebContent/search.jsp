<%@ page import="java.util.*"%>
<%@ page import="quiz.*"%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Search Results" name="title" />
</jsp:include>

<%
	ArrayList<User> users = (ArrayList<User>) request
			.getAttribute("users");
	if (users != null && !users.isEmpty()) {
%>
<h1>Users</h1>
<ul>
	<%
		for (User user : users) {
	%>
	<li><a href="user?uid=<%=user.getUID()%>"><%=user.getUsername()%></a></li>
	<%
		}
		}
	%>
</ul>
<h1>Quizzes</h1>
<p>No quizzes found. (WARNING: THIS IS NOT IMPLEMENTED!)</p>

<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>