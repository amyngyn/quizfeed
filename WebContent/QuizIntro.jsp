<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.*" %>   
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database" %>
<%@ page import="java.util.Date" %>
<%@ page import="quiz.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quiz Time</title>
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
<tr><td colspan="5"><b>High Scores</b></td></tr>
<tr><td><b>User</b></td><td><b>Score</b></td><td><b>Possible</b></td><td><b>Time</b></td><td><b>Date</b></td></tr>
<%
ArrayList<Integer> uIDs = new ArrayList<Integer>();
ArrayList<String> usernames = new ArrayList<String>();
ArrayList<Integer> scores = new ArrayList<Integer>();
ArrayList<Integer> total = new ArrayList<Integer>();
ArrayList<Timestamp> highTimes = new ArrayList<Timestamp>();
ArrayList<Double> highPace = new ArrayList<Double>();

Connection con = Database.openConnection();
Statement s = Database.getStatement(con);
String query = "Select * from scores where zID = " + zID + " order by score DESC;";
ResultSet rs = s.executeQuery(query);
while(rs.next()){
	uIDs.add(rs.getInt("uID"));
	scores.add(rs.getInt("score"));
	total.add(rs.getInt("possible"));
	highTimes.add(rs.getTimestamp("time"));
	highPace.add(((double)rs.getLong("timeTaken"))/1000);
}

for(int i=0; i<uIDs.size(); i++){
	String q = "Select username from users where uID=" + uIDs.get(i) + ";";
	rs = s.executeQuery(q);
	if(rs.next()){
		usernames.add(rs.getString("username"));
	}else{
		usernames.add("Deleted User");	
	}
}

int size = uIDs.size();
int count = size > 5 ? 5: size;

for(int i=0; i<count; i++){ %>
<tr><td><%= usernames.get(i)%></td><td><%=scores.get(i)%></td>
<td><%=total.get(i)%></td><td><%=highPace.get(i)%></td><td><%=highTimes.get(i)%></td></tr>
<%} %>
</table>
<br>


<table>
<tr><td colspan="4"><b>Your Past Performances</b></td></tr>
<tr><td><b>Score</b></td><td><b>Possible</b></td><td><b>Time</b></td><td><b>Date</b></td></tr>
<%
Object o = session.getAttribute("user");
if(o != null){
User user = (User)o;
Integer youruID = user.getID();

Vector<Integer> yourScores = new Vector<Integer>();
Vector<Integer> yourTotal = new Vector<Integer>();
Vector<Double> yourPace = new Vector<Double>();
Vector<Timestamp> yourTimes = new Vector<Timestamp>();

String yourQuery = "Select * from scores where uID = " + youruID + " and zID=" + zID + " order by time DESC;";
rs = s.executeQuery(query);
while(rs.next()){
	yourScores.add(rs.getInt("score"));
	yourTotal.add(rs.getInt("possible"));
	yourTimes.add(rs.getTimestamp("time"));
	yourPace.add(((double)rs.getLong("timeTaken"))/1000);
}

for(int i=0; i<yourScores.size(); i++){ %>
<tr><td><%= yourScores.get(i)%></td><td><%=yourTotal.get(i)%></td><td><%=yourPace.get(i)%></td><td><%=yourTimes.get(i)%></td></tr>
<%}}else{ %>
<tr><td><a href="login.jsp">Login</a></td></tr>
<%} %>
</table>

<br>

<table>
<tr><td colspan="5"><b>Top Performers</b></td></tr>
<tr><td><b>User</b></td><td><b>Score</b></td><td><b>Possible</b></td><td><b>Time</b></td><td><b>Date</b></td></tr>
<%
Vector<Integer> topuID = new Vector<Integer>();
Vector<String> topName = new Vector<String>();
Vector<Integer> topScore = new Vector<Integer>();
Vector<Integer> topTotal = new Vector<Integer>();
Vector<Timestamp> topTimes = new Vector<Timestamp>();
Vector<Double> topPace = new Vector<Double>();

String topQuery = "Select uID, max(score) as score, max(possible) as possible, time, timeTaken from scores where zID=" + zID + " group by uID order by score DESC;";
rs = s.executeQuery(topQuery);
while(rs.next()){
	topuID.add(rs.getInt("uID"));
	topScore.add(rs.getInt("score"));
	topTotal.add(rs.getInt("possible"));
	topTimes.add(rs.getTimestamp("time"));
	topPace.add(((double)rs.getLong("timeTaken"))/1000);
}


for(int i=0; i< topuID.size(); i++){
	int u = topuID.get(i);
	topQuery = "Select username from users where uID =" + u  + ";";
	rs = s.executeQuery(topQuery);
	if(rs.next()){
		topName.add(rs.getString("username"));
	}else{
		if(u == -1) topName.add("Anonymous");
		else topName.add("Deleted User");
	}
}
for(int i=0; i<topName.size(); i++){ %>
<tr><td><%= topName.get(i)%></td><td><%= topScore.get(i)%></td><td><%=topTotal.get(i)%></td><td><%=topPace.get(i)%></td><td><%=topTimes.get(i)%></td></tr>
<%}%>
</table>
<br>

<table>
<tr><td colspan="4"><b>Top Scores in Last 15 Mins.</b></td></tr>
<tr><td><b>User</b></td><td><b>Score</b></td><td><b>Possible</b></td><td><b>Time</b></td></tr>
<%
Vector<Boolean> recent = new Vector<Boolean>();
int big = topName.size();

Calendar now = Calendar.getInstance();
now.add(Calendar.MINUTE, -15);

for(int i=0; i<big; i++){
	Timestamp t = topTimes.get(i);
	
	if(t.after(now.getTime())){
		recent.add(true);
	}else{
		recent.add(false);
	}
}

for(int i=0; i<topName.size(); i++){
	if(recent.get(i)){%>
<tr><td><%= topName.get(i)%></td><td><%= topScore.get(i)%></td><td><%=topTotal.get(i)%></td><td><%=topTimes.get(i)%></td></tr>
<%}}%>
</table>



</body>
</html>