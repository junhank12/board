<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>게시물 목록</title>
		
		<!-- jQuery -->
		<script src='https://code.jquery.com/jquery-3.3.1.min.js'></script>
		
		<!-- 합쳐지고 최소화된 최신 CSS -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
		
		<!-- 부가적인 테마 -->
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
		
		<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	</head>
	
	<body>
		<div class="container">
			<header>
				<%@ include file="include/header.jsp" %>
			</header>
			<hr />		
			<nav>
				<%@ include file="include/nav.jsp" %>
			</nav>
			<hr />
		
		<section>
		<table class="table table-hover">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성일</th>
					<th>작성자</th>
					<th>조회수</th>
				</tr>
			</thead>
			
			<tbody>
				<!-- 목록 시작 -->
				<c:forEach items="${list}" var="list">
					<tr>
						<td>${list.bno}</td>
						<td>
							<a href="/board/view?bno=${list.bno}&
												page=${scri.page}&
												perPageNum=${scri.perPageNum}&
												searchType=${scri.searchType}&
												keyword=${scri.keyword}">${list.title}</a>						
						</td>
						<td>
							<fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd" />
						</td>
						<td>${list.writer}</td>
						<td>${list.viewCnt}</td>
					</tr>
				</c:forEach>
				<!-- 목록 끝 -->
			</tbody>				
		</table>

		<div class="search row">
			<div class="col-xs-2 col-sm-2">
				<select name="searchType" class="form-control">
					<option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
					<option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					<option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					<option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					<option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>
				</select>
			</div>
			
			<div class="col-xs-10 col-sm-10">
				<div class="input-group">
					<input type="text" name="keyword" id="keywordInput" class="form-control" value="${scri.keyword}"/>
					<span class="input-group-btn">
						<button id="searchBtn" class="btn btn-default">검색</button>
					</span>
				</div>
			</div>

			<script>
			$(function(){
				$('#searchBtn').click(function() {
					self.location = "listSearch"
						+ '${pageMaker.makeQuery(1)}'
						+ "&searchType="
						+ $("select option:selected").val()
						+ "&keyword="
						+ encodeURIComponent($('#keywordInput').val());
				});
			});
			</script>
		</div>	
	
	<div class="col-md-offset-3">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li><a href="listSearch${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
			</c:if>

			<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
				<li <c:out value="${pageMaker.cri.page == idx ? 'class=active' : ''}"/>>
				<a href="listSearch${pageMaker.makeSearch(idx)}">${idx}</a></li>
			</c:forEach>
			
			<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
			<li><a href="listSearch${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
			</c:if> 
		</ul>
	</div>
	
		<footer>
		<%@ include file="include/footer.jsp" %>
		</footer>
		
		</section>
		</div>
	</body>
</html>