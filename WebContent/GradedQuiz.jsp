<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.ArrayList"%>
<%@ page import="quiz.Quiz" %>

<%@ page import="java.util.*" %>   
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database" %>
<%@ page import="java.util.Date" %>
<%@ page import="quiz.User" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Quiz Score</title>
<style>
	table, td, tr {
	 	border: 1px solid black;
    	border-collapse: collapse;
	}
</style>
</head>
<body>
	<%
	
	User user = (User) session.getAttribute("user");
	if(user == null){
		String redirectURL = "login.jsp";
		response.sendRedirect(redirectURL);
	}
	
	Double timeTaken = Double.parseDouble((String)session.getAttribute("timeTaken"));
	timeTaken = timeTaken/1000;
	%>

	<p>
	Your Score: <%= request.getAttribute("score") %>
	<br>
	Total Points Possible: <%= request.getAttribute("possible") %>
	<br>
	Time Taken: <%=timeTaken %>
	</p>
	<form action="index.jsp" method="post">
		<input type="submit" value="Back to Homepage">
	</form>
	
	
	<% ArrayList<Object> allInput = (ArrayList<Object>)session.getAttribute("allInput"); %>
	<% Integer zID = (Integer)session.getAttribute("zID");
	Quiz q = new Quiz(zID);
	int count = q.getQuestionCount();
	for(int i=0; i<count; i++){
		String answers = q.getAnswersString(i);
		
		Object inputs = allInput.get(i);
		int type = q.getQuestionType(i);
		if(type ==1 || type ==2 || type ==3 || type ==4){%>
			</p><%=(i+1) + ". " + (String)inputs %><br>
			<%="<b>Correct Answers:</b> " +  answers %></p>
			
		<%}else{
			ArrayList<String> inputsArr = (ArrayList<String>)allInput.get(i);
			String inputsStr = "";
			for(int j=0; j<inputsArr.size(); j++){
				inputsStr += inputsArr.get(j);
				if(j != inputsArr.size() - 1) inputsStr += ", ";
			}%>
			</p><%=(i+1) + ". " + (String)inputsStr %><br>
			<%="<b>Correct Answers:</b> " +  answers %></p>
		<%
		}
	}
	%>
	
<%
Connection con = Database.openConnection();
Statement s = Database.getStatement(con);
%>

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
	String qu = "Select username from users where uID=" + uIDs.get(i) + ";";
	rs = s.executeQuery(qu);
	if(rs.next()){
		usernames.add(rs.getString("username"));
	}else{
		usernames.add("Deleted User");	
	}
}
int size = uIDs.size();
int number = size > 5 ? 5: size;
for(int i=0; i<number; i++){ %>
<tr><td><%= usernames.get(i)%></td><td><%=scores.get(i)%></td>
<td><%=total.get(i)%></td><td><%=highPace.get(i)%></td><td><%=highTimes.get(i)%></td></tr>
<%} %>
</table>
<br>

<%
// Your friends' scores 
Vector<Integer> frienduIDs = new Vector<Integer>();
Vector<String> friendNames = new Vector<String>();
Vector<Integer> friendScores = new Vector<Integer>();
Vector<Integer> friendPossible = new Vector<Integer>();
Vector<Double> friendTimes = new Vector<Double>();
Vector<Timestamp> friendDates = new Vector<Timestamp>();

Vector<Integer> friends = new Vector<Integer>();
int uID = user.getID();

// get all of friends uIDs
String friendQuery = "Select * from friendships where uID=" + uID + ";";
ResultSet r = s.executeQuery(friendQuery);
while(r.next()){
	friends.add(r.getInt("friendID"));
}

// query for friend's scores 
for(int i=0; i<friends.size(); i++){
	query = "Select * from scores where uID=" + friends.get(i) + " and zID="+(Integer)session.getAttribute("zID")+" order by score DESC;";
	rs = s.executeQuery(query);
	while(rs.next()){
		int frienduID = friends.get(i);
		// only get a friends best score
		if(!frienduIDs.contains(frienduID)){
			frienduIDs.add(frienduID);
			friendScores.add(rs.getInt("score"));
			friendPossible.add(rs.getInt("possible"));
			friendTimes.add(Double.parseDouble((Long.toString(rs.getLong("timeTaken"))))/1000);
			friendDates.add(rs.getTimestamp("time"));
			// query for friends name
			query ="select * from users where uID=" + frienduID + ";";
			rs = s.executeQuery(query);
			if(rs.next()){
				friendNames.add(rs.getString("username"));
			}else{
				friendNames.add("Deleted User");
			}
		}
	}
}
%>
<table>
<tr><td colspan="5"><b>Your Friends' Scores</b></td></tr>
<tr><td><b>User</b></td><td><b>Score</b></td><td><b>Possible</b></td><td><b>Time</b></td><td><b>Date</b></td></tr>
<%for(int i=0; i<friendScores.size(); i++){ %>
<tr><td><%= friendNames.get(i)%></td><td><%=friendScores.get(i)%></td>
<td><%=friendPossible.get(i)%></td><td><%=friendTimes.get(i)%></td><td><%=friendDates.get(i)%></td></tr>
<%} %>

</table>






</body>
</html>






