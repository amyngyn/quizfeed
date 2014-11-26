<%@ page import="quiz.QuizConstants"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>
<body>
	<jsp:include page="<%=QuizConstants.HEADER_FILE%>" />

	<%
		String message = (String) getServletContext().getAttribute("error");
		if (message != null) {
	%>
	<p>
		<%=message%>
	</p>
	<%
		}
	%>


	<form action="Login" method="post">
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
</body>
</html>