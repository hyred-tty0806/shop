<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="shop.Common"%>

<% 
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("in", request, response);
	
	
	String[] paramsArr = new String[2];
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	paramsArr[0] = empId;
	paramsArr[1] = empPw;
	
	for(String p : paramsArr){
		if(p == null || p == "" || p.equals("null")) {
			response.sendRedirect("/shop/emp/empLoginForm.jsp");
			return;
		}else{
			System.out.println(p);
		}
	};
	
	Connection conn = common.DBConnection();
	String sql = "SELECT emp_id empId, grade, emp_name empName, emp_job empJob, hire_date hireDate, active "
				+"FROM EMP WHERE active='ON' AND emp_id = ? AND emp_pw = PASSWORD(?)";
	PreparedStatement stmt = conn.prepareStatement(sql);
	stmt.setString(1, empId);
	stmt.setString(2, empPw);
	ResultSet rs1 = stmt.executeQuery();

	String msg = "아이디 또는 비밀번호를 다시 확인해보시기 바랍니다.";
	
 	if(rs1.next()){
 		// 세션을 '맵'으로 담기, 들어갈 객체는 empId, empName, grade
		HashMap<String, String> loginEmp = new HashMap<String, String>();
 		loginEmp.put("empId", rs1.getString("empId"));
 		loginEmp.put("empName", rs1.getString("empName"));
 		loginEmp.put("grade", rs1.getString("grade"));
 		String empIdStr = (String)(loginEmp.get("empId"));
 		String empNameStr = (String)(loginEmp.get("empName"));
 		String gradeStr = (String)(loginEmp.get("grade"));
 		System.out.println("empIdStr : " + empIdStr);
 		System.out.println("empNameStr : " + empNameStr);
 		System.out.println("gradeStr : " + gradeStr);
 		session.setAttribute("loginEmp", loginEmp);
 		response.sendRedirect("./empList.jsp");
	} else{
		String errMsg = URLEncoder.encode(msg, "utf-8");
 		response.sendRedirect("./empLoginForm.jsp?msg="+errMsg);		
	}
%>