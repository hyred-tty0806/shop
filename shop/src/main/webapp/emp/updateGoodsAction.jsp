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
	Common common = new Common();
	int resultInt = common.loginCheck("out", request, response);
	if(resultInt == 0){
		return;
	}
	String empName = common.getSessionInfo("empName", request, response);
	int no = Integer.parseInt(request.getParameter("no"));
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
	if(category == null || title == null || amount == null || 
			content == null || price == null) {
		response.sendRedirect("/shop/emp/goodsOne.jsp");
	}
	
	Part part = request.getPart("goodsImg");
	String oriName = part.getSubmittedFileName();
	System.out.println("oriName : " + oriName);
	// 원본이름에서 확장자만 분리
	int dotIdx = (oriName.lastIndexOf("."));
	String filename = "";
	if(dotIdx != -1){
/* 		String exe = ".png"; // .png
		filename = "default" + exe;		  */
		String exe = oriName.substring(dotIdx); // .png				
		UUID uuid = UUID.randomUUID();
		filename = uuid.toString().replace("-", "");
		filename = filename + exe;	
	}
		
	// 요청값 디버깅
	System.out.println("addGoodsAction - category = " + category);
	System.out.println("addGoodsAction - filename = " + filename);
	System.out.println("addGoodsAction - empId = " + (String)(loginMember.get("empId")));
	System.out.println("addGoodsAction - title = " + title);
	System.out.println("addGoodsAction - amount = " + amount);
	System.out.println("addGoodsAction - content = " + content);
	System.out.println("addGoodsAction - price = " + price);
	
	String filenameOfPart = (dotIdx == -1) ? "" : ", filename = ? ";
	String updateSql = "UPDATE goods SET "
					+ "emp_id = ?, category = ? "
					+ filenameOfPart
					+ ", goods_title = ?, goods_amount = ?, goods_content = ? , goods_price = ? "
					+ " WHERE goods_no = ?";				
	

	
	List<String> list = new ArrayList<>(Arrays.asList(
				(String)(loginMember.get("empId")), category, filename, title, amount, content, price, ""+no
			));
	list.removeAll(Collections.singleton(""));
	System.out.println(list);
	
	Model model = new Model();
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>();
	for(int i = 0; i < list.size(); i++){
		System.out.println(list.get(i));
		System.out.println(i);
		qryParamMap.put(i+1, list.get(i));
	}

	int row = model.updateQry(updateSql, qryParamMap);
	
	if(row == 1){
		if(dotIdx != -1){
			InputStream inputStream = part.getInputStream(); // part객체안에 파일(바이너리)을 메모로리 불러 옴
			String filePath = request.getServletContext().getRealPath("upload");
			File f = new File(filePath, filename);
			OutputStream outputStream = Files.newOutputStream(f.toPath()); // os + file
			inputStream.transferTo(outputStream);
			outputStream.close();
			inputStream.close();			
		}
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
		response.sendRedirect("/shop/emp/updateGoodsForm.jsp?no="+no);
	}
%>