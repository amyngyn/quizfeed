package quiz;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeString {

	public String string;
	
	public TimeString(){
		java.util.Date date = new Date();
		java.sql.Timestamp stamp = new java.sql.Timestamp(date.getTime());
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		string = simpleDateFormat.format(stamp);
	}

}
