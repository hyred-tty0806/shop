package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Common {
	public Connection DBConnection() throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
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
	
	public String getSessionInfo(String msgInfo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		HashMap<String, String> getInfoMap = (HashMap<String, String>) session.getAttribute("loginEmp");
		if(getInfoMap.get(msgInfo) == null) {
			return "";
		}
		return getInfoMap.get(msgInfo);
	}
}
