<%@page import="quiz.QuizConstants"%>
<%@page import="quiz.CookieHelper"%>
<div>
	<div style="margin-top: 50px;">
		<a class="header-title" href="<%=QuizConstants.INDEX_FILE%>">QuizFeed</a>
	</div>
</div>
<div class="navbar">
	<a class="nav-link" style="left: 220px;" href="#">Quizzes</a>
	<%
		Cookie uID = CookieHelper.getCookie(request.getCookies(), "uID");
		if (uID == null) {
	%>
	<a class="nav-link" style="right: 275px;" href="login">Login</a>
	<%
		} else {
			Cookie usernameCookie = CookieHelper.getCookie(request.getCookies(), "username");
			String username = usernameCookie.getValue();
	%>
	<div class="nav-link" style="right: 275px;">
		Welcome,
		<%=username%>! <a href="logout">Logout</a>
	</div>
	<%
		}
	%>
</div>