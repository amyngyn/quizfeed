<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="quiz.Database"%>
<%@ page import="java.util.*"%>
<%@ page import="quiz.QuizConstants"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet.css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home - <%= QuizConstants.QUIZ_SITE_TITLE %></title>
</head>
<body>
	<jsp:include page="<%= QuizConstants.HEADER_FILE %>" />

	<div>
		<table>
			<tbody>
				<tr>
					<td>
						<p>
							<b>Quiz Name</b>
						</p>

						<p>
							<a href="QuizIntro?num=0">Test Quiz</a>
						</p>

						<p>
							<a href="QuizIntro?num=1">Stanford Quiz</a>
						</p>

						<p>
							<a href="QuizIntro?num=2">CS quiz</a>
						</p>

						<p>
							<a href="QuizIntro?num=3">you</a>
						</p>

						<p>
							<a href="QuizIntro?num=4">testing author achievement</a>
						</p>

						<p>
							<a href="CreateQuizBegin.html">Create a New Quiz</a>
						</p>
					</td>
					<td>
						<p>
							<b>Announcements</b>
						</p>

						<p>1. Happy Thanksgiving! at 1980-11-10 00:00:01.0</p>

						<p>2. Time finally works on AdminAnnouncement.java! at
							2014-11-20 16:53:26.0</p>

					</td>
				</tr>
				<tr>
					<td><b>Recent Quizzes</b>
						<table class="border">
							<tbody>
								<tr>
									<td class="border"><b>Name</b></td>
									<td class="border"><b>Time Created</b></td>
								</tr>

								<tr>
									<td class="border">CS quiz</td>
									<td class="border">2014-11-10 00:00:01.0</td>
								</tr>

								<tr>
									<td class="border">Stanford Quiz</td>
									<td class="border">2014-11-10 00:00:02.0</td>
								</tr>

								<tr>
									<td class="border">Test Quiz</td>
									<td class="border">2014-11-10 00:00:03.0</td>
								</tr>

								<tr>
									<td class="border">you</td>
									<td class="border">2014-11-20 17:09:26.0</td>
								</tr>

								<tr>
									<td class="border">testing author achievement</td>
									<td class="border">2014-11-20 19:17:21.0</td>
								</tr>

							</tbody>
						</table></td>
					<td><b>Popular Quizzes</b>
						<table class="border">
							<tbody>
								<tr>
									<td class="border"><b>Name</b></td>
									<td class="border"><b>Attempts</b></td>
								</tr>

								<tr>
									<td class="border">Test Quiz</td>
									<td class="border">26</td>
								</tr>

								<tr>
									<td class="border">Stanford Quiz</td>
									<td class="border">4</td>
								</tr>

							</tbody>
						</table></td>
				</tr>
				<tr>
					<td><b>Your Achievements</b> <br> <a href="Login.html"><b>Login</b></a></td>
				</tr>
			</tbody>
		</table>
	</div>

</body>
</html>