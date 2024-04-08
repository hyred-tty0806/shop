<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="dropdown">
	<a class="btn btn-secondary dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		<% if(rowPerPage == 10) { %> 10개씩 보기 <% } %>
		<% if(rowPerPage == 30) { %> 30개씩 보기 <% } %>
		<% if(rowPerPage == 50) { %> 50개씩 보기 <% } %>
		<% if(rowPerPage == 100) { %> 100개씩 보기 <% } %>
	</a>
	<ul class="dropdown-menu">
		<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=10&category=<%=category%>">10개씩 보기</a></li>
		<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=30&category=<%=category%>">30개씩 보기</a></li>
		<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=50&category=<%=category%>">50개씩 보기</a></li>
		<li><a class="dropdown-item" href="<%=pageingUrl %>?currentPage=<%=currentPage %>&rowPerPage=100&category=<%=category%>">100개씩 보기</a></li>
	</ul>
</div>
