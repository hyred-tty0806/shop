<%@page import="shop.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<% 
	// 요청 값 분석
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	String empPwCheck = request.getParameter("empPwCheck");
	String empName = request.getParameter("empName");
	String empJob = request.getParameter("empJob");
	String hireDate = request.getParameter("hireDate");
	
	// 요청 값이 1개라도 null일시
	if(empId == null || empPw == null || empPwCheck == null || 
			empName == null || hireDate == null) {
		response.sendRedirect("/shop/emp/joinForm.jsp");
		return;
	}
	
	Common common = new Common();
	int resultInt = common.loginCheck("in", request, response);
%>
<% 
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>()
	{{
		put(1, empId);
		put(2, empPw);
		put(3, empName);
		put(4, empJob);
		put(5, hireDate);
	}};
	int row = EmpDAO.insertEmp(qryParamMap);
	if(row == 1) {
		// 상품 등록 성공
		System.out.println("사원 등록 성공");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
	} else {
		// 상품 등록 실패
		System.out.println("사원 등록 실패");
		response.sendRedirect("/shop/emp/joinForm.jsp");
	}
%>
