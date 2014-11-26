<%@page import="quiz.QuizConstants"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Quiz</title>
<style>
	table, td {	border: 1px solid black;
	  			border-collapse: collapse;}
</style>

</head>
<body>
<%
Vector<String> quizzes = new Vector<String>();
Vector<String> descriptions = new Vector<String>();
Vector<Integer> zIDs = new Vector<Integer>();

Database db = new Database();
Statement statement = db.statement;

String query = "Select zID, name, description From quizzes Order by zID;";
ResultSet rs = statement.executeQuery(query);
while(rs.next()){
	quizzes.add(rs.getString("name"));
	descriptions.add(rs.getString("description"));
	zIDs.add(rs.getInt("zID"));
}
%>

<h1>Delete Quiz</h1>
<p><a href="<%= QuizConstants.INDEX_FILE %>">Home</a></p>

<form action="DeleteQuiz" method="post">
ID: <input type="text" name="zID"><input type="submit" value="Delete">
</form>

<table>
<tr>
	<td><b>ID</b></td>
	<td><b>Name</b></td>
	<td><b>Description</b></td>
</tr>
<%for(int i=0; i<quizzes.size(); i++){ %>
<tr>
<td><%=zIDs.get(i) %></td>
<td><%=quizzes.get(i)%></td>
<td><%=descriptions.get(i)%></td>
</tr>
<%} %>


</table>




</body>
</html>