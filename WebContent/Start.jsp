<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database" %>
<%@ page import="java.util.*" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<style>
	td {vertical-align: top}

</style>
</head>


<body>

<%if (getServletContext().getAttribute("userName") == null){ %>
<p><a href="Login.html"><b>Login</b></a></p>
<%}else{ %>
<p>Hi, <%= getServletContext().getAttribute("userName") %>!
	<a href="AdminBegin">Admin Page</a>
	<a href="Logout">Log Out</a>

<form action="UserSearch" method="post">
User Search: <input type="text" name="username">
<input type="submit" name="Search">
</form>
</p>


<%}%>

<% 
Vector<String> names = new Vector<String>();

Statement statement = Database.statement;
String query = "Select name From quizzes";
ResultSet rs = statement.executeQuery(query);
while(rs.next()){
	names.add(rs.getString("name"));
}

Vector<String> announcements = new Vector<String>();

query = "Select announcement From announcements";
rs = statement.executeQuery(query);
while(rs.next()){
	announcements.add(rs.getString("announcement"));
}
%>

<table>
<tr>
<td>
<p><b>Quiz Name</b></p>
<% for(int i=0; i<names.size(); i++){
	%>
<p><a href="<%="QuizIntro?num=" + i%>"><%=names.get(i)%></a></p>
<%} %>
<p><a href="CreateQuizBegin.html">Create a New Quiz</a></p>
</td>
<td>
<p><b>Announcements</b></p>
<% for(int i=0; i<announcements.size(); i++){
	%>
<p><%=(i+1) + ". "%><%=announcements.get(i)%></p>
<%} %>
</td>
</tr>
</table>
</body>
</html>