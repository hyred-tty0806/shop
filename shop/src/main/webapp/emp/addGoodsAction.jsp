<%@page import="java.nio.file.Files"%>
<%@page import="java.io.File"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Controller Layer -->
<%
	//인증분기 : 세션변수 이름 - loginEmp
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
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
	
	Part part = request.getPart("goodsImg");
	String oriName = part.getSubmittedFileName();
	// 원본이름에서 확장자만 분리
	int dotIdx = oriName.lastIndexOf(".");
	String exe = oriName.substring(dotIdx); // .png
	
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString().replace("-", "");
	filename = filename + exe;	
	// 요청값 디버깅
	System.out.println("addGoodsAction - category = " + category);
	System.out.println("addGoodsAction - title = " + title);
	System.out.println("addGoodsAction - amount = " + amount);
	System.out.println("addGoodsAction - content = " + content);
	System.out.println("addGoodsAction - price = " + price);
	
	

	
	String addSql = "INSERT INTO goods(category, filename, emp_id, goods_title, goods_content, goods_price, goods_amount) "
					+"VALUES (?, ?, ?, ?, ?, ?, ?)";
	
	Connection conn = common.DBConnection();
	ResultSet rs = null;
	PreparedStatement stmt = null;
	Model model = new Model();
	
	HashMap<Integer, Object> addMap = new HashMap<Integer, Object>();
	addMap.put(1, category);
	addMap.put(2, filename);
	addMap.put(3, (String)(loginMember.get("empId")));
	addMap.put(4, title);
	addMap.put(5, content);
	addMap.put(6, Integer.parseInt(price));
	addMap.put(7, Integer.parseInt(amount));

	int row = model.addQry(addSql, addMap);
	
	if(row == 1){
		InputStream inputStream = part.getInputStream(); // part객체안에 파일(바이너리)을 메모로리 불러 옴

		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename);
		OutputStream outputStream = Files.newOutputStream(f.toPath()); // os + file
		inputStream.transferTo(outputStream);
		outputStream.close();
		inputStream.close();
	}
	/* 	
		File df = new File(filePath, rs.getString("filename"));
		df.delete();
	*/
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