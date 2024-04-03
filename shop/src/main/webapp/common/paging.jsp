<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 페이지 버튼 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination justify-content-center">
			<% 
				if(currentPage > 1){
			%>
					<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=1">FIRST</a></li>
					<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=<%=currentPage-1%>">PREV</a></li>
			<%
				}else{
			%>
					<li class="page-item"><a class="page-link" href="#">FIRST</a></li>
					<li class="page-item"><a class="page-link" href="#">PREV</a></li>						
			<% 
				}
			%>
				 <li class="page-item"><a class="page-link" href="#"><%=currentPage%></a></li>
			<%
				if(currentPage < lastPage){	
			%>
			   		<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=<%=currentPage+1%>">NEXT</a></li>
				 	<li class="page-item"><a class="page-link" href="<%=pageingUrl %>?currentPage=<%=lastPage%>">LAST</a></li>
			<% 
				}else{
			%>
			   		<li class="page-item"><a class="page-link" href="#">NEXT</a></li>						
				 	<li class="page-item"><a class="page-link" href="#">LAST</a></li>
			<% 
				}
			%>
		</ul>
	</nav>