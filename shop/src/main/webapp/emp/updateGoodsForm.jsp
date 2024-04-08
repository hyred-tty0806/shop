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
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
	if(resultInt == 0){
		return;
	}
	String empName = common.getSessionInfo("empName", request, response);
	int no = Integer.parseInt(request.getParameter("no"));
%>

<% 
	/* model */
	/* 1. 카테고리 목록 조회 */
	Connection conn = common.DBConnection();
	Model model = new Model();
	String listQry = "select category from goods GROUP BY category ORDER BY category ASC";
	ResultSet rs = null;
	PreparedStatement stmt = null;
	String[] colNameArr = {"category"};
	ArrayList<HashMap<String, Object>> list = model.listQry(conn, rs, stmt, listQry, colNameArr);
	
	/* goods 상세 조회 */
	String qry = "SELECT goods_no no, category, filename, emp_id empId, goods_title title, goods_content content, "
				+ "goods_price price, goods_amount amount, update_date ud, create_date cd "
			    + "FROM goods WHERE goods_no = ?";
	String[] qryNameArr = {"no","category","filename",
			"empId","title","content","price","amount","ud","cd"};
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>();
	qryParamMap.put(1, no);
	HashMap<String, Object> result = model.listOneQry(qry, qryNameArr, qryParamMap);
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
				<form action="/shop/emp/updateGoodsAction.jsp?no=<%=no %>" method="post" enctype="multipart/form-data">
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
							<select name="category" id="category" class="form-select" aria-label="Default select example" required="required">
								<%for( HashMap<String, Object> s : list ){%>
									<option value="<%=s.get("category")%>" 
										<%=(s.get("category") == result.get("category")) ? "selected" : "" %>
									><%=s.get("category")%></option>
								<%}%>
							</select>			
						</td>
					</tr>
					<tr>
						<td>
							<label for="image">IMAGE</label>			
						</td>
						<td>
							<img alt="" src="/shop/upload/<%=result.get("filename") %>" style="width:50%; height: 50%;">
							<input type="file" name="goodsImg" value="<%=result.get("filename")%>" />
						</td>
					</tr>
					<tr>
						<td>
							<label for="title">TITLE</label>			
						</td>
						<td>
			  				<input type="text" id="title" name="title" class="form-control" aria-describedby="basic-addon1"
			  					value="<%=result.get("title") %>" required="required">
						</td>
					</tr>
					<tr>
						<td>
							<label for="amount">AMOUNT</label>
						</td>
						<td>
			  				<input type="number" id="amount" name="amount" class="form-control" aria-describedby="basic-addon1"
			  				value="<%=result.get("amount")%>" required="required">				
						</td>
					</tr>
					<tr>
						<td>
							<label for="content">CONTENT</label>
						</td>
						<td>
							<textarea id="content" name="content" style="resize : none; height: 200px;" class="form-control" aria-label="With textarea" required="required">
								<%=result.get("content") %>	
							</textarea>
						</td>
					</tr>
					<tr>
						<td>
							<label for="price">PRICE</label>
						</td>
						<td>
							<div class="input-group mb-3">
							  <input type="number" name="price" class="form-control" aria-describedby="basic-addon2"
							  value="<%=result.get("price") %>" required="required">
							  <span class="input-group-text" id="basic-addon2">WON</span>
							</div>
						</td>
					</tr>
					</table>
					<button class="btn btn-success">UPDATE</button>
				</form>
			</div>
			<div class="col">
			</div>
		</div>
	</div>

</body>
</html>