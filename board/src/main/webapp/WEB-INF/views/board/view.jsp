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
		
			<section id="container">
			<form role="form" method="post">			
				<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly" />
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly" />
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly" />
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly" />
				
				<div class="form-group">
					<label for="bno" class="control-label">글 번호</label>
					<input type="text" id="bno" name="bno" class="form-control" value="${view.bno}" readonly="readonly" />
				</div>
			</form>
			
				<div class="form-group">
					<label for="title" class="control-label">제목</label>
					<input type="text" id="title" name="title" class="form-control" value="${view.title}" readonly="readonly" />
				</div>
				<div class="form-group">
					<label for="writer" class="control-label">작성자</label>					
					<input type="text" id="writer" name="writer" class="form-control" value="${view.writer}" readonly="readonly" /><br />
				</div>
				<div class="form-group">
					<label class="control-label">작성일</label>
					<span><fmt:formatDate value="${view.regDate}" pattern="yyyy-MM-dd" /></span>
				</div>
				<div class="form-group">
					<label for="content" class="control-label">내용</label>
						<textarea id="content" name="content" class="form-control" readonly="readonly">${view.content}</textarea>
				</div>
				
				<div>
					
					<div class="form-group">
						<button type="button" id="list_btn" class="btn btn-primary">목록</button>
						<button type="button" id="modify_btn" class="btn btn-warning">수정</button>
						<button type="button" id="delete_btn" class="btn btn-danger">삭제</button>
					</div>
					
					<script>
						// 폼을 변수에 저장
						var formObj = $("form[role='form']");
						
						// 목록 버튼 클릭
						$("#list_btn").click(function(){		
							self.location = "/board/listSearch?"
									+ "page=${scri.page}&perPageNum=${scri.perPageNum}"
									+ "&searchType=${scri.searchType}&keyword=${scri.keyword}";
						});
	
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
			<hr />
			
		<!-- 댓글 시작 -->
		<div>
			<ol>
			<c:forEach items="${repList}" var="repList">
				<li>
					<p>
					<span class="glyphicon glyphicon-user"></span>
						${repList.writer}
						(<fmt:formatDate value="${repList.regDate}" pattern="yyyy-MM-dd" />)
					</p>
					
					<p class="bg-info">${repList.content}</p>
					
					<div class="form-group">
							<button type="button" class="replyUpdate btn btn-warning btn-xs" data-rno="${repList.rno}">수정</button>
							<button type="button" class="replyDelete btn btn-warning btn-xs" data-rno="${repList.rno}">삭제</button>
						 
							<script>
							$(".replyUpdate").click(function() {
								self.location = "/board/replyUpdate?bno=${view.bno}"
												+ "&page=${scri.page}"
												+ "&perPageNum=${scri.perPageNum}"
												+ "&searchType=${scri.searchType}"
												+ "&keyword=${scri.keyword}"
												+ "&rno=" + $(this).attr("data-rno");
							});
	
							$(".replyDelete").click(function() {
								self.location = "/board/replyDelete?bno=${view.bno}"
												+ "&page=${scri.page}"
												+ "&perPageNum=${scri.perPageNum}"
												+ "&searchType=${scri.searchType}"
												+ "&keyword=${scri.keyword}"
												+ "&rno=" + $(this).attr("data-rno");
							});
							</script>
					</div>
				</li>
			</c:forEach>
			</ol>
			
			<section class="replyForm">
			<form role="form" method="post" autocomplete="off" class="form-horizontal">
	
				<input type="hidden" id="bno" name="bno" value="${view.bno}" readonly="readonly" />
				<input type="hidden" id="page" name="page" value="${scri.page}" readonly="readonly" />
				<input type="hidden" id="perPageNum" name="perPageNum" value="${scri.perPageNum}" readonly="readonly" />
				<input type="hidden" id="searchType" name="searchType" value="${scri.searchType}" readonly="readonly" />
				<input type="hidden" id="keyword" name="keyword" value="${scri.keyword}" readonly="readonly" />
	
				<div class="form-group">
					<label for="writer" class="col-sm-2 control-label">작성자</label>
					<div class="col-sm-10">
						<input type="text" id="writer" name="writer" class="form-control" />
					</div>
				</div>
				
				<div class="form-group">
					<label for="content" class="col-sm-2 control-label">댓글 내용</label>
					<div class="col-sm-10">
						<textarea id="content" name="content" class="form-control"></textarea>
					</div>
				</div>
				
				<div class="form-group">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="button" class="repSubmit btn btn-success">작성</button>
					</div>
					
					<script>
					var formObj = $(".replyForm form[role='form']");
	        
					$(".repSubmit").click(function() {
						formObj.attr("action", "replyWrite");
						formObj.submit();
					});
					</script>
				</div>
			</form>
			</section>			
		</div>
		<!-- 댓글 끝 -->
		
			<footer>
				<%@ include file="include/footer.jsp" %>
			</footer>
		</div>
	</body>
</html>