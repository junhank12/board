<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시물 작성</title>
	</head>
	
	<body>

		<header>
			<%@ include file="include/header.jsp" %>
		</header>
		<hr />		
		<nav>
			<%@ include file="include/nav.jsp" %>
		</nav>
		<hr />

		<section id="container">
		
		<c:if test="${msg == null}">
			<form role="form" method="post" autocomplete="off">
				<p>
					<label for="title">제목</label>
					<input type="text" name="title" /><br />
				</p>
				<p>
					<label for="writer">작성자</label>
					<input type="text" name="writer" value="${member.userName}" readonly="readonly"/><br />
				</p>
				<p>
					<label for="content">내용</label>
					<textarea cols="50" rows="5" name="content"></textarea><br />
				</p>
				<p>
					<button type="submit">작성</button>
				</p>
			</form>
		</c:if>
		
		<c:if test="${msg == 'login_error'}">
			<p>로그인을 하셔야 글을 작성할 수 있습니다.</p>
			
			<p><a href="/">홈으로</a></p>
		</c:if>		
		</section>
		
		<footer>
			<%@ include file="include/footer.jsp" %>
		</footer>
			
	</body>
</html>