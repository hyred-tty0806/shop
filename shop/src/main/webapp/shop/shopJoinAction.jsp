<%@page import="java.util.Map"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="shop.dao.CusDAO"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="shop.dao.EmpDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<% 
	Common common = new Common();
	// 요청 값 분석
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
/* 	System.out.println("gender : " + gender);
	System.out.println("id : " + id); */
		
	LinkedHashMap<String, Object> reqMap = new LinkedHashMap<String, Object>() {{
	    put("id", id);
	    put("pw", pw);
	    put("name", name);
	    put("birth", birth);
	    put("gender", gender);
	}};

	System.out.println("reqMap : " + reqMap);
	// 요청 값이 1개라도 null일시
	if(common.reqeustParsing(reqMap) == 0){
		response.sendRedirect("/shop/shop/shopLoginForm.jsp");
		return;
	};
	
	//로그인 상태 확인
	// return : 0 => 로그인X / 1 => 로그인O
	if(common.customerLoginCheck("cusLogin", request, response) == 1){
		response.sendRedirect("/shop/shop/main.jsp");
		return;		
	}
	int index = 1;
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>();
	for(Entry<String, Object> e : reqMap.entrySet()){
		System.out.println("e.getValue() : " + e.getValue());
		System.out.println("index : " + index);
		qryParamMap.put(index, e.getValue());
		index = index + 1;
	}
%>
<% 
	int row = CusDAO.insertCus(qryParamMap);
	if(row == 1) {
		// 상품 등록 성공
		System.out.println("고객 등록 성공");
		response.sendRedirect("/shop/shop/shopLoginForm.jsp");
	} else {
		// 상품 등록 실패
		System.out.println("고객 등록 실패");
		response.sendRedirect("/shop/emp/shopJoinForm.jsp");
	}
%>
