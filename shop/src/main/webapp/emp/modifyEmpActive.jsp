<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	
	String active = request.getParameter("active");
	String empId = request.getParameter("empId");
	
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
	
	String[] paramsArr = new String[2];
	paramsArr[0] = active;
	paramsArr[1] = empId;
	
	for(String p : paramsArr){
		if(p == null || p == "" || p.equals("null")) {
			response.sendRedirect("./empList.jsp");
			return;
		}else{
			System.out.println("param : " + p);
		}
	};
	String qryStr = "";
	if(active.equals("ON")){
		qryStr = "OFF";
	}else{
		qryStr = "ON";		
	}

	Connection conn = common.DBConnection();
	String sql = "UPDATE emp SET active = ? WHERE emp_id = ?";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, qryStr);
	stmt.setString(2, empId);
	stmt.executeQuery();
	response.sendRedirect("./empList.jsp");
%>