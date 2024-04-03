<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	common.loginCheck("out", request, response);
%>
<!-- Model Layer -->
<%
	int currentPage = 1; // 1. 처음이면 1페이지 
	if(request.getParameter("currentPage") != null){ // 요청된 파라미터가 있으면
		// 페이지 이동하여 currentPage 값을 받았을 때
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	String listCntQry = "select COUNT(*) from emp";
	
	Connection conn = common.DBConnection();
	
	PreparedStatement stmtCnt = null;
	ResultSet rsCnt = null;
	
	stmtCnt = conn.prepareStatement(listCntQry);
	rsCnt = stmtCnt.executeQuery();
	
	int totalRow = 0;
	if(rsCnt.next()){
		totalRow = rsCnt.getInt("count(*)");
	}
	System.out.println("totalRow : " + totalRow);
	
	
	int rowPerPage = 10;
	int lastPage = totalRow / rowPerPage;
	if(totalRow%rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	

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
%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력 -->
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
	<%@ include file="/common/empMenu.jsp" %>
	<div class="container text-center">
		<div class="row align-items-center mt-5">
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
			<div class="col"></div>
		</div>
	</div>
	<%@ include file="/common/paging.jsp"  %>
</body>
</html>