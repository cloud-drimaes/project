<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>Home</title>
</head>
<body>
<form action="regist" method="post">
<c:if test="${!empty infoList}" >
   <select name="selectBox" style="width:200px; margin:30px;float:left" onchange="selectRoute(this)">
   		  <option value='abc'>선택안함</option>
      <c:forEach var="infoList" items="${infoList}" varStatus="i">
         <option value="${infoList.route}">${infoList.route}</option>
      </c:forEach>
   </select>
</c:if>
<button type="submit" style="width:50x; margin-left:200px;margin-top:30px;float:left">확인</button>
</form>

<table  style="width: 500px; height: 300px;margin: 30px; ">
    <tbody>
	        <tr>
	            <td bgcolor="gray">운전자</td>
	            <td></td>
	            <td bgcolor="gray">경로ID</td>
        	     <td></td>
	        </tr>
	         <tr>
	            <td bgcolor="gray">운행일자</td>
	            <td></td>
	            <td bgcolor="gray">운행 시작시간</td>
	            <td></td>
	        </tr>           
    </tbody>
</table>
 
<!-- 
<table style="width: 500px; height: 300px;margin: 30px; " >
    <tbody>
         <tr>
            <td bgcolor="gray">트립ID</td>
            <td>#277</td>
            <td bgcolor="gray">날짜</td>
            <td>220117</td>
        </tr>
         <tr>
            <td bgcolor="gray">차량번호 </td>
            <td>11라1234</td>
            <td bgcolor="gray">주행거리 </td>
            <td>32km</td>
        </tr>
    </tbody>
</table> 
 -->
</body>
</html>

