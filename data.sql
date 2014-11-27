USE c_cs108_rrb;

DROP TABLE IF EXISTS quizzes;
CREATE TABLE quizzes (
	zID INT,
    name CHAR(64),
    description TEXT,
    uID INT,
    time DateTime
);
INSERT INTO quizzes VALUES
	(0,"Test Quiz","First test quiz. One math question.", 0, "2014-11-10 00:00:03"),
	(1,"Stanford Quiz","Test quiz about Stanford info.", 0, "2014-11-10 00:00:02"),
	(2,"CS quiz","Quiz on basic CS.", 0, "2014-11-10 00:00:01");

DROP TABLE IF EXISTS questions;
CREATE TABLE questions (
	zID INT,
	sID INT,
	question TEXT,
	type INT
);
INSERT INTO questions VALUES
	(0, 0, "What is 2+2?", 3),
	(0, 1, "Where is Stanford?", 3),
	(1, 0, "What's the most popular major at Stanford?", 1),
	(1, 1, "Axe'n'", 2),
	(1, 2, "What was Leland Stanford Jr.'s father's first name?", 3),
	(1, 3, "", 4),
	(1, 4, "Name the 4 cardinal directions.", 5),
	(1, 5, "Who are Stanford Alumni?", 6),
	(1, 6, "Can you match the rivals?", 7),
	(2, 0, "What's the main languages from CS107 and CS108? (with the ++)", 5),
	(2, 1, "The most popular open-source database is My", 2),
	(2, 2, "Which one isn't cool?", 3);


DROP TABLE IF EXISTS choices;
CREATE TABLE choices (
	zID INT,
	sID INT,
	choice TEXT
);
INSERT INTO choices VALUES
	(0, 0, "0"),
	(0, 0, "1"),
	(0, 0, "4"),
	(0, 0, "5"),
	(0, 1, "Alaska"),
	(0, 1, "Germany"),
	(0, 1, "South America"),
	(0, 1, "Northern CA"),
	(1, 2, "Ben"),
	(1, 2, "Leland"),
	(1, 2, "Snoop"),
	(1, 2, "Greg"),
	(1, 3, "http://upload.wikimedia.org/wikipedia/commons/1/1e/Top_of_the_Hoover_Tower.jpg"),
	(1, 4, ""),
	(1, 4, ""),
	(1, 4, ""),
	(1, 4, ""),
	(1, 5, "Herbert Hoover"),
	(1, 5, "Reese Witherspoon"),
	(1, 5, "Harry Potter"),
	(1, 5, "Charles Schwab"),
	(1, 6, "Cal"),
	(1, 6, "Michigan"),
	(1, 6, "OSU"),
	(1, 6, "Stanford"),
	(2, 0, ""),
	(2, 0, ""),
	(2, 2, "Hacking"),
	(2, 2, "Coding"),
	(2, 2, "Investment banking"),
	(2, 2, "Software Developing");


DROP TABLE IF EXISTS answers;
CREATE TABLE answers (
	zID INT,
	sID INT,
	answer TEXT
);
INSERT INTO answers VALUES
	(0, 0, "4"),
	(0, 1, "Northern CA"),
	(1, 0, "Computer Science"),
	(1, 1, "Palm"),
	(1, 2, "Leland"),
	(1, 3, "Hoover Tower"),
	(1, 4, "North"),
	(1, 4, "South"),
	(1, 4, "East"),
	(1, 4, "West"),
	(1, 5, "Herbert Hoover"),
	(1, 5, "Reese Witherspoon"),
	(1, 5, "Charles Schwab"),
	(1, 6, "1"),
	(1, 6, "2"),
	(2, 0, "Java"),
	(2, 0, "C++"),
	(2, 1, "SQL"),
	(2, 2, "Investment banking");

DROP TABLE IF EXISTS friends;
CREATE TABLE friends (
	id1 INT,
	id2 INT
);
INSERT INTO friends VALUES
	(0, 1),
	(1, 0);


DROP TABLE IF EXISTS users;
CREATE TABLE users (
	uID INT AUTO_INCREMENT,
	name TEXT,
	password TEXT,
	salt TEXT
);
INSERT INTO users (name, password, salt) VALUES
	("Ryan", "password", "salt"),
	("Danielle", "password", "salt"),
	("Amy", "password", "salt");


DROP TABLE IF EXISTS announcements;
CREATE TABLE announcements (
	uID INT,
	announcement TEXT,
	time DateTime
);
INSERT INTO announcements VALUES
	(0, "Happy Thanksgiving!", "1980-11-10 00:00:01");
	(1, "Danielle writes an announcement!", "1980-11-10 00:00:01");


DROP TABLE IF EXISTS scores; 
CREATE TABLE scores (
	uID INT,
	zID INT,
	score INT,
	possible INT,
	time DateTime
);
INSERT INTO scores VALUES
	(0, 0, 0, 0, "1980-11-10 00:00:01");

# data isn't true -- only for test purposes
DROP TABLE IF EXISTS achievements; 
CREATE TABLE achievements (
	uID INT,
	type INT,
	name Text
);
INSERT INTO achievements VALUES
	(0, 0, "Fake Make 1"),
	(0, 0, "Fake Make 2"),
	(0, 0, "Fake Make 3"),
	(0, 0, "Fake Make 4"),
	(0, 0, "Fake Make 5"),
	(0, 0, "Fake Make 6"),
	(0, 0, "Fake Make 7"),
	(0, 0, "Fake Make 8"),
	(0, 0, "Fake Make 9"),
	(0, 0, "Fake Make 10"),
	(0, 1, "Fake Take 1"),
	(0, 1, "Fake Take 2"),
	(0, 1, "Fake Take 3"),
	(0, 1, "Fake Take 4"),
	(0, 1, "Fake Take 5"),
	(0, 1, "Fake Take 6"),
	(0, 1, "Fake Take 7"),
	(0, 1, "Fake Take 8"),
	(0, 1, "Fake Take 9"),
	(0, 1, "Fake Take 10"),
	(0, 2, "Fake Greatest"),
	(0, 3, "Fake Practice");







