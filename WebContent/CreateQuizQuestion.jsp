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
<%if(type == 1){ %>
	<p>Text Response</p>
	<p>Question: <input type="text" name="question"></p>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>
<%if(type == 2){ %>
	<p>Fill in the Blank</p>
	<p>Question: <input type="text" name="question"></p>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>
<%if(type == 3){ %>
	<p>Multiple Choice</p>
	<p>Question: <input type="text" name="question"></p>
	<p>Option 1: <input type="text" name="answer1"></p>
	<p>Option 2: <input type="text" name="answer2"></p>
	<p>Option 3: <input type="text" name="answer3"></p>
	<p>Option 4: <input type="text" name="answer4"></p>
	<p>Correct Option Number: <input type="radio" name="correctAnswer" value="1" checked>1
		<input type="radio" name="correctAnswer" value="2">2
		<input type="radio" name="correctAnswer" value="3">3
		<input type="radio" name="correctAnswer" value="4">4
	</p>
<%} %>
<%if(type == 4){ %>
	<p>Picture</p>
	<p>Photo Url: <input type="text" name="question"></p>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>
<%if(type == 5){ %>
	<p>Question: <input type="text" name="question"></p>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>
<%if(type == 6){ %>
	<p>Question: <input type="text" name="question"></p>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>
<%if (type == 7){ %>
	<p>Question: <input type="text" name="question"></p>
	<p>Answer: <input type="text" name="answer"></p>
<%} %>

<input type="radio" name="status" value="continue"checked>Make Another Question
<input type="radio" name="status" value="finish">Finish the Quiz!
<input type="submit" value="Submit">
</form>

</body>
</html>