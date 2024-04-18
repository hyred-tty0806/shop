<%@page import="shop.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>

<% 
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("in", request, response);
	String msg = "아이디 또는 비밀번호를 다시 확인해보시기 바랍니다.";
	EmpDAO ed = new EmpDAO();
	
	String[] paramsArr = new String[2];
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	paramsArr[0] = empId; 
	paramsArr[1] = empPw; 
	
	HashMap<String, String> loginEmp = new HashMap<String, String>();
	loginEmp = EmpDAO.empLogin(paramsArr, request, response);
	if(loginEmp == null){
		String errMsg = URLEncoder.encode(msg, "utf-8");
		response.sendRedirect("/shop/emp/empLoginForm.jsp?msg="+errMsg);
		return;
	}else{
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("./empList.jsp");
		return;
	}
%>