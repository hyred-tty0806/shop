<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.Model"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);	
%>

<% 
	/* 1. 카테고리 목록 조회 */
	String listQry = "select category from goods GROUP BY category ORDER BY category ASC";
	Connection conn = common.DBConnection();
	ResultSet rs = null;
	PreparedStatement stmt = null;
	String[] colNameArr = {"category"};
	Model model = new Model();
	ArrayList<HashMap<String, Object>> list = model.listQry(conn, rs, stmt, listQry, colNameArr);
	
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
			<h1>GOODS SAVE</h1>
			</div>
			<div class="col">
			</div>
		</div>
		<div class="row align-items-center mt-5">
			<div class="col"></div>
			<div class="col-10">
				<form action="/shop/emp/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
					<!-- 1. 셀렉트박스 카테고리 목록 출력 -->
					<table class="table">
					<colgroup>
						<col width="30%">
						<col width="70%">
					</colgroup>
					<tr>
						<td >
							<label for="category">CATEGORY</label>			
						</td>
						<td>
							<select name="category" id="category" class="form-select" aria-label="Default select example">
								<%for( HashMap<String, Object> s : list ){%>
									<option value="<%=s.get("category")%>"><%=s.get("category")%></option>
								<%}%>
							</select>			
						</td>
					</tr>
					<tr>
						<td>
							<label for="image">IMAGE</label>			
						</td>
						<td>
							<input type="file" name="goodsImg" />
						</td>
					</tr>
					<tr>
						<td>
							<label for="title">TITLE</label>			
						</td>
						<td>
			  				<input type="text" id="title" name="title" class="form-control" aria-describedby="basic-addon1">
						</td>
					</tr>
					<tr>
						<td>
							<label for="amount">AMOUNT</label>
						</td>
						<td>
			  				<input type="number" id="amount" name="amount" class="form-control" aria-describedby="basic-addon1">				
						</td>
					</tr>
					<tr>
						<td>
							<label for="content">CONTENT</label>
						</td>
						<td>
							<textarea id="content" name="content" style="resize : none; height: 200px;" class="form-control" aria-label="With textarea"></textarea>
						</td>
					</tr>
					<tr>
						<td>
							<label for="price">PRICE</label>
						</td>
						<td>
							<div class="input-group mb-3">
							  <input type="number" name="price" class="form-control" aria-describedby="basic-addon2">
							  <span class="input-group-text" id="basic-addon2">WON</span>
							</div>
						</td>
					</tr>
					</table>
					<button class="btn btn-success">SAVE</button>
				</form>
			</div>
			<div class="col">
			</div>
		</div>
	</div>
</body>
</html>