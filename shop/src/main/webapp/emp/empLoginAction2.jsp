<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>

<% 
	Common common = new Common();
	common.sessionCheck("in", request, response);
	
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
	String sql = "SELECT * FROM EMP WHERE emp_id = ? AND emp_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	ResultSet rs1 = stmt.executeQuery();
	
	String msg = "아이디 또는 비밀번호를 다시 확인해보시기 바랍니다.";
	if(rs1.next()){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}else{
		response.sendRedirect("/shop/emp/empForm.jsp?msg="+msg);		
		return;
	}	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>