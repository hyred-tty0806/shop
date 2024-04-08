<%@page import="shop.Model"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
	if(resultInt == 0){
		return;
	}
	String empName = common.getSessionInfo("empName", request, response);
%>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	String category = "all";
	if(request.getParameter("category") != null){
		category = request.getParameter("category");
		System.out.println("category : " + category);
	}
%>
<% 
	Connection conn = common.DBConnection();
	ResultSet rs = null;
	PreparedStatement stmt = null;
	
	String categoryPart = (category.equals("all")) ? "": " AND category = '"+category+"'";
	
	String categoryQry = "";
	categoryQry = "SELECT category, count(*) cnt FROM goods "
			+ "WHERE 1=1 "
			+ " GROUP BY category ORDER BY category ASC";		
	String[] colNameArr = {"category","cnt"};
	Model model = new Model();
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	list = model.listQry(conn, rs, stmt, categoryQry, colNameArr);
%>
<% 
	String listCntQry = "SELECT COUNT(*) cnt FROM goods";
	
	PreparedStatement stmtCnt = null;
	ResultSet rsCnt = null;
	
	stmtCnt = conn.prepareStatement(listCntQry);
	rsCnt = stmtCnt.executeQuery();
	
	int totalRow = 0;
	if(rsCnt.next()){
		totalRow = rsCnt.getInt("cnt");
	}
	System.out.println("totalRow : " + totalRow);
	
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));		
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	
	String sql = "SELECT goods_no no, category, emp_id empId, goods_title title, goods_content content, goods_price price, goods_amount amount, filename"
				+" FROM goods WHERE 1 = 1 "
				+ categoryPart
				+" ORDER BY no DESC LIMIT ?, ?";
	
	System.out.println("sql : " + sql);
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, (currentPage-1)*rowPerPage);
	stmt.setInt(2, rowPerPage);
	rs = stmt.executeQuery(); 
	
	// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
	ArrayList<HashMap<String, Object>> list2
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("no", rs.getString("no"));
		m.put("category", rs.getString("category"));
		m.put("empId", rs.getString("empId"));
		m.put("title", rs.getString("title"));
		m.put("price", rs.getString("price"));
		m.put("amount", rs.getString("amount"));
		m.put("filename", rs.getString("filename"));
		list2.add(m);
	}
	String pageingUrl = "./goodsList.jsp";
	/* category null 이면 빼고 전체조회쿼리 아니면 where 조회쿼리 */
	String searchUrl = "";
	if(category == null){
		searchUrl = pageingUrl+"?currentPage="+currentPage+"&rowPerPage="+rowPerPage;		
	}else{
		searchUrl = pageingUrl+"?currentPage="+currentPage+"&rowPerPage="+rowPerPage+"&category="+category;				
	}
	// JDBC API 사용이 끝났다면 DB자원들을 반납
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
		<div class="row align-items-center">
			<div class="col">
			</div>
			<div class="col-6">
				<div class="input-group">
					<input type="text" class="form-control" aria-describedby="button-addon2">
					<a class="btn btn-outline-secondary" type="button" id="button-addon2">Search</a>
				</div>				
			</div>
			<div class="col">
			</div>
		</div>
		
		
		<div class="row mt-5">
			<div class="col">
				<div>
					<a href="/shop/emp/goodsList.jsp">전체</a>				
				</div>
				<%
					for(HashMap<String, Object> m : list) {
				%>
						<div>
							<a href="<%=pageingUrl %>?currentPage=1&rowPerPage=<%=rowPerPage%>&category=<%=m.get("category") %>"><%=m.get("category") %>(<%=m.get("cnt") %>)</a>										
						</div>
				<% 
					}
				%>
			</div>
			<div class="col-10">
			
				<table class="table w-100">
					<colgroup>
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="*%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
					</colgroup>
					<tr>
						<th>No</th>
						<th>Category</th>
						<th>Image</th>
						<th>ID</th>
						<th>Title</th>
						<th>Price</th>
						<th>Amount</th>
					</tr>	
					<%
						for(HashMap<String, Object> m : list2) {
					%>
							<tr>
								<td><%=(String)(m.get("no"))%></td>
								<td><%=(String)(m.get("category"))%></td>
								<td>
									<a href="./goodsOne.jsp?no=<%=(String)(m.get("no"))%>">
										<img alt="" src="/shop/upload/<%=(String)(m.get("filename"))%>" style="height: 30%; width: 30%;"> 
									</a>
								</td>
								<td><%=(String)(m.get("empId"))%></td>
								<td><%=(String)(m.get("title"))%></td>
								<td><%=(String)(m.get("price"))%></td>
								<td><%=(String)(m.get("amount"))%></td>
							</tr>
					<%		
						}
					%>
				</table>
			</div>
			<div class="col position-relative">
  				<div class="position-absolute top-0 start-0">
					<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
					<%@ include file="/common/rowPerPage.jsp"  %>
								  				
  				</div>
			</div>
		</div>
	</div>
	<!-- 페이지 버튼 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<% 
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=1&rowPerPage=<%=rowPerPage %>&category=<%=category%>">FIRST</a></li>
					<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage %>&category=<%=category%>">PREV</a></li>
			<%
				}else{
			%>
					<li class="page-item"><a class="page-link" href="#">FIRST</a></li>
					<li class="page-item"><a class="page-link" href="#">PREV</a></li>						
			<% 
				}
			%>
				 <li class="page-item"><a class="page-link" href="#"><%=currentPage%></a></li>
			<%
				if(currentPage < lastPage){	
			%>
			   		<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage %>&category=<%=category%>">NEXT</a></li>
				 	<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage %>&category=<%=category%>">LAST</a></li>
			<% 
				}else{
			%>
			   		<li class="page-item"><a class="page-link" href="#">NEXT</a></li>						
				 	<li class="page-item"><a class="page-link" href="#">LAST</a></li>
			<% 
				}
			%>
		</ul>
	</nav>
</body>
</html>