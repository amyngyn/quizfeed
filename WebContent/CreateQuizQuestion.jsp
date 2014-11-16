<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% int zID = (Integer)request.getSession().getAttribute("quizNumber"); %>
<% int type = (Integer)request.getSession().getAttribute("type"); %>

<form action="CreateQuiz3" method="post">
<p>Question: <input type="text" name="question"></p>

<%if(type ==1){ %>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>


</form>

</body>
</html>