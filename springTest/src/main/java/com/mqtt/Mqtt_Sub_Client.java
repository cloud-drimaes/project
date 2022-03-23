package com.mqtt;

import java.util.HashMap;

import javax.inject.Inject;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.bill.service.fuelService;

/*
	Mqtt 클라이언트 - broker에 메세지를 전달 받기 위한 구독신청 - 대기 하는 객체
	1. MqttCallback 인터페이스를 상속
	2. MqttCallback 인터페이스의 abstract 메소드를 오버라이딩
*/
@Controller
public class Mqtt_Sub_Client implements MqttCallback{
	
	// broker와 통신하는 역할 - subscriber, publisher의 역할
	private MqttClient mqttClient;
	
	// MQTT 프로토콜을 이용해서 broker에 연결하면서 연결정보를 설정할 수 있는 객채 
	private MqttConnectOptions mqttOption;
	
	
	// clientId는 broker가 클라이언트를 식별하기 위한 문자열 - 고유해야함 
	public Mqtt_Sub_Client init(String server, String clientId) {
		
		try {
			
			mqttOption = new MqttConnectOptions();
			mqttOption.setCleanSession(true);
			mqttOption.setKeepAliveInterval(30);
			
			// broker에 subscribe 하기 위한 클라이언트 객체 생성
			mqttClient = new MqttClient(server, clientId);
			
			/*
			 * 클라이언트 객체에 MqttCallback을 등록 
			 * : 구독신청 후 적절한 시점에 처리하고 싶은 기능을 구현하고 
			 * 	  메소드가 자동으로 그 시점에 호출되도록 할 수 있다. 
			 */
			mqttClient.setCallback(this);
			mqttClient.connect(mqttOption);
			
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return this;
		
	}
	
	
	// 메세지가 도착하면 호출
	@Override
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		
		// TODO Auto-generated method stub
		System.out.println("---------메세지가 도착했습니다.---------");
		System.out.println(message);
		System.out.println("topic : " + topic + ", id : " + message.getId() + ", payload : " + new String(message.getPayload()));
		
		if(!messageInsertToDB(topic, message)) {
			System.out.println("메세지 저장 실패....."); 
		}else {
			System.out.println("메세지 저장 성공....."); 
		};
	}


	@Autowired
    private static fuelService service;
	
	public boolean messageInsertToDB(String topic, MqttMessage message) {
		boolean insertSuccess = true; 
		
		
		String[] topicArr = topic.split("test/")[1].split("/");
		String[] payload = new String(message.getPayload()).split("/");

		HashMap<String, Object> mqttMap = new HashMap<>(); 
		
		for(int i = 0; i < topicArr.length; i++) {
			mqttMap.put(topicArr[i], payload[i]);
		}

		try {
			System.out.println(mqttMap);
			service.mqttInsertFuel(mqttMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			insertSuccess = false; 
		}
		
		
		return insertSuccess;
	}

	// 커넥션 종료되면 호출 - 통신오류로 연결이 끊어지는 경우
	@Override
	public void connectionLost(Throwable cause) {
		// TODO Auto-generated method stub
		
	}

	// 메세지 배달이 완료되면 호출 
	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		// TODO Auto-generated method stub
		
	}

	// 구독 신청
	public boolean subscribe(String topic) {
		
		boolean result = true;
		
		try {
			if(topic!= null) {
				// topic과 Qos를 전달
				// Qos : 메세지가 도착하기 위한 품질 값 설정 - 서비스 품질 (0,1,2)
				mqttClient.subscribe(topic, 0);
				System.out.println("---------연결 되었습니다.---------");
			}
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = false;
		}
		
		return result;
	}
	
	/*
	 * public static void main(String[] args) { 
		 * Mqtt_Sub_Client subobj = new Mqtt_Sub_Client(); 
		 * subobj.init("tcp://61.42.251.202:1883", "daisy-sub").subscribe("test/#"); 
	 * }
	 */

}
