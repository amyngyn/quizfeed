<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Time" %>    
<%@ page import="java.util.*" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
int zID = (Integer)request.getAttribute("zID");
String name = (String)request.getAttribute("name");
String description = (String)request.getAttribute("description");
int uID = (Integer)request.getAttribute("uID");
Date date = (Date)request.getAttribute("time");
%>
<p><b>Quiz ID: </b> <%=zID %></p>
<p><b>Quiz Name: </b> <%=name %></p>
<p><b>Quiz Description: </b> <%= description %></p>
<p><b>Quiz Creator: </b> <%=uID %></p>
<p><b>Quiz Time Created: </b> <%=date %></p>

<form action="GetQuiz">
<input type="hidden" name="num" value="<%=zID %>">
<input type="submit" value="Begin">
</form>


</body>
</html>