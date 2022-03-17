<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="core" uri="http://java.sun.com/jsp/jstl/core" %> 
<!-- 스프링은 따로 라이브러리를 설치하지 않아도 다운 받을 라이브러리를 설정할 수 있다. --> 
<!-- 그 중에 jstl 라이브러리도 있기 때문에 사용할 수 있는것 --> 
<link rel="stylesheet" type="text/css" href="css/common.css"> 
<!-- rel : 형태는 스타일 시트, 타입은 텍스트로된 css --> 
<style> 
header ul, header ul li { 
	margin: 0; 
	padding: 0; 
	display: inline; 
} 

header .category { 
	font-size: 20px; } 
header .category ul li:not(:first-child) { /* 첫번째 li만 빼고 지정 */ 
	padding-left: 100px; 
} 
header .category ul li a:hover, header .category ul li a.active {
	font-weight: bold; 
	color: #0000cd; 
}
header {
	vertical-align: middle;	/* 세로축 가운데 정렬 */
} 
</style> 
<header style="border-bottom: 1px solid #ccc; padding: 15px 0; text-align: left"> 
	<div class="category" style="margin-left: 100px;"> 
		<ul> 
			<li><a href='list.cu'>Main</a></li> 
			<li><a href='list.no'>전체차량 </a></li> 
			<li><a href='list.bo'>개별차량 </a></li> 
			<li><a href='list.da'>안전모니터링 </a></li> 
		</ul> 
	</div> 
</header>
