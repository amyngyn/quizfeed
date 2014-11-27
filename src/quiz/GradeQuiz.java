package quiz;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GradeQuiz
 */
@WebServlet("/GradeQuiz")
public class GradeQuiz extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GradeQuiz() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
	
	private void recordScore(int uID, int zID, int score, int possible){
		Database db = new Database();
		Statement s = db.statement;
		TimeString t = new TimeString();
		String string = t.string;
		
		String insert = "INSERT INTO scores VALUES (" + uID + ", " + zID + ", " + score + ", " + possible + ", '" + string + "');";
		
		try {
			s.execute(insert);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void addQuizMachineAchievement(int uID, int zID) throws SQLException{
		Database d = new Database();
		String query = "Select name From quizzes Where zID=" + zID + ";";
		ResultSet rs = d.statement.executeQuery(query);
		rs.next();
		String name = rs.getString("name");
		
		int QUIZMACHINE_TYPE = 1;
		// uID type name
		String insert = "INSERT INTO achievements VALUES (" + uID + ", " + QUIZMACHINE_TYPE + ", '" + name + "');"; 
		d.statement.execute(insert);
	}
	
	private void addHighScoreAchievement(int score, int uID, int zID) throws SQLException{
		int HIGHSCORE_TYPE = 2;
		Database d = new Database();
		
		String query = "Select name From quizzes Where zID=" + zID + ";";
		ResultSet rs = d.statement.executeQuery(query);
		rs.next();
		String name = rs.getString("name");
		
		query = "Select max(score) as score From scores Where zID=" + zID + ";";
		rs = d.statement.executeQuery(query);
		if(!rs.next()){
			String insert = "INSERT INTO achievements VALUES (" + uID + ", " + HIGHSCORE_TYPE + ", '" + name + "');"; 
			d.statement.execute(insert);
			return;
		}
		int high = rs.getInt("score");
		if(score < high) return;
		
		String insert = "INSERT INTO achievements VALUES (" + uID + ", " + HIGHSCORE_TYPE + ", '" + name + "');"; 
		d.statement.execute(insert);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Vector<Integer> types = (Vector<Integer>) request.getSession().getAttribute("types");
		request.setAttribute("size", types.size());
		Vector<String> answers = (Vector<String>) request.getSession().getAttribute("answers");
		Vector<Integer> answersTo = (Vector<Integer>) request.getSession().getAttribute("answersTo");
		int answersSize = answers.size();
		
		int questions = types.size();
		int score = 0;
		int possible = 0;
		

		
		for(int i=0; i<questions; i++){
			
			
			// Grade type 1 question - text response
			if(types.get(i) == 1){
				String userAnswer = (String) request.getParameter(i + "");
				int index = answersTo.indexOf(i);
				String correct = answers.get(index);
				
				if(correct.equals(userAnswer)) score++;
				possible++;
			
			// Grade type 2 question - Multiple choice
			}else if(types.get(i) == 2){
				String userAnswer = (String) request.getParameter(i + "");
				int index = answersTo.indexOf(i);
				String correct = answers.get(index);
				
				if(correct.equals(userAnswer)) score++;
				possible++;
				
			// Grade type 3 question - Multiple choice
			}else if(types.get(i) == 3){
				String userAnswer = (String) request.getParameter(i + "");
				int index = answersTo.indexOf(i);
				String correct = answers.get(index);
				
				if(correct.equals(userAnswer)) score++;
				possible++;
	
			// Grade type 4 question - Picture Response
			}else if(types.get(i) == 4){
				String userAnswer = (String) request.getParameter(i + "");
				int index = answersTo.indexOf(i);
				String correct = answers.get(index);
				
				if(correct.equals(userAnswer)) score++;
				possible++;
				
			// Grade type 5 question - multi text answer
			}else if(types.get(i) == 5){
				
				Vector<String> theAnswers = new Vector<String>();
				answersSize = answers.size();
				for(int j=0; j<answersSize; j++){
					if(answersTo.get(j) == i){
						theAnswers.add(answers.get(j));
					}
				}
				
				int count = theAnswers.size();
				for(int j=0; j<count; j++){
					String name = i + "-" + j;
					String userText = request.getParameter(name);
					if(theAnswers.contains(userText))score++;
					possible++;
				}
				
			// Grade type 6 question - multi answer multi choice
			}else if(types.get(i) == 6){
				
				Vector<String> theAnswers = new Vector<String>();
				answersSize = answers.size();
				
				for(int j=0; j<answersSize; j++){
					if(answersTo.get(j) == i){
						theAnswers.add(answers.get(j));
						possible++;
					}
				}
				
				//request.setAttribute("test", theAnswers.get(3));
				// must know choices to precisely get this answer
				int count = 10;
				
				for(int j=0; j<count; j++){
					String name = i + "-" + j;
					String userText = request.getParameter(name);	
					if(theAnswers.contains(userText)){
						score++;
					}
				}
			}else if(types.get(i) == 7){
				Vector<String> theAnswers = new Vector<String>();
				answersSize = answers.size();
				
				for(int j=0; j<answersSize; j++){
					if(answersTo.get(j) == i){
						theAnswers.add(answers.get(j));
						possible++;
					}
				}
				
				int count = theAnswers.size();
				for(int j=0; j<count; j++){
					String name = i + "-" + j;
					String userText = request.getParameter(name);	
					if(theAnswers.get(j).equals(userText)){
						score++;
					}
				}
			}
		}
		
		request.setAttribute("score", score);
		request.setAttribute("possible", possible);
		Integer uID = (Integer)request.getSession().getAttribute("uID");
		Integer zID = (Integer)request.getSession().getAttribute("zID");
		
		if(uID != null){
			recordScore(uID, (Integer)request.getSession().getAttribute("zID"), score, possible);
			try {
				addQuizMachineAchievement(uID, zID);
				addHighScoreAchievement(score, uID, (Integer)request.getSession().getAttribute("zID"));
			} catch (SQLException e) {e.printStackTrace();}
			
		}
		
		RequestDispatcher dispatch = request.getRequestDispatcher("GradedQuiz.jsp");
		dispatch.forward(request, response);	
	}
	
	
	
}





