<%@page import="quiz.Constants"%>
<%@page import="quiz.User"%>
<div>
	<div style="margin-top: 50px;">
		<a class="header-title" href="<%=Constants.INDEX%>">QuizFeed</a>
	</div>
</div>
<div class="navbar">
	<a class="nav-link" style="left: 220px;" href="#">Quizzes</a>
	<%
		User user = (User) session.getAttribute("user");
		if (user == null) {
	%>
	<a class="nav-link" style="right: 370px;" href="login">Login</a> <a
		class="nav-link" style="right: 275px;" href="signup">Sign Up</a>
	<%
		} else {
	%>
	<a class="nav-link" style="right: 275px;" href="logout">Logout</a>
	<%
		}
	%>
</div>