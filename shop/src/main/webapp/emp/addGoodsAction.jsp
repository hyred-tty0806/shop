<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Controller Layer -->
<%
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	common.loginCheck("out", request, response);
%>

<!-- Session 설정 값 : 입력할 때 로그인한 emp의 emp_id값이 필요하기 때문! -->
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
%>

<!-- Model Layer -->
<%
	// 요청 값 분석
	String category = request.getParameter("category");
	String title = request.getParameter("title");
	String amount = request.getParameter("amount");
	String content = request.getParameter("content");
	String price = request.getParameter("price");
	
	// 요청 값이 1개라도 null일시
	if(category == null || title == null || price == null || 
			amount == null || amount == null) {
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
	
	// 요청값 디버깅
	System.out.println("addGoodsAction - category = " + category);
	System.out.println("addGoodsAction - title = " + title);
	System.out.println("addGoodsAction - amount = " + amount);
	System.out.println("addGoodsAction - content = " + content);
	System.out.println("addGoodsAction - price = " + price);
	
	
%>

<!-- Controller Layer -->
<%
	String addSql = "INSERT INTO goods(category, emp_id, goods_title, goods_content, goods_price, goods_amount) "
					+"VALUES (?, ?, ?, ?, ?, ?)";
	
	Connection conn = common.DBConnection();
	ResultSet rs = null;
	PreparedStatement stmt = null;
	Model model = new Model();
	
	HashMap<Integer, Object> addMap = new HashMap<Integer, Object>();
	addMap.put(1, category);
	addMap.put(2, (String)(loginMember.get("empId")));
	addMap.put(3, title);
	addMap.put(4, content);
	addMap.put(5, Integer.parseInt(price));
	addMap.put(6, Integer.parseInt(amount));

	int row = model.addQry(conn, rs, stmt, addSql, addMap);
	
	
	if(row == 1) {
		// 상품 등록 성공
		System.out.println("상품 등록 성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		// 상품 등록 실패
		System.out.println("상품 등록 실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}
	
%>