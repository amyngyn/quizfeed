<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Time" %>    
<%@ page import="java.util.ArrayList" %>    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Quiz Time</title>
</head>
<body>
<% 
ArrayList<String> questions = (ArrayList<String>)request.getAttribute("questions");
ArrayList<Integer> types = (ArrayList<Integer>)request.getAttribute("types");
ArrayList<String> choices = (ArrayList<String>)request.getAttribute("choices");
ArrayList<Integer> choicesTo = (ArrayList<Integer>)request.getAttribute("choicesTo");

int size = questions.size();%>

<form action="GradeQuiz" method="post">

<%for (int i=0; i<size; i++){ %>
	<!-- Question number and name -->
	<p><%= i + 1%>.<br> <%= questions.get(i) %>
	
	<!-- Retrieve type of question, as listed below.
		1 Text Response
		2 Fill in the blank
		3 Multiple choice
		4 Picture response
		5 Multi text response
		6 Multi choice answer
		7 matching 
	-->
	<% int type = types.get(i); %>
	<!-- Question type 1 text response  -->
	<% if(type == 1){ %>
		<input type="text" value="" name="<%=i%>">	
		
	<!-- Question type 2 text fill in the blank -->	
	<%}else if(type == 2){ %>
		<input type="text" value="" name="<%=i%>">
		
	<!-- Question type 3 multiple choice -->			
	<%}else if (type == 3){%>
	
		<!--  Cycle through choices and output ones corresponding to the question -->
		<%int choicesSize = choices.size();
		for (int j=0; j<choicesSize; j++){ 
			if(choicesTo.get(j) == i){%>
			<!-- Output radio button for multiple choice and choice String-->
			<br>
			<input type="radio" name="<%=i %>" value="<%=choices.get(j) %>"><%=choices.get(j)%>
			<% }
		}%>
	<!-- Question type 4 picture response -->	
	<%} else if (type == 4){%>
		<!-- Cycle through choices to find picture URL-->
		<% 
		int choicesSize = choices.size();
		String picture = null;
		for (int j=0; j<choicesSize; j++) if(choicesTo.get(j) == i) picture = choices.get(j);
		%>
		
		<!-- Output picture and blank text box-->
		<img src="<%=picture%>" height="60" width="60">
		<br><input type="text" value="" name="<%=i%>">
		
	<!-- Question type 5 multi text response -->	
	<%} else if (type == 5){%>
	
		<!-- choices contains inputs the number of inputs-->
		<!-- each time a corresponding entry is found in choices, output a text box-->
		<%int choicesSize = choices.size();
		int nameNum = 0;
		for (int j=0; j<choicesSize; j++){ 
			if(choicesTo.get(j) == i){%>
			<br><input type="text" value="" name="<%=i + "-" + nameNum%>">	
				<% nameNum++; %>
		<%	}
		}
		%>
		
	<!-- Question type 6 multi choice response -->
	<%} else if (type ==6){%>
		
		<!-- For each choice, output a checkbox and the name of the choice-->
		<%int choicesSize = choices.size();
			int count = 0;
		for (int j=0; j<choicesSize; j++){ 
			if(choicesTo.get(j) == i){%>
			<br><input type="checkbox" name="<%=i+"-"+count%>" value="<%=choices.get(j)%>"><%=choices.get(j)%>	
		<%	
			count++;
			}
		}
		%>

	<!-- Question type 7 matching -->
	<%} else if (type ==7){%>
		<!-- Count the number of choices for this question
			Find half that value, which is the number of choices with a selection box
			Either output a number or a selection box with each question.
		 -->
		<%
		int choicesSize = choices.size();
		int optionsCount = 0;
		for (int j=0; j<choicesSize; j++) if(choicesTo.get(j) == i) optionsCount++;
		int half = optionsCount / 2;
		int count = 0;
		int nameCount = 0;
		
		for (int j=0; j<choicesSize; j++) {
			if(choicesTo.get(j) == i){
				count++;
				if(count<=half){ %>
					<br><%=count + ". " + choices.get(j) %>	
				<%} else { %>
					<br>
					<select name = "<%=i+"-"+nameCount %>">
						<%for(int x=1; x<=half; x++){ %>
							<option value="<%= x%>"><%=x %></option>
						<%} %>
					</select>
					
					<%=choices.get(j) %>
				<% nameCount++;
				} 
			}
		}
		%>
		
		<%
		}
		%>
		
	 </p>
<%}%>
<input type="submit" value="Submit">
</form>




</body>
</html>