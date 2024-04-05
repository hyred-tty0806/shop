<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
	
	String no = request.getParameter("no");
	System.out.println("no : " + no);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Insert title here</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link href="/shop/style/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<%@ include file="/common/empMenu.jsp" %>
	<div class="container text-center">
		<div class="row align-items-center mt-5">
			<div class="col">
			</div>
			<div class="col-10">
			<h1>GOODS LIST</h1>
			</div>
			<div class="col">
			</div>
		</div>
		<div class="row mt-5">
			<div class="col">
					
			</div>
			<div class="col-10">
				<table class="table w-100">
					<tr>
						<th>No</th>
						<th>Category</th>
						<th>Image</th>
						<th>ID</th>
						<th>Title</th>
						<th>Price</th>
						<th>Amount</th>
					</tr>	
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
	
					
				</table>
			</div>
			<div class="col">
	
			</div>
		</div>
	</div>

</body>
</html>