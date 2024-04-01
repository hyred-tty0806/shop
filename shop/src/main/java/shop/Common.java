package shop;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.security.auth.message.callback.PrivateKeyCallback.Request;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class Common {
	public PreparedStatement stmt = null;
	public ResultSet rs = null; 
	public Connection DBConnection() throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
		return conn;
	}
	
	public void sessionCheck(String msg, HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		if(msg.equals("in")) {
			//인증분기 : 세션변수 이름 - loginEmp
			if(session.getAttribute("loginEmp") != null){
				response.sendRedirect("/shop/emp/empList.jsp");
				return;
			}			
		}
		if(msg.equals("out")){
			//인증분기 : 세션변수 이름 - loginEmp
			if(session.getAttribute("loginEmp") == null){
				response.sendRedirect("/shop/emp/empLoginForm.jsp");
				return;
			}
		}
		
	}

}
