<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.User"%>
<%@ page import="quiz.Constants"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="quiz.Constants"%>
<%@ page import="quiz.TimeFormat"%>
<%@ page import="quiz.User"%>
<%
	User userToDisplay = (User) request.getAttribute("user");
	if (userToDisplay == null) {
		throw new IllegalAccessError(
				"Shouldn't be able to access profile without having a user set.");
	}
	String username = userToDisplay.getUsername();
	HashMap<Integer, User> friendsToDisplay = userToDisplay
			.getFriends();
%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="<%=userToDisplay.getUsername()%>" name="title" />
</jsp:include>
<h1><%=username%></h1>
<%
		User loggedInUser = (User) session.getAttribute("user");

		if (loggedInUser != null) {
			
			// If you are viewing someone else's profile
			if (loggedInUser.getID() != userToDisplay.getID()) {

				HashMap<Integer, User> existingFriends = loggedInUser
						.getFriends();
				HashMap<Integer, User> existingRequests = loggedInUser
						.getFriendRequests();
				HashMap<Integer, User> displayRequests = userToDisplay
						.getFriendRequests();
				
				// If you are viewing the profile of someone who has already friend requested you
				if (existingRequests.containsKey(userToDisplay.getID())) {
	%>
<a
	href="request?request=<%=Constants.ACCEPT_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
	Accept Friend Request </a>

<%
				// If you are already friends with this person
				} else if (existingFriends.containsKey(userToDisplay.getID())) {
				%>
<a
	href="request?request=<%=Constants.DELETE_FRIEND_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
	Delete Friend </a>

<%
				// If you don't already have a request waiting for this user.
				} else if (!displayRequests.containsKey(loggedInUser.getID())) {
	%>
<a
	href="request?request=<%=Constants.SEND_REQUEST%>&friendid=<%=userToDisplay.getID()%>">
	Add Friend </a>
<%
		}
			}
		}
	%>

<h2>Friends</h2>
<%
		if (friendsToDisplay.isEmpty()) {
	%>
<p><%=username%>
	doesn't have friends.
</p>
<%
		} else {
	%>
<ul>
	<%
			for (Integer fID : friendsToDisplay.keySet()) {
		%>
	<li><a href="user?uid=<%=fID%>"><%=friendsToDisplay.get(fID).getUsername()%></a></li>
	<%
			}
		%>

</ul>
<%
		}
	%>

<%
Connection con = Database.openConnection();
Statement statement = Database.getStatement(con);

Vector<Integer> friendScores = new Vector<Integer>();
Vector<Integer> friendPossible = new Vector<Integer>();
Vector<Double> friendTimes = new Vector<Double>();
Vector<Timestamp> friendDates = new Vector<Timestamp>();
Vector<Integer> friendzIDs = new Vector<Integer>();
Vector<String> friendQNames = new Vector<String>();

// query for friend's scores 

	String query = "Select max(score) as score, zID, possible, time, timeTaken from scores where uID=" + userToDisplay.getID() + " group by zID order by time DESC;";
	ResultSet rs = statement.executeQuery(query);
	
	while(rs.next()){
		friendScores.add(rs.getInt("score"));
		friendPossible.add(rs.getInt("possible"));
		friendTimes.add(Double.parseDouble((Long.toString(rs.getLong("timeTaken"))))/1000);
		friendDates.add(rs.getTimestamp("time"));
		friendzIDs.add(rs.getInt("zID"));
		// query for friends name
	}

for(int x=0; x<friendzIDs.size(); x++){
	query ="select * from quizzes where zID=" + friendzIDs.get(x) + ";";
	ResultSet result = statement.executeQuery(query);
	if(result.next()){
		friendQNames.add(result.getString("name"));
	}else{
		friendQNames.add("Deleted Quiz");
	}
}	
%>
<br>
<table class="border">
<tr><td  class="border" colspan="5"><b>Best Scores By Quiz</b></td></tr>
<tr><td  class="border"><b>Quiz</b></td><td  class="border"><b>Score</b></td><td  class="border"><b>Possible</b></td><td  class="border"><b>Time</b></td><td  class="border"><b>Date</b></td></tr>
<%

for(int i=0; i<friendScores.size(); i++){ %>
<tr>
	<td  class="border"><a href="QuizIntro?num=<%=friendzIDs.get(i)%>"><%= friendQNames.get(i)%></a></td>
	<td  class="border"><%=friendScores.get(i)%></td>
	<td  class="border"><%=friendPossible.get(i)%></td>
	<td  class="border"><%=friendTimes.get(i)%></td>
	<td  class="border"><%=friendDates.get(i)%></td></tr>
<%} 
%>
</table>
	
	
	
	
	
<jsp:include page="<%=Constants.FOOTER_FILE%>" />