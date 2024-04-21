<%@page import="shop.dao.CusDAO"%>
<%@page import="shop.dao.EmpDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="shop.Model"%>
<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	Common common = new Common();
	if (common.customerLoginCheck("cusLogin", request, response) == 0) {}
	
	
	String no = request.getParameter("no");
	
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>();
	ArrayList<HashMap<String, Object>> categoryList 
		= EmpDAO.selectGooodsListGroupByCategory(request, qryParamMap);
	qryParamMap.put(1, no);
	HashMap<String, Object> resultMap 
		= CusDAO.selectGoodsOneByNo(qryParamMap);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>sample</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Jacquard+24&family=Jacquarda+Bastarda+9+Charted&family=Jersey+20+Charted&family=Merriweather:ital,wght@0,300;0,400;0,700;0,900;1,300;1,400;1,700;1,900&family=Platypi:ital,wght@0,300..800;1,300..800&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Jersey+10&family=Roboto+Mono:ital,wght@0,100..700;1,100..700&family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
	rel="stylesheet">
<link href="/shop/style/shop.css" rel="stylesheet" type="text/css" />
</head>
<body class="merriweather-bold">
	<div class="container-fluid ">
		<!-- Content here -->
		<div class="row">
			<div class="col-12 ">
				<!-- 최상단 -->
				<%@ include file="/common/shopMenu.jsp"%>
				<!-- 최상단 -->

				<!-- 콘텐츠 -->
				<div class="row">
					<!-- 좌측 사이드 -->
					<div class="col-2  mx-1 my-1">
						CATEGORY
						<ul>
							<%
								for (HashMap<String, Object> m : categoryList) {
							%>
									<li><%=m.get("category")%>(<%=m.get("cnt")%>)</li>
							<%
								}
							%>
						
						</ul>
					</div>
					<!-- 좌측 사이드 -->

					<!-- 메인콘텐츠 -->
					<div class="col  mx-1 my-1">
						<div class="row">
							<div class="col mx-1 my-1">
								<img src="/shop/upload/<%=resultMap.get("filename") %>" style="width: 100%;">
							</div>
							<div class="col mx-1 my-1">
								<table>
								<tr>
									<td>title</td>
									<td>&nbsp;&nbsp;&nbsp;</td>
									<td><%=resultMap.get("goodsTitle") %></td>
								</tr>
								<tr>
									<td>category</td>
									<td></td>
									<td><%=resultMap.get("category") %></td>
								</tr>
								<tr>
									<td>amount</td>
									<td></td>
									<td><%=resultMap.get("goodsAmount") %></td>
								</tr>
								<tr>
									<td>price</td>
									<td></td>
									<td><%=resultMap.get("goodsPrice") %></td>
								</tr>
								<tr>
									<td>descrtion</td>
									<td></td>
									<td><%=resultMap.get("goodsContent") %></td>
								</tr>
								</table>
							</div>
						</div>
						<div class="row">
							<div class="col  mx-1 my-1">
								<div class="row">
									<div class="col mx-1 my-1"></div>
									<div class="col mx-1 my-1">
									</div>
									<div class="col mx-1 my-1">
										<a href="/shop/shop/buyAction.jsp?no=<%=no %>" class="btn btn-success">BUY</a>
										<a href="#" class="btn btn-success">LIST</a>
									</div>
								</div>
							</div>
						</div>


						<div class="row">
							<div class="col  mx-1 my-1">
								<div class="row">
									<div class="col bg-info mx-1 my-1"></div>
									<div class="col bg-info mx-1 my-1"></div>
									<div class="col bg-info mx-1 my-1"></div>
								</div>
							</div>
						</div>
					</div>
					<!-- 메인콘텐츠 -->

					<!--  우측 사이드 -->
					<div class="col-1  mx-1 my-1"></div>
					<!-- 우측 사이드 -->


				</div>
				<!-- 콘텐츠 -->



				<!-- 최하단 -->
				<div class="row">
					<div class="col  mx-1 my-1 hhj-footer" style="height: 10vh;">contact
						: 02-0000-0000</div>
				</div>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
</body>
</html>
