<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.*" %>   
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<style>
	table, td, tr {
	 	border: 1px solid black;
    	border-collapse: collapse;
	}
</style>

<body>

<%
int zID = (Integer)request.getAttribute("zID");
String name = (String)request.getAttribute("name");
String description = (String)request.getAttribute("description");
int uID = (Integer)request.getAttribute("uID");
Timestamp time = (Timestamp)request.getAttribute("time");


Vector<Integer> uIDs = new Vector<Integer>();
Vector<Integer> scores = new Vector<Integer>();
Vector<Integer> total = new Vector<Integer>();
Database db = new Database();
Statement s = db.statement;
String query = "Select * from scores where zID = " + zID + " order by score ASC;";
ResultSet rs = s.executeQuery(query);
while(rs.next()){
	uIDs.add(rs.getInt("uID"));
	scores.add(rs.getInt("score"));
	total.add(rs.getInt("possible"));
}

%>


<p><b>Quiz ID: </b> <%=zID %></p>
<p><b>Quiz Name: </b> <%=name %></p>
<p><b>Quiz Description: </b> <%= description %></p>
<p><b>Quiz Creator: </b> <%=uID %></p>
<p><b>Quiz Time Created: </b> <%=time %></p>

<form action="GetQuiz">
<input type="hidden" name="num" value="<%=zID %>">
<input type="submit" value="Begin">
</form>
<br>
<table>
<tr><td colspan="3"><b>High Scores</b></td></tr>
<tr><td><b>User</b></td><td><b>Score</b></td><td><b>Possible</b></td></tr>
<%

int size = uIDs.size();
int count = size > 5 ? 5: size;

for(int i=0; i<count; i++){ %>
<tr><td><%= uIDs.get(i)%></td><td><%=scores.get(i)%></td><td><%=total.get(i)%></td></tr>
<%} %>
</table>


</body>
</html>