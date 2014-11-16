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
</head>
<body>

<p><b>Quiz Name</b></p>

<% 
Vector<String> names = new Vector<String>();

Statement statement = Database.statement;
String query = "Select name From quizzes";
ResultSet rs = statement.executeQuery(query);
while(rs.next()){
	names.add(rs.getString("name"));
}
%>

<% for(int i=0; i<names.size(); i++){
	%>
<p><a href="<%="QuizIntro?num=" + i%>"><%=names.get(i)%></a></p>
<%} %>

<p><a href="CreateQuizBegin.html">Create a New Quiz</a></p>

</body>
</html>