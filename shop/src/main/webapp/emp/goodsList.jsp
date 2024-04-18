<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
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
	
	String category = "";
	String categoryPart = "";
	if(request.getParameter("category") != null 
			&& !request.getParameter("category").equals("")
			&& !request.getParameter("category").equals("null")){
		category = request.getParameter("category");
		System.out.println("category : " + request.getParameter("category"));
		categoryPart = " AND category = '"+request.getParameter("category")+"'";
	}
	
	String keyword = "";
	String keywordPartQry = "";
	if(request.getParameter("keyword") != null){
		keyword = request.getParameter("keyword");
		System.out.println("keyword : " + keyword);
		keywordPartQry = " AND (goods_content like '%"+request.getParameter("keyword")+"%'"
						+" OR goods_title like '%"+request.getParameter("keyword")+"%') ";
	}

	String categoryQry = "";
	categoryQry = "SELECT category, count(*) cnt FROM goods "
			+ "WHERE 1=1 "
			+ " GROUP BY category ORDER BY category ASC";		
	String[] colNameArr = {"category","cnt"};
	Model model = new Model();
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	categoryList = model.listQry(categoryQry, colNameArr, new HashMap<Integer, Object>(){{}});

	
	String listCntQry = "SELECT COUNT(*) cnt FROM goods";
	ArrayList<HashMap<String, Object>> listCnt = new ArrayList<HashMap<String, Object>>();
	listCnt = model.listQry(categoryQry, new String[]{"cnt"}, new HashMap<Integer, Object>(){{}});
	
	
	int totalRow = 0;
	if(listCnt.size() > 0){
		totalRow = Integer.parseInt(""+listCnt.get(0).get("cnt"));
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
	
	int startPage = (currentPage-1)*rowPerPage;
	
	String orderByCol = "goods_no";
	String orderBySet = "DESC";
	String orderByPart = "";
	if(request.getParameter("orderByCol") != null){
		orderByCol = request.getParameter("orderByCol");
	}
	if(request.getParameter("orderBySet") != null){
		orderBySet = request.getParameter("orderBySet");		
	}
	orderByPart = " ORDER BY "+orderByCol+" "+orderBySet;
	
	
	String sql = "SELECT goods_no no, category, emp_id empId, goods_title title, goods_content content, goods_price price, goods_amount amount, filename"
				+" FROM goods WHERE 1 = 1 "
				+ categoryPart
				+ keywordPartQry
				+ orderByPart +" LIMIT ?, ?";
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>();
	qryParamMap.put(1,startPage);
	qryParamMap.put(2,rowPerPage);
	
	System.out.println("sql : "+sql);
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	list = model.listQry(sql, new String[]{"no","category","empId","title","content","price","amount","filename"}, qryParamMap);
	int listSize = list.size();
	System.out.println("listSize : " + listSize);
	String pageingUrl = "./goodsList.jsp";
	/* category null 이면 빼고 전체조회쿼리 아니면 where 조회쿼리 */
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
				<form action="<%=pageingUrl%>?category=<%=category %>&rowPerPage=<%=rowPerPage %>">
					<div class="input-group">
						<input type="hidden" name="category" value="<%=category %>">
						<input type="hidden" name="rowPerPage" value="<%=rowPerPage%>">
						<input type="text" name="keyword" class="form-control" aria-describedby="button-addon2">
						<button class="btn btn-outline-secondary" type="submit" id="button-addon2">Search</button>
					</div>				
				</form>
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
					for(HashMap<String, Object> m : categoryList) {
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
						System.out.println("list.size() : " + list.size());
						for(HashMap<String, Object> m : list) {
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
					
						<div class="dropdown">
							<a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
								<% if(rowPerPage == 10) { %> 10개씩 보기 <% } %>
								<% if(rowPerPage == 30) { %> 30개씩 보기 <% } %>
								<% if(rowPerPage == 50) { %> 50개씩 보기 <% } %>
								<% if(rowPerPage == 100) { %> 100개씩 보기 <% } %>
							</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=10&category=<%=category%>">10개씩 보기</a></li>
								<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=30&category=<%=category%>">30개씩 보기</a></li>
								<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=50&category=<%=category%>">50개씩 보기</a></li>
								<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=100&category=<%=category%>">100개씩 보기</a></li>
							</ul>
						</div>

								  				
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