<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시판</title>
</head>
<body>
	<p>${serverTime}</p>
	
	<p><a href="/board/listPageSearch?num=1">게시물 목록</a></p>
	<p><a href="/board/write">게시물 작성</a></p>
</body>
</html>
