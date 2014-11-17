<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create User Name</title>
</head>
<body>

<% String message = (String)getServletContext().getAttribute("message");
if(message != null){ %>
<p> <%= message %> </p>
<%}%>

<form action="LoginCreate" method="post">
<p>Username: <input type="text" name="username"></p>
<p>Password: <input type="password" name="password"></p>
<p><input type="submit" name="Submit"></p>
</form>

<p><a href="Start.jsp">Home</a></p>

</body>
</html>