<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
	<% 
		System.out.println("shopLogin : " + session.getAttribute("shopLogin"));
		HashMap<String, Object> shopLogin = (HashMap<String, Object>)session.getAttribute("shopLogin");
		String gender = "";
		String name = "";
		String birth = "";
		String id = "";
		
		if(session.getAttribute("shopLogin") != null){
			gender = gender+shopLogin.get("gender");
			name = name+shopLogin.get("name");
			birth = birth+shopLogin.get("birth");
			id = id+shopLogin.get("id");
			
			System.out.println("gender : " + gender);
			System.out.println("name : " + name);
			System.out.println("birth : " + birth);
			System.out.println("id : " + id);
		}
	
	%>
<div class="row">
	<div class="col-8  mx-1 my-1 hhj-header d-flex align-items-center fs-1"> <a href="/shop/shop/main.jsp" class="text-light-emphasis text-decoration-none" >SIN-SA</a> </div>
	<div class="col  mx-1 my-1">
		<div class="row">
			<% if(session.getAttribute("shopLogin") == null ){%>
				<div class="col  mx-1 my-1">
					<a href="/shop/shop/shopLoginForm.jsp"> LOGIN </a>
				</div>
				<div class="col  mx-1 my-1">
					<a href="/shop/shop/shopJoinForm.jsp"> JOIN </a>
				</div>
			<% 	} else { %>
				<div class="col-5  mx-1 my-1">
					[<%=name %>]님 반갑습니다.
				
				</div>
				<div class="col-2  mx-1 my-1">
					<a href="/shop/shop/shopInfoForm.jsp"> INFO </a>
				</div>
				<div class="col-2  mx-1 my-1">
					<a href="/shop/shop/shopLogout.jsp"> LOGOUT </a>
				</div>			
			<% } %>
		</div>
	</div>
</div>