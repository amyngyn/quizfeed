<%@ page import="quiz.Constants"%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Login" name="title" />
</jsp:include>
<%
		String message = (String) request.getAttribute("error");
		if (message != null) {
	%>
<p>
	<%=message%>
</p>
<%
		}
	%>


<form action="login" method="post">
	<p>
		Username: <input type="text" name="username">
	</p>
	<p>
		Password: <input type="password" name="password">
	</p>
	<p>
		<input type="submit" name="Enter">
	</p>
</form>

<p>
	<a href="LoginCreate.jsp">Create Username</a>
</p>

<jsp:include page="<%=Constants.FOOTER_FILE%>" />