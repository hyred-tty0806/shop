<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.Common"%>
<% 
	request.setCharacterEncoding("utf-8");
	// 인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	common.loginCheck("in", request, response);
	
 	String errMsg = request.getParameter("msg");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body style="padding-top: 57px;">
	<div class="container">
		<nav class="navbar bg-dark fixed-top border-bottom border-body" data-bs-theme="dark">
		  <!-- Navbar content -->
		    <div class="container-fluid">
		      <a class="navbar-brand" href="#">EMPLOYEE</a>
		    </div>
		</nav>
	</div>	
	<div class="container text-center">
		<div class="row align-items-center mt-5">
			<div class="col"></div>
			<div class="col">
				<div class="position-absolute top-50 start-50 translate-middle">
					<h1>LOGIN</h1>
					<form method="post" action="./empLoginAction.jsp">
						<div class="mb-3 row">
							<label for="staticEmail" class="col-sm-3 col-form-label">ID</label>
							<div class="col-sm-9">
								<input type="text" class="form-control"  name="empId" id="empId" value="">
							</div>
						</div>
						<div class="mb-3 row">
							<label for="inputPassword" class="col-sm-3 col-form-label">PASSWORD</label>
							<div class="col-sm-9">
								<input type="password" class="form-control" id="inputPassword" name="empPw" id="empPw" value="">
							</div>
						</div>
						<button type="submit" class="btn btn-success">로그인</button>
					</form>
				</div>
				<div>
 				<% 
					if(errMsg != null) {
				%>
						<%=errMsg%>		
				<%
					} 
				%>
				</div>

			</div>
			<div class="col"></div>
		</div>
	</div>

</body>
</html>