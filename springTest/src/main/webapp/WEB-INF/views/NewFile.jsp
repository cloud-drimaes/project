<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<script src="https://cdnjs.cloudflare.com/ajax/libs/paho-mqtt/1.0.1/mqttws31.js" type="text/javascript"></script>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
		
		<script type="text/javascript">
		/* 
		// Create a client instance
		//client = new Paho.MQTT.Client(location.hostname, Number(location.port), "clientId");
		client = new Paho.MQTT.Client("61.42.251.202", 9001);//(location.hostname, Number(location.port), "clientId");

		// set callback handlers
		client.onConnectionLost = onConnectionLost;
		client.onMessageArrived = onMessageArrived;

		// connect the client
		client.connect({onSuccess:onConnect});


		// called when the client connects
		function onConnect() {
		  // Once a connection has been made, make a subscription and send a message.
		  console.log("onConnect");
		  client.subscribe("World");
		  message = new Paho.MQTT.Message("Hello");
		  message.destinationName = "World";
		  client.send(message);
		}

		// called when the client loses its connection
		function onConnectionLost(responseObject) {
		  if (responseObject.errorCode !== 0) {
		    console.log("onConnectionLost:"+responseObject.errorMessage);
		  }
		}

		// called when a message arrives
		function onMessageArrived(message) {
		  console.log("onMessageArrived:"+message.payloadString);
		}
		 */
		/* 
		var express = require('express');
		var app = express();
		var port = 9001;
		app.use(express.static('client'));

		var mqtt = require('mqtt');
		var client = mqtt.connect('ws://61.42.251.202:1883', { keepalive:20 });

		client.on('connect', function() {
		client.subscribe('/presence')
		setInterval(sendMsg,3000);
		});

		client.on('message', function(topic, message) {
		console.log(message.toString());
		//client.end(); 이걸 활성화 시키면 메시지를 받고 disconnect가 된다.
		});

		client.on('disconnect', function(response) {
		console.log('DISCONNECT');
		});

		function sendMsg() {
		client.publish('/presence','from NodeJS');
		}

		app.listen(port);
		 */
			var mqtt;
			var reconnectTimeout = 2000;
			var host ="61.42.251.202";
			var port = 9001;
			//callback function
			//성공 접속
			function onConnect(){
				console.log("접속 완료");
				mqtt.subscribe("test/driver/route/time/Fuel", {qos: 1}); // 토픽명
			}
			//접속 실패
			function onFailure(message){
				console.log("접속 실패");
				setTimeout(mqttConnection, reconnectTimeout);
			}
			//메세지가 도착하는 경우 호출
			function onMessageArrived(msg){
				console.log("도착.." + msg.payloadString);
				alert("메세지 도착!" + msg.payloadString);
			}
			function mqttConnection(){
				//mqtt클라이언트 객체 생성
				mqtt = new Paho.MQTT.Client(host,port,"mosquitto");
				//연결하고 callback 함수 등록
				var options = {
						timeout: 3,
						onSuccess: onConnect,
						onFailure: onFailure
				};
				//메세지가 도착하면 실행될 함수 등록
				mqtt.onMessageArrived = onMessageArrived;
				//접속
				mqtt.connect(options);
			}
			
		</script>
		
		<title>Insert title here</title>
	</head>
	<body>
		<script type="text/javascript">
			mqttConnection();
		</script>
		<input type="button" id="pub_btn" value="publish"/>
	</body>
</html>