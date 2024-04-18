<%@page import="shop.dao.EmpDAO"%>
<%@page import="shop.Model"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Common common = new Common();
	int resultInt = common.loginCheck("in", request, response);
%> 
<% 
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	list = EmpDAO.selectEmpJobList(request, new HashMap<Integer, Object>());
%>
<%
	String actionUrl = "./joinAction.jsp";
	String currentUrl = "./joinForm.jsp";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>JOIN</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link href="/shop/style/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
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
			<div class="col-8">
				<h1>INFORMATION REGISTRATION</h1>
			</div>
			<div class="col"></div>
		</div>
		<form action="<%=actionUrl %>" method="post">
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" style="text-align: left;">
					<label for="id" class="w-50" style="text-align: center">ID</label>
					<input id="id" type="text" name="empId" required="required">				
				</div>
				<div class="col"></div>
			</div>
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" style="text-align: left;">
					<label for="pw" class="w-50" style="text-align: center">PASSWORD</label>
					<input id="pw" type="PASSWORD" name="empPw" required="required">
				</div>
				<div class="col"></div>
			</div>
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" style="text-align: left;">
					<label for="pwCheck" class="w-50" style="text-align: center">PASSWORD DOUBLE CHECK</label>
					<input id="pwCheck" type="PASSWORD" name="empPwCheck">
				</div>
				<div class="col"></div>
			</div>
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" style="text-align: left;">
					<label for="name" class="w-50" style="text-align: center">YOUR NAME</label>
					<input id="name" type="text" name="empName" required="required">
				</div>
				<div class="col"></div>
			</div>
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" style="text-align: left;">
					<label for="kindOfJop" class="w-50" style="text-align: center">YOUR JOB</label>
					<select id="kindOfJop" name="empJob">
						<% for(HashMap<String, Object> m : list){%>
							<option value="<%=m.get("empJob")%>"><%=m.get("empJob")%></option>   
						<% }%>
					</select>
				</div>
				<div class="col"></div>
			</div>
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" style="text-align: left;">
					<label for="hire" class="w-50" style="text-align: center">HIRE DATE</label>
					<input id="hire" type="date" name="hireDate">				
				</div>
				<div class="col"></div>
			</div>
			<div class="row align-items-center mt-5">
				<div class="col"></div>
				<div class="col" >
					<button type="submit" class="btn btn-success">SUBMIT</button>
					<a href="./empLoginForm.jsp" class="btn btn-success">BACK</a>
				</div>
				<div class="col"></div>
			</div>
		</form>
	</div>
			
</body>
</html>