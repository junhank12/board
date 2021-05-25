<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시물 조회</title>
		
		<!-- jQuery -->
		<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
		
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
		<form role="form" method="post">
			<p>
				<label for="bno">글 번호</label>
				<input type="text" id="bno" name="bno" value="${view.bno}" readonly="readonly" />
			</p>
		</form>		
			<p>
				<label for="title">제목</label>
				<input type="text" id="title" name="title" value="${view.title}" readonly="readonly" />
			</p>
			<p>
				<label for="writer">작성자</label>
				<input type="text" id="writer" name="writer" value="${view.writer}" readonly="readonly" /><br />
				<label>작성일</label><span><fmt:formatDate value="${view.regDate}" pattern="yyyy-MM-dd" /></span>
			</p>
			<p>
				<label for="content">내용</label>
				<textarea id="content" name="content" readonly="readonly">${view.content}</textarea>
			</p>
			
			<div>
				<button id="modify_btn">수정</button>
				<button id="delete_btn">삭제</button>
				
				<%-- <a href="/board/modify?bno=${view.bno}">게시물 수정</a> --%>
				<%-- <a href="/board/delete?bno=${view.bno}">게시물 삭제</a> --%>
				
				<script>
					// 폼을 변수에 저장
					var formObj = $("form[role='form']");
			 
					// 수정 버튼 클릭
					$("#modify_btn").click(function(){		
						formObj.attr("action", "/board/modify");
						formObj.attr("method", "get");  
						formObj.submit();		
					});
			
					// 삭제 버튼 클릭
					$("#delete_btn").click(function(){				  
						formObj.attr("action", "/board/delete");
						formObj.attr("method", "get");  
						formObj.submit();
					});
				</script>
			</div>
		</section>
	
	<!-- 댓글 시작 -->
	<hr />

	<ul>
		<c:forEach items="${reply}" var="reply">
			<li>
				<div>
					<p>${reply.writer} / <fmt:formatDate value="${reply.regDate}" pattern="yyyy-MM-dd" /></p>
					<p>${reply.content}</p>
				</div>
			</li>    
		</c:forEach>
	</ul>

	<div>	
	    <form method="post" action="/reply/write">
			<p>
				<label>댓글 작성자</label> <input type="text" name="writer">
			</p>
			<p>
				<textarea rows="5" cols="50" name="content"></textarea>
			</p>
			<p>
				<input type="hidden" name="bno" value="${view.bno}">
				<button type="submit">댓글 작성</button>
			</p>
		</form>	
	</div>
	<!-- 댓글 끝 -->
	
		<footer>
			<%@ include file="include/footer.jsp" %>
		</footer>
	</body>
</html>