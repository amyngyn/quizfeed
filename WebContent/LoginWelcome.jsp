<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<body>

<p>Hi, <%= getServletContext().getAttribute("userName") %>!</p>
<p>uID: <%= getServletContext().getAttribute("uID") %></p>

<p><a href="Start.jsp">Quizzes</a></p>
</body>
</html>