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
	
	HashMap<Integer, Object> qryParamMap = new HashMap<Integer, Object>();
	ArrayList<HashMap<String, Object>> categoryList 
		= EmpDAO.selectGooodsListGroupByCategory(request, qryParamMap);
	ArrayList<HashMap<String, Object>> list 
		= EmpDAO.selectGoodsList(request, qryParamMap);
	System.out.println("list : " + list);
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
							<div class="col  mx-1 my-1">


								<div id="carouselExampleCaptions" class="carousel slide">
									<div class="carousel-indicators">
										<button type="button"
											data-bs-target="#carouselExampleCaptions"
											data-bs-slide-to="0" class="" aria-label="Slide 1"></button>
										<button type="button"
											data-bs-target="#carouselExampleCaptions"
											data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
										<button type="button"
											data-bs-target="#carouselExampleCaptions"
											data-bs-slide-to="2" aria-label="Slide 3" class="active"
											aria-current="true"></button>
									</div>
									<div class="carousel-inner">
										<div class="carousel-item">
											<svg
												class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
												width="800" height="400" xmlns="http://www.w3.org/2000/svg"
												role="img" aria-label="Placeholder: First slide"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#777"></rect>
												<text x="50%" y="50%" fill="#555" dy=".3em">First slide</text></svg>
											<div class="carousel-caption d-none d-md-block">
												<h5>First slide label</h5>
												<p>Some representative placeholder content for the first
													slide.</p>
											</div>
										</div>
										<div class="carousel-item">
											<svg
												class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
												width="800" height="400" xmlns="http://www.w3.org/2000/svg"
												role="img" aria-label="Placeholder: Second slide"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#666"></rect>
												<text x="50%" y="50%" fill="#444" dy=".3em">Second slide</text></svg>
											<div class="carousel-caption d-none d-md-block">
												<h5>Second slide label</h5>
												<p>Some representative placeholder content for the
													second slide.</p>
											</div>
										</div>
										<div class="carousel-item active">
											<svg
												class="bd-placeholder-img bd-placeholder-img-lg d-block w-100"
												width="800" height="400" xmlns="http://www.w3.org/2000/svg"
												role="img" aria-label="Placeholder: Third slide"
												preserveAspectRatio="xMidYMid slice" focusable="false">
												<title>Placeholder</title><rect width="100%" height="100%"
													fill="#555"></rect>
												<text x="50%" y="50%" fill="#333" dy=".3em">Third slide</text></svg>
											<div class="carousel-caption d-none d-md-block">
												<h5>Third slide label</h5>
												<p>Some representative placeholder content for the third
													slide.</p>
											</div>
										</div>
									</div>
									<button class="carousel-control-prev" type="button"
										data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
										<span class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Previous</span>
									</button>
									<button class="carousel-control-next" type="button"
										data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
										<span class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="visually-hidden">Next</span>
									</button>
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
						<div class="row">
							<div class="col  mx-1 my-1">
								<div class="row">
									<div class="col  mx-1 my-1">
										<div class="row">

											

											
							<%
								for (HashMap<String, Object> m : list) {
							%>			
									<div class="col  mx-1 my-1">
										<div class="card" style="width: 18rem;">
											<img src="/shop/upload/<%=m.get("filename")  %>" class="card-img-top" style="height: 50% !important;"
												alt="...">
											<div class="card-body">
												<p class="card-text">
												<%=m.get("category")  %>
												<br>
												<a href="/shop/shop/shopOneForm.jsp?no=<%=m.get("no") %>">
												<%=m.get("title")  %>
												</a>
												<br>
												<%=m.get("price")  %>
												<br>
												<%=m.get("amount")  %>
												</p>
											</div>
										</div>
									</div>
							<% 
								}
							%>

										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col  mx-1 my-1">
								<div class="row">
									<div class="d-flex justify-content-center">
										<div class=" mx-1 my-1 pagination-item">[<<]</div>
										<div class=" mx-1 my-1 pagination-item">[<]</div>
										<div class=" mx-1 my-1 pagination-item">1</div>
										<div class=" mx-1 my-1 pagination-item">2</div>
										<div class=" mx-1 my-1 pagination-item">3</div>
										<div class=" mx-1 my-1 pagination-item">4</div>
										<div class=" mx-1 my-1 pagination-item">5</div>

										<div class=" mx-1 my-1 pagination-item">6</div>
										<div class=" mx-1 my-1 pagination-item">7</div>
										<div class=" mx-1 my-1 pagination-item">8</div>
										<div class=" mx-1 my-1 pagination-item">9</div>
										<div class=" mx-1 my-1 pagination-item">10</div>
										<div class=" mx-1 my-1 pagination-item">[>]</div>
										<div class=" mx-1 my-1 pagination-item">[>>]</div>
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
