package quiz;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeFormat {

	public static String getTime() {
		Date date = new Date();
		java.sql.Timestamp stamp = new java.sql.Timestamp(date.getTime());
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String timestamp = simpleDateFormat.format(stamp);
		return timestamp;
	}
}
