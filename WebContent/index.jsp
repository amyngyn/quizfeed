<%@page import="quiz.Announcement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.*"%>
<%@ page import="java.util.*"%>

<jsp:include page="<%=Constants.HEADER_FILE%>">
	<jsp:param value="Home" name="title" />
</jsp:include>

<%
	User user = (User) session.getAttribute("user");
	if (user == null) {
		String redirectURL = "login.jsp";
		response.sendRedirect(redirectURL);
		return;
	}
%>

<div style="float: left; margin-left: 75px;">
	<h1>Announcements</h1>
	<ol>
		<%
			ArrayList<Announcement> announcements = Announcement
					.getAnnouncements(5);
			for (int i = 0; i < announcements.size(); i++) {
				Announcement a = announcements.get(i);
		%>
		<li><%=a.getAnnouncementText() + " at " + a.getHumanTime()%></li>
		<%
			}
		%>
	</ol>

	<h1>Your Achievements</h1>
	<%
		ArrayList<String> achievements = user.getAchievements();
		if (achievements.isEmpty()) {
	%>
	<p>You don't have any achievements!</p>
	<%
		} else {
	%>
	<ul>
		<%
			boolean showMore = false;
				int count = achievements.size();
				if (achievements.size() > 5) {
					count = 5;
					showMore = true;
				}
				for (int i = 0; i < count; i++) {
		%>
		<li><%=achievements.get(i)%></li>
		<%
			}
		%>
	</ul>
	<%
		if (showMore) {
	%>
	<p>
		See the rest of your achivements on <a href="user?uid=<%=user.getID()%>">your
			profile</a>!
	</p>
	<%
		}
		}
	%>

	<h1>Your Recent Activities</h1>
	<%
		ArrayList<Quiz> recentlyTakenQuizzes = user
				.getRecentlyTakenQuizzes(5);
		if (recentlyTakenQuizzes.isEmpty()) {
	%>
	<p>You haven't taken any quizzes yet!</p>
	<%
		} else {
	%>
	<ul>
		<%
			for (int i = 0; i < recentlyTakenQuizzes.size(); i++) {
					Quiz quiz = recentlyTakenQuizzes.get(i);
		%>
		<li><a href="QuizIntro?num=%<%=quiz.getID()%>"><%=quiz.getName()%></a></li>
		<%
			}
			}
		%>
	</ul>

	<h1>Your Friends' Recent Activities</h1>
	<%
		HashMap<Integer, ArrayList<Quiz>> activities = user
				.getFriendActivities();
		if (activities.isEmpty()) {
	%>
	<p>Your friends haven't done anything.</p>
	<%
		} else {
	%>
	<ul>
		<%
			for (Integer uID : activities.keySet()) {
					User friend = User.getUser(uID);

					ArrayList<Quiz> friendQuizzes = activities.get(uID);
					for (Quiz quiz : friendQuizzes) {
		%>
		<li><a href="user?uid=<%=friend.getID()%>"><%=friend.getUsername()%></a> took
			<a href="QuizIntro?num=<%=quiz.getID()%>"><%=quiz.getName()%></a></li>

		<%
					}
			}
			
		%>
	</ul>
	<%
		}
	%>
</div>

<div style="float: right; margin-right: 75px;">
	<h1>Your Quizzes</h1>
	<ul>
		<%
			ArrayList<Quiz> userRecentlyCreatedQuizzes = user
					.getRecentlyCreatedQuizzes(5);

			for (int i = 0; i < userRecentlyCreatedQuizzes.size(); i++) {
				Quiz quiz = userRecentlyCreatedQuizzes.get(i);
		%>
		<li><a href="QuizIntro?num=<%=quiz.getID()%>"><%=quiz.getName()%></a></li>
		<%
			}
		%>
	</ul>
	<a href="CreateQuizBegin.jsp">Create a Quiz</a>
	<h1>Recent Quizzes</h1>
	<ul>
		<%
			ArrayList<Quiz> recentQuizzes = Quiz.getRecentQuizzes(5);

			for (int i = 0; i < recentQuizzes.size(); i++) {
				Quiz quiz = recentQuizzes.get(i);
		%>
		<li><a href="QuizIntro?num=<%=quiz.getID()%>"><%=quiz.getName()%></a></li>
		<%
			}
		%>
	</ul>
	<h1>Popular Quizzes</h1>
	<ul>
		<%
			ArrayList<Quiz> popularQuizzes = Quiz.getPopularQuizzes(5);

			for (int i = 0; i < popularQuizzes.size(); i++) {
				Quiz quiz = popularQuizzes.get(i);
		%>
		<li><a href="QuizIntro?num=<%=quiz.getID()%>"><%=quiz.getName()%></a></li>
		<%
			}
		%>
	</ul>
</div>

<jsp:include page="<%=Constants.FOOTER_FILE%>"></jsp:include>
