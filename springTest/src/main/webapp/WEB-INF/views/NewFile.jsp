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
		//client.end(); �̰� Ȱ��ȭ ��Ű�� �޽����� �ް� disconnect�� �ȴ�.
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
			//���� ����
			function onConnect(){
				console.log("���� �Ϸ�");
				mqtt.subscribe("test/driver/route/time/Fuel", {qos: 1}); // ���ȸ�
			}
			//���� ����
			function onFailure(message){
				console.log("���� ����");
				setTimeout(mqttConnection, reconnectTimeout);
			}
			//�޼����� �����ϴ� ��� ȣ��
			function onMessageArrived(msg){
				console.log("����.." + msg.payloadString);
				alert("�޼��� ����!" + msg.payloadString);
			}
			function mqttConnection(){
				//mqttŬ���̾�Ʈ ��ü ����
				mqtt = new Paho.MQTT.Client(host,port,"mosquitto");
				//�����ϰ� callback �Լ� ���
				var options = {
						timeout: 3,
						onSuccess: onConnect,
						onFailure: onFailure
				};
				//�޼����� �����ϸ� ����� �Լ� ���
				mqtt.onMessageArrived = onMessageArrived;
				//����
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