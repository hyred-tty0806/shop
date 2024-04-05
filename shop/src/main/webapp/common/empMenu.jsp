<%@page import="shop.Common"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar bg-dark fixed-top navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
	  <div class="container-fluid">
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarTogglerDemo01" aria-controls="navbarTogglerDemo01" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarTogglerDemo01">
			<a class="navbar-brand" href="./empList.jsp">EMPLOYEE</a>
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/shop/emp/empList.jsp">사원관리</a>
				</li>
				<!-- category CRUD -->
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/shop/emp/categoryList.jsp">카테고리관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/shop/emp/goodsList.jsp">상품관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="/shop/emp/empLogout.jsp">로그아웃</a>
				</li>
				<li class="nav-item">
					<a class="nav-link active" aria-current="page" href="#">
						[ <%=empName %> ] 님 반갑니다.
					</a>
				</li>
			</ul>
	    </div>
	  </div>
</nav>