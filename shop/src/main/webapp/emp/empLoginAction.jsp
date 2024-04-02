<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>

<% 

	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	common.loginCheck("in", request, response);
	
	
	
	String[] paramsArr = new String[2];
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	paramsArr[0] = empId;
	paramsArr[1] = empPw;
	
	for(String p : paramsArr){
		if(p == null || p == "" || p.equals("null")) {
			response.sendRedirect("/shop/emp/empLoginForm.jsp");
			return;
		}
	};
	

	Connection conn = common.DBConnection();
	String sql = "SELECT * FROM EMP WHERE active='ON' AND emp_id = ? AND emp_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	ResultSet rs1 = stmt.executeQuery();

	String msg = "아이디 또는 비밀번호를 다시 확인해보시기 바랍니다.";
	System.out.println("rs1 : " + rs1);

 	if(rs1.next()){
 		session.setAttribute("loginEmp", empId);
 		response.sendRedirect("./empList.jsp");
	} else{
		String errMsg = URLEncoder.encode(msg, "utf-8");
 		response.sendRedirect("./empLoginForm.jsp?msg="+errMsg);		
	}
%>