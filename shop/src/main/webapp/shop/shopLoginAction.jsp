<%@page import="java.net.URLEncoder"%>
<%@page import="shop.dao.CusDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.customerLoginCheck("shopLogin", request, response);
	if(resultInt == 1){
		response.sendRedirect("/shop/shop/main.jsp");
		return;
	}
	String msg = "아이디 또는 비밀번호를 다시 확인해보시기 바랍니다.";

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	HashMap<String, Object> reqMap = new HashMap<String, Object>() {{
		put("id", id);
		put("pw", pw);
	}};
	if (common.reqeustParsing(reqMap) == 0) { // 요청값 분석
		response.sendRedirect("/shop/shop/shopLoginForm.jsp");
		return;
	}

	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>()
			{{
				put(1, id);
				put(2, pw);
			}};
	HashMap<String, Object> resultMap = CusDAO.selectLoginOneByIdPw(qryParamMap);
	System.out.println("resultMap : " + resultMap);
if (resultMap == null) {
	String errMsg = URLEncoder.encode(msg, "utf-8");
	response.sendRedirect("/shop/shop/shopLoginForm.jsp?msg=" + errMsg);
	return;
} else {
	session.setAttribute("shopLogin", resultMap);
	response.sendRedirect("/shop/shop/main.jsp");
	return;
}
%>