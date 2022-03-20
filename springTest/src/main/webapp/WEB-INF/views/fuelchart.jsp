<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 제이쿼리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js" integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg==" crossorigin="anonymous" type="text/javascript"></script>
<!-- chart.js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>


<div style="width: 900px; height: 900px;float:right">
	<!--차트가 그려질 부분-->
	<canvas id="fuelChart2"></canvas>
</div>

<html>
<head>
<title>fuelLevel</title>
</head>
<body>

<script type="text/javascript">

			$(document).ready(function(){
				getGraph3()
			})
			
			function getGraph3(){
				let timeList = [];
				let fuelList = [];
			
				$.ajax({
					url:"http://localhost:58080/fuelLevelList",
					type:"get",
					dataType:"json",
					contentType:"application/json;cahrset=utf-8",
					//data: {time:87209,fuelLevel:78}
					success:function(data){
						for (let i = 0; i<data.length;i++){
							timeList.push(data[i].time);
							fuelList.push(data[i].fuelLevel);
						}
						console.log("timeList")
						console.log("fuelList")
						new Chart(document.getElementById("fuelChart2"),{
							type:"line",
							data:{
								labels:timeList,
								datasets: [{
									data: fuelList,
									//label: "fuelLevel",
									borderColor:"#3e95cd",
									fill: false
								}]
							},
							options:{
								title:{
									display: true,
									text:"fuelLevel"
								}
							}
						});
					},
					error:function(request,status,error,data){
						alert(request.status+"\n"+request.responseText+"\n"+error+"\n"+data);
					}
				})//ajax
			}//getGraph
</script>
</body>
</html>