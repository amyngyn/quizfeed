<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.Constants"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="java.util.*"%>
<%@ page import="quiz.Constants"%>
<%@ page import="quiz.TimeFormat"%>
<%@ page import="quiz.User"%>
<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Home" name="title" />
</jsp:include>

<style>
input#input {
	width: 300px;
}
</style>


	<h1>Administrative Page</h1>

	<p>Add an announcement:
	<form action="AdminAnnouncement" method="post">
		<input type="text" id="input" name="announcement"> <input
			type="submit" name="Post">
	</form>
	
	
	<%
	Connection con = null;
	Statement statement = null;
	try {
		con = Database.openConnection();
		statement = Database.getStatement(con);
	} catch (SQLException e) {
		e.printStackTrace();
		return;
	}
		
	String query = "Select uID, username from users";
	ResultSet rs = statement.executeQuery(query);
	Vector<String> everyone = new Vector<String>();
	Vector<Integer> uIDs = new Vector<Integer>();
	while(rs.next()){
		everyone.add(rs.getString("username"));
		uIDs.add(rs.getInt("uID"));
	}
	%>
	
	<p>Add an administrator:
	<form action="AdminNew" method="post">
		<select name="newAdmin">
		<%for(int i=0; i<everyone.size(); i++){ %>
 	 		<option value="<%=uIDs.get(i)%>"><%=everyone.get(i) %></option>
 	 	<%} %>
		</select>
		<input type="submit" name="Post">
	</form>

	
	<%
	
	query = "Select uID from administrators";
	rs = statement.executeQuery(query);
	uIDs = new Vector<Integer>();
	while(rs.next()){
		uIDs.add(rs.getInt("uID"));
	}
	
	Vector<String> names = new Vector<String>();
	for(int i=0; i<uIDs.size(); i++){
		int uID = uIDs.get(i);
		query = "Select username from users where uID=" + uID + ";";
		rs = statement.executeQuery(query);
		if(!rs.next()){
			names.add("Former User");
		}else{
			names.add(rs.getString("username"));
		}
		
	}
	%>
	
	<p>Remove an administrator:
	<form action="AdminRemove" method="post">
		<select name="removeAdmin">
		<%for(int i=0; i<names.size(); i++){ %>
 	 		<option value="<%=uIDs.get(i)%>"><%=names.get(i) %></option>
 	 	<%} %>
		</select>
		<input type="submit" name="Post">
	</form>

	
	
	
	




	<p>
		<a href="DeleteQuiz.jsp">Delete Quiz</a>
	</p>
	<p>
		<a href="<%=Constants.INDEX%>">Home</a>
	</p>

	<% Database.closeConnections(con, statement, rs); %>

<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>