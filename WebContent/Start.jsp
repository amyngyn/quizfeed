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
	.border {
		border: 1px solid black;
	  	border-collapse: collapse;
	}
</style>
</head>


<body>

<%if (getServletContext().getAttribute("userName") == null){ %>
<p><a href="Login.html"><b>Login</b></a></p>
<%}else{ %>
<p>Hi, <%= getServletContext().getAttribute("userName") %>!
	<a href="UserHome.jsp">My Page</a>
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

Database db = new Database();
Statement statement = db.statement;
String query = "Select name From quizzes";
ResultSet rs = statement.executeQuery(query);
while(rs.next()){
	names.add(rs.getString("name"));
}

Vector<String> announcements = new Vector<String>();
Vector<String> times = new Vector<String>();
query = "Select announcement, time From announcements";
rs = statement.executeQuery(query);
while(rs.next()){
	announcements.add(rs.getString("announcement"));
	times.add(rs.getString("time"));
}

Vector<String> recentNames = new Vector<String>();
Vector<Timestamp> recentTimes = new Vector<Timestamp>();
query = "Select name, time From quizzes Order By time ASC";
rs = statement.executeQuery(query);
int count = 0;
while(rs.next()){
	count++;
	recentNames.add(rs.getString("name"));
	recentTimes.add(rs.getTimestamp("time"));
	if(count == 5) break;
}

Database d = new Database();
Statement statementTwo = d.statement;
Vector<String> popularNames = new Vector<String>();
Vector<Integer> popularCounts = new Vector<Integer>();
query = "Select zID,count(*) as Count From scores Group By zID Order By Count DESC";
rs = statement.executeQuery(query);
count = 0;
while(rs.next()){
	count++;
	int z = rs.getInt("zID");
	String queryTwo = "Select name From quizzes Where zID =" + z + ";";
	ResultSet rsTwo = statementTwo.executeQuery(queryTwo);
	rsTwo.next();
	String name = rsTwo.getString("name");
	popularNames.add(name);
	popularCounts.add(rs.getInt("Count"));
	if(count == 5) break;
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
<p><%=(i+1) + ". "%><%=announcements.get(i) + " at " + times.get(i) %></p>
<%} %>
</td>
</tr>
<tr>
<td>
<b>Recent Quizzes</b>
<table class="border">
<tr><td class ="border"><b>Name</b></td><td class="border"><b>Time Created</b></td></tr>
<%for(int i=0; i<recentNames.size(); i++){ %>
<tr><td class="border"><%=recentNames.get(i) %></td><td class="border"><%=recentTimes.get(i) %></td></tr>
<%}%>
</table>
</td>
<td>
<b>Popular Quizzes</b>
<table class="border">
<tr><td class ="border"><b>Name</b></td><td class="border"><b>Attempts</b></td></tr>
<%for(int i=0; i<popularNames.size(); i++){ %>
<tr><td class="border"><%=popularNames.get(i) %></td><td class="border"><%=popularCounts.get(i) %></td></tr>
<%}%>
</table>
</td>
</tr>
</table>
</body>
</html>