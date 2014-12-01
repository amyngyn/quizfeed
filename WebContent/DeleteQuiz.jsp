
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="quiz.Quiz"%>
<%@page import="quiz.Constants"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Quiz</title>
<style>
table,td {
	border: 1px solid black;
	border-collapse: collapse;
}
</style>

</head>
<body>
	<%%>

	<h1>Delete Quiz</h1>
	<p>
		<a href="<%=Constants.INDEX%>">Home</a>
	</p>

	<form action="DeleteQuiz" method="post">
		ID: <input type="text" name="zID"><input type="submit"
			value="Delete">
	</form>

	<table>
		<tr>
			<td><b>ID</b></td>
			<td><b>Name</b></td>
			<td><b>Description</b></td>
		</tr>
		<%
			ArrayList<Quiz> quizzes = Quiz.getQuizzes();
			for (int i = 0; i < quizzes.size(); i++) {
				Quiz quiz = quizzes.get(i);
		%>
		<tr>
			<td><%=quiz.getID()%></td>
			<td><%=quiz.getName()%></td>
			<td><%=quiz.getDescription()%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>