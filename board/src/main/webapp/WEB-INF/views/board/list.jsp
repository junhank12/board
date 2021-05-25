<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시물 목록</title>
	</head>
	<body>
	<div id="root">	
		<header>
			<%@ include file="include/header.jsp" %>
		</header>
		<hr />
		
		<nav>
			<%@ include file="include/nav.jsp" %>
		</nav>
		<hr />
			
		<section id="container">
			<h2>글 목록</h2>
			<table>
				<thead>
					<tr>
						<th>글번호</th>
						<th>제목</th>
						<th>작성일</th>
						<th>작성자</th>
						<th>조회수</th>
					</tr>
				</thead>
				
				<!-- 목록 시작 -->
				<tbody>
					<c:forEach items="${list}" var="list">
						<tr>
							<td>${list.bno}</td>
							<td>
								<a href="/board/view?bno=${list.bno}">${list.title}</a>						
							</td>
							<td>
								<fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" />
							</td>
							<td>${list.writer}</td>
							<td>${list.viewCnt}</td>
						</tr>
					</c:forEach>
				</tbody>
				<!-- 목록 끝 -->
			</table>
		</section><hr />
	
		<footer>
			<%@ include file="include/footer.jsp" %>
		</footer>
	</div>
	</body>
</html>