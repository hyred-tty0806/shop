package shop;


import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.HashMap;
import java.util.Map.Entry;
import java.util.Properties;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Common {
	public Connection DBConnection() throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		/* FileReader fr = new FileReader("d:\\dev\\auth\\mariadb.properties"); */
		FileReader fr = new FileReader("d:\\work\\dev\\auth\\mariadb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		System.out.println(prop.getProperty("id"));
		System.out.println(prop.getProperty("pw"));
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", id, pw);
		return conn;
	}
	
	public int loginCheck(String msg, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		if(msg.equals("in")) {
			if(session.getAttribute("loginEmp") != null){
				response.sendRedirect("/shop/emp/empList.jsp");
				return 0;
			}			
		}
		if(msg.equals("out")){
			if(session.getAttribute("loginEmp") == null){
				response.sendRedirect("/shop/emp/empLoginForm.jsp");
				return 0;
			}
		}
		return 1;	
	}
	public int customerLoginCheck(String sessionKey, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
			if(session.getAttribute(sessionKey) == null){
				return 0;
			}else {
				return 1;
			}
	}
	
	public int reqeustParsing(HashMap<String, Object> reqMap) {
		int result = 0;
		for(Entry<String, Object> e : reqMap.entrySet()){
			if(e.getValue() == null ) {
				break;
			}else {
				result = 1;
			}
		}
		return result;
	}
	
	public String getSessionInfo(String msgInfo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginEmp") == null) {		
			return "";
		}
		HashMap<String, String> getInfoMap = (HashMap<String, String>) session.getAttribute("loginEmp");
		return getInfoMap.get(msgInfo);
	}
}
