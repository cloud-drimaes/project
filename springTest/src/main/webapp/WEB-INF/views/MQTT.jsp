<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>MQTT Web Client</title>
</head>
<body>

<H1>MQTT Web Subscribe Client</H1><br><br>

<h3>please enter Server host and port.</h3><br>
<label for="text_host">host</label> : <input type="text" id="text_host" /><br>
<label for="text_port">port</label> : <input type="text" id="text_port" /><br>
<label for="text_topic">topic</label> : <input type="text" id="text_topic" /><br><br>

<input type="button" id="mqtt_con_but" value="Connect" onclick="beginMQTTweb()">
<br><br>

connection status : <div id="con_status" style="display:inline">disconnect</div><br>
Message : <div id="msg" style="display:inline"></div><br>
<script src="../js/mqttws31.js"></script>
<script type="text/javascript">
	
	function beginMQTTweb() {
		if (document.getElementById("mqtt_con_but").value == "Connect") {
			host = "61.42.251.202"; // document.getElementById("text_host").value;
			port = "1883"; //document.getElementById("text_port").value;
			topic = "test/#"; //document.getElementById("text_topic").value;
			if ((host == "") || (port == "")) {
				alert("Please enter host and port.");
			} else {
				mqclient = new Paho.MQTT.Client(host, Number(port), "clientId_pcm");
				// set callback handlers
				mqclient.onConnectionLost = onConnectionLost;
				mqclient.onMessageArrived = onMessageArrived;
				// connect the client
				mqclient.connect({
					onSuccess : onConnect,
					onFailure : onFailure
				});
			}
		} else if (document.getElementById("mqtt_con_but").value == "Disconnect") {
			
			mqclient.disconnect();
			document.getElementById("con_status").textContent = "disconnect";
			document.getElementById("mqtt_con_but").value = "Connect";
			console.log("Disconnect");
		}
	}
	function onFailure() {
		alert("Please enter host and port again.")
	}
	// called when the client connects
	function onConnect() {
		// Once a connection has been made, make a subscription and send a message.
		console.log("onConnect");
		document.getElementById("con_status").textContent = "connect";
		mqclient.subscribe(topic);
		document.getElementById("mqtt_con_but").value = "Disconnect";
	}
	// called when the client loses its connection
	function onConnectionLost(responseObject) {
		if (responseObject.errorCode !== 0) {
			console.log("onConnectionLost:" + responseObject.errorMessage);
			document.getElementById("con_status").textContent = "disconnect";
			document.getElementById("mqtt_con_but").value = "Connect";
		}
	}
	// called when a message arrives
	function onMessageArrived(message) {
		console.log("onMessageArrived:" + message.payloadString);
		document.getElementById("msg").textContent = message.payloadString;
	}
</script>

</body>
</html>