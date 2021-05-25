<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시물 수정</title>
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
	
	<form role="form" method="post">
		<p>
			<label for="bno">글 번호</label>
			<input type="text" id="bno" name="bno" value="${modify.bno}" readonly="readonly" />
		</p>
		
		<p>
			<label for="title">제목</label>
			<input type="text" id="title" name="title" value="${modify.title}" />
		</p>
		<p>
			<label for="writer">작성자</label>
			<input type="text" id="writer" name="writer" value="${modify.writer}" readonly="readonly" /><br />
			<label>작성일</label><span><fmt:formatDate value="${modify.regDate}" pattern="yyyy-MM-dd" /></span>
		</p>
		<p>
			<label for="content">내용</label>
			<textarea id="content" name="content" >${modify.content}</textarea>
		</p>
		<p>
			<button type="submit">수정완료</button>
			<button id="cancel_btn">취소</button>
			
			<script>
			// 폼을 변수에 저장
			var formObj = $("form[role='form']");

			// 취소 버튼 클릭
			$("#cancel_btn").click(function() {
				formObj.attr("action", "/board/view?bno=" + $("#bno").val());
				formObj.attr("method", "get");  
				formObj.submit();
			});
			</script>
			
		</p>	
	</form>		
	
		<footer>
			<%@ include file="include/footer.jsp" %>
		</footer>
		
	</body>
</html>