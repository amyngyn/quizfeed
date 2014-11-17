package login;

import java.util.ArrayList;

public class Quiz {
	ArrayList<Question> allQuestions;
	String quizName;
	boolean randomOrder;
	boolean practiceMode;
	
	public Quiz(String name, boolean practiceMode, boolean randomOrder) {
		allQuestions = new ArrayList<Question>();
		quizName = name;
		this.practiceMode = practiceMode;
		this.randomOrder = randomOrder;
	}
	
	public String getName() {
		return quizName;
	}
	
	public void addQuestion(Question q) {
		allQuestions.add(q);
	}
	
	public Question getQuestion(int index) {
		return allQuestions.get(index);
	}
	
	public int getNumQuestions() {
		return allQuestions.size();
	}	
}
