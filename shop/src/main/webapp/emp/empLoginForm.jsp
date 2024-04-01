<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.Common"%>
<% 
	// 인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	common.sessionCheck("in", request, response);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./empLoginAction.jsp" method="post">
		<input type="text" name="userId">
		<input type="password" name="userPw">
	</form>
</body>
</html>