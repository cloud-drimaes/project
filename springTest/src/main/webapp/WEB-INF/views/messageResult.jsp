<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@page import = "java.util.Enumeration"%>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" type="text/javascript"></script>
<!-- chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/lodash@4.17.20/lodash.min.js"></script>

<html>
<head>
<meta charset="UTF-8">
<title>chart</title>
<script type="text/javascript">
	var graphChart;
	let labelData_ms;
	var labelData;  
	var featureData;
	
	var labelData_uniq;
	var featureData_uniq;
	function arrayToList(arr) {
		labelData_uniq=[];
		featureData_uniq=[];
		for (let i = 0; i<arr.length;i++){
			labelData_uniq.push(arr[i].time);
			featureData_uniq.push(arr[i].value);
		}
	}
	//깊은복사를 위한 재귀함수 정의
	function cloneObject(obj) {
		  var clone = {};
		  for (var key in obj) {
		    if (typeof obj[key] == "object" && obj[key] != null) {
		      clone[key] = cloneObject(obj[key]);
		    } else {
		      clone[key] = obj[key];
		    }
		  }
		  return clone;
		}
	

	function timeSet(){
		 var labelData_mod = Object.values(labelData_ms);
		 
        var ch1 = document.input.ms.checked;
        var ch2 = document.input.s.checked;
        var ch3 = document.input.m.checked;
        
        var objArray=[];
         
        if(ch1){
        	console.log(labelData_mod)
        	graphChart.data.labels=labelData_mod;
    		graphChart.data.datasets[0].data = featureData;
        	graphChart.update();
        }
        else if(ch2){
        		console.log(labelData_mod.length)
        		for(let i =0;i<labelData_mod.length;i++) {
        			var data_obj = {};
        			labelData_mod[i] = Math.round(labelData_mod[i] / 1000);
        			data_obj.time = labelData_mod[i];
        			data_obj.value = featureData[i];
        			objArray.push(data_obj);
        		}
        		//time기준으로 중복제거
        		objArray = _.uniqBy(objArray,"time")
       		arrayToList(objArray);
        		graphChart.data.labels=labelData_uniq;
        		graphChart.data.datasets[0].data = featureData_uniq;
        		console.log(labelData_uniq)
        		console.log(graphChart.data.datasets)
        		graphChart.update();       		
        }else if(ch3){
    		for(let i =0;i<labelData_mod.length;i++) {
    			var data_obj = {};
    			labelData_mod[i] = Math.round(labelData_mod[i] / (1000*60));
    			data_obj.time = labelData_mod[i];
    			data_obj.value = featureData[i];
    			objArray.push(data_obj);
    		}
    		//time기준으로 중복제거
    		objArray = _.uniqBy(objArray,"time")
   			arrayToList(objArray);
    		graphChart.data.labels=labelData_uniq;
    		//데이터 추가:
    		//graphChart.data.datasets.push(featureData_uniq)
    		graphChart.data.datasets[0].data = featureData_uniq;
    		console.log(objArray);
    		console.log(graphChart.data.datasets)
    		graphChart.update();   
        }
        
        }
	
    function chart(chartId){      	
                     	
        if(chartId=="pro1"){
        	labelData= rpmTimeList
        	featureData= rpmList
        	chartName="Engine RPM"
        }else if(chartId=="pro2"){
        	labelData= fuelTimeList
        	featureData= fuelList
        	chartName="Fuel Level"
        }else if(chartId=="pro3"){
        	labelData= speedTimeList
        	featureData= speedList
        	chartName="Vehicle Speed"
        }
        labelData_ms = cloneObject(labelData); //깊은복사
        var context = document.getElementById('myChart');

        if(graphChart!==undefined){
        	console.log("destroy")
        	graphChart.destroy()
        }
        graphChart = new Chart(context,{
			type:"line",
			options:{
				title:{
					display: true,
					text:chartName
				},
				legend:{
					display:false
				}
			},
			data:{
				labels:labelData,
				datasets: [{
					data: featureData,
					//label: "fuelLevel",
					borderColor:"#3e95cd",
					fill: false
				}]
			}
		});
    	
    }
</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp" />
	<div class="chartBox" style="width: 1200px; height: 500px;float:right; margin-right:30px;">
	    <form name="input" method = "POST" >
	        <h2>차량 모니터링 </h2>
	            <div style="width: 1000px; height:20px;float:right;">	        		
	            <input type="radio" name="chart_choice" id="pro1" value="s" onclick="chart(this.id)" >EnginRpm
	            <input type="radio" name="chart_choice" id="pro2" value="m" onclick="chart(this.id)" >fuelLevel
	            <input type="radio" name="chart_choice" id="pro3" value="l" onclick="chart(this.id)" >Vehicle Speed</div>
	            <div style="width: 1000px; height: 500px;margin-right:30;float:right"><canvas id="myChart"></canvas></div>
	            <div style="width: 100px; height:210px;margin-top:200px;margin-left:30;float:left">
	            <label><input type="radio" name="time_set" id="ms" onclick="timeSet()" style="margin:0;vertical-align:middle;" checked>Millisecond</label>
	            <label><input type="radio" name="time_set" id="s" onclick="timeSet()" style="margin-right:10px;vertical-align:middle;">Second</label>
	            <label><input type="radio" name="time_set" id="m" onclick="timeSet()" style="margin:0;vertical-align:middle;">Minute</label>
	            </div>
	    </form>
	</div>
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
        <c:set var="route" value="${message}" />
        <c:forEach items="${infoList}" var="info">
        <c:set var="infoRoute" value="${info.route}" />
        <c:if test="${infoRoute eq route}" >
	        <tr>
	            <td bgcolor="gray">운전자</td>
	            <td>${info.driver}</td>
	            <td bgcolor="gray">경로ID</td>
        	     <td>${info.route}</td>
	        </tr>
	         <tr>
	            <td bgcolor="gray">운행일자</td>
	             <c:set var="driveDate" value="${info.UTCdate}"/>
	            <td>${fn:substring(driveDate,0,6)}</td>
	            <td bgcolor="gray">운행 시작시간</td>
	            <c:set var="driveTime" value="${info.UTCtime}"/>
	            <td>${fn:substring(driveTime,0,6)}</td>
	        </tr>
	     </c:if>
        </c:forEach>
    </tbody>
	</table>  
</body>
</html>
<script type="text/javascript">

			$(document).ready(function(){
				getGraph()
			})
			let rpmTimeList = [];
			let rpmList = [];
			var rpm_route = "${message}";
			console.log("rpm_route:",rpm_route)
			function getGraph(){

			
				$.ajax({
					url:"http://localhost:58080/gsonList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						for (let i = 0; i<data.length;i++){
							if (data[i].route == rpm_route){	
								rpmTimeList.push(data[i].time);
								rpmList.push(data[i].rpm);
							}
						}
						console.log("timeList")
						console.log("rpmlList")
					},
					error:function(request,status,error,data){
						alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
					}
				})//ajax
			}//getGraph
</script>
<script type="text/javascript">

			$(document).ready(function(){
				getGraph2()
			})
			let fuelTimeList = [];
			let fuelList = [];
			var fuel_route = "${message}";
			console.log("fuel_route:",fuel_route)
			function getGraph2(){

				$.ajax({
					url:"http://localhost:58080/fuelList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						for (let i = 0; i<data.length;i++){
							if (data[i].route == fuel_route){
								fuelTimeList.push(data[i].time);
								fuelList.push(data[i].Fuel);
							}
						}
						console.log("fuelTimeList")
						console.log("fuelList")
					},
					error:function(request,status,error,data){
						alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
					}
				})//ajax
			}//getGraph
</script>
<script type="text/javascript">

			$(document).ready(function(){
				getGraph3()
			})
			let speedTimeList = [];
			let speedList = [];
			var speed_route = "${message}";
			console.log("para_speed  ",speed_route)
			function getGraph3(){

			
				$.ajax({
					url:"http://localhost:58080/speedList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						for (let i = 0; i<data.length;i++){
							if (data[i].route == speed_route){
								speedTimeList.push(data[i].time);
								speedList.push(data[i].speed);
						}
						}
						console.log("speedTimeList")
						console.log("speedList")
					},
					error:function(request,status,error,data){
						alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
					}
				})//ajax
			}//getGraph
</script>