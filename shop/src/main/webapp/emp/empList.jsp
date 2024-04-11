<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
	if(resultInt == 0){
		return;
	}
	String empName = common.getSessionInfo("empName", request, response);
%>
<!-- Model Layer -->
<%
	int currentPage = 1; // 1. 처음이면 1페이지 
	if(request.getParameter("currentPage") != null){ // 요청된 파라미터가 있으면
		// 페이지 이동하여 currentPage 값을 받았을 때
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	
	Connection conn = common.DBConnection();
	PreparedStatement stmtCnt = null;
	ResultSet rsCnt = null;
	
	Model model = new Model();
	/* row의 총 개수 */
	String listCntQry = "select COUNT(*) cnt from emp";
	String[] qryNameArr = {"cnt"};
	ArrayList<HashMap<String, Object>> cntOne = new ArrayList<HashMap<String, Object>>();
	cntOne = model.listQry(listCntQry, qryNameArr, new HashMap<Integer, Object>(){{}});
	int totalRow = 0;
	if(cntOne.get(0) != null){
		totalRow = Integer.parseInt(""+cntOne.get(0).get("cnt"));		
	}
	/* row의 총 개수 */
	
	/* 보여줄 row의 개수*/
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage") != null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));		
	}
	/* 보여줄 row의 개수*/
	
	/* 마지막 페이지를 구하고 */	
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	/* 마지막 페이지를 구하고 */	
	
	
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?, ?";
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, (currentPage-1)*rowPerPage);
	stmt.setInt(2, rowPerPage);
	rs = stmt.executeQuery(); 
	// JDBC API 종속된 자료구조 모델 ResultSet  -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> list
		= new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	while(rs.next()) {
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs.getString("empId"));
		m.put("empName", rs.getString("empName"));
		m.put("empJob", rs.getString("empJob"));
		m.put("hireDate", rs.getString("hireDate"));
		m.put("active", rs.getString("active"));
		list.add(m);
	}
	
	// JDBC API 사용이 끝났다면 DB자원들을 반납
	String pageingUrl = "./empList.jsp";
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>EMPLOYEE LIST</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body style="padding-top: 57px;">
	<%@ include file="/common/empMenu.jsp" %>
	<div class="container text-center">
		<div class="row mt-5">
			<div class="col"></div>
			<div class="col-8">
				<h1>EMPLOYEE LIST</h1>
				<table class="table w-100">
					<tr>
						<th>empId</th>
						<th>empName</th>
						<th>empJob</th>
						<th>hireDate</th>
						<th>active</th>
					</tr>
					<%
						for(HashMap<String, Object> m : list) {
					%>
							<tr>
								<td><%=(String)(m.get("empId"))%></td>
								<td><%=(String)(m.get("empName"))%></td>
								<td><%=(String)(m.get("empJob"))%></td>
								<td><%=(String)(m.get("hireDate"))%></td>
								<td>	
								<%
									HashMap<String, String> m2 = new HashMap<String, String>();
									m2 = (HashMap<String, String>)(session.getAttribute("loginEmp"));
									if(Integer.parseInt(m2.get("grade")) > 0){	
								%>
										<a href='modifyEmpActive.jsp?active=<%=(String)(m.get("active"))%>&empId=<%=(String)(m.get("empId"))%>' >
											<%=(String)(m.get("active"))%>
										</a>
								<%
									}								
								%>
								</td>
							</tr>
					<%		
						}
					%>
				</table>
			</div>
			<div class="col position-relative">
  				<div class="position-absolute top-0 start-0">
					
					<div class="dropdown">
						<a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<% if(rowPerPage == 10) { %> 10개씩 보기 <% } %>
							<% if(rowPerPage == 30) { %> 30개씩 보기 <% } %>
							<% if(rowPerPage == 50) { %> 50개씩 보기 <% } %>
							<% if(rowPerPage == 100) { %> 100개씩 보기 <% } %>
						</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=10">10개씩 보기</a></li>
							<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=30">30개씩 보기</a></li>
							<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=50">50개씩 보기</a></li>
							<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=100">100개씩 보기</a></li>
						</ul>
					</div>
								  				
  				</div>
			</div>
			</div>
		</div>
	</div>
	<%@ include file="/common/paging.jsp"  %>
</body>
</html>