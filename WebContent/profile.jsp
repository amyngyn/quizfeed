<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="quiz.User"%>
<%@ page import="quiz.Constants"%>
<%
	User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<title><%=user.getUsername()%> - <%=Constants.QUIZ_SITE_TITLE%></title>
</head>
<body>
	<jsp:include page="<%=Constants.HEADER_FILE%>" />
	<h1><%=user.getUsername()%></h1>
</body>
</html>