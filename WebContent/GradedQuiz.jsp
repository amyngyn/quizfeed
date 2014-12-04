<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.ArrayList"%>
<%@ page import="quiz.Quiz" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Quiz Score</title>
</head>
<body>

	Your Score: <%= request.getAttribute("score") %>
	<br>
	Total Points Possible: <%= request.getAttribute("possible") %>
	<br>
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


</body>
</html>