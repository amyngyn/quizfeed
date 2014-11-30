package quiz;

import javax.servlet.http.Cookie;

public class CookieHelper {
	public static Cookie getCookie(Cookie[] cookies, String name) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals(name)) {
				System.out.println("getCookie: found " + name + " with value " + cookie.getValue());
				return cookie;
			}
		}
		System.out.println("getCookie: did not find " + name);
		return null;
	}
}
