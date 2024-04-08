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
	// 요청 값 분석
	String no = request.getParameter("no");
	String filename = request.getParameter("filename");
	
	System.out.println("no : " + no);
	System.out.println("filename : " + filename);
%>
<!-- Model Layer -->
<%
	String deleteSql = "DELETE FROM goods WHERE goods_no = ?";
	Model model = new Model();
	int row = model.deleteQry(deleteSql, no);
	System.out.println("row : " + row);
	String filePath = request.getServletContext().getRealPath("upload");
	File df = new File(filePath, filename);
	df.delete();

	if(row == 1) {
		// 상품 등록 성공
		System.out.println("상품 삭제 성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		// 상품 등록 실패
		System.out.println("상품 삭제 실패");
		response.sendRedirect("/shop/emp/goodsOne.jsp?no="+no);
	} 
%>