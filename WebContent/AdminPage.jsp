<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="quiz.QuizConstants" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin</title>
<style>
	input#input { width: 300px; }
</style>
</head>
<body>
<h1>Administrative Page</h1>

<p>Add an announcement:
<form action="AdminAnnouncement" method="post">
<input type="text" id="input" name="announcement">
<input type="submit" name="Post">
</form>

<p><a href="DeleteQuiz.jsp">Delete Quiz</a></p>
<p><a href="<%= QuizConstants.INDEX_FILE %>">Home</a></p>
</body>
</html>