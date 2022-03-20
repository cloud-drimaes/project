package com.bill.springTest;
 
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.inject.Inject;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.bill.vo.fuelVO;
import com.bill.service.fuelService;
import com.bill.vo.info.infoVO;
import com.mqtt.Mqtt_Sub_Client;
import com.bill.dao.info.infoDAO;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/")
public class HomeController implements MqttCallback {
    
	// broker와 통신하는 역할 - subscriber, publisher의 역할
	private MqttClient mqttClient;
	
	// MQTT 프로토콜을 이용해서 broker에 연결하면서 연결정보를 설정할 수 있는 객채 
	private MqttConnectOptions mqttOption;
	
	
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    
    @Inject
    private fuelService service;
    @Autowired
    infoDAO infoDao;
    
    
    /**
     * Simply selects the home view to render by returning its name.
     */
    //"https://favicon.io/" 
    @RequestMapping("/favicon.ico")
    public String favicon() {
    	return "forward:/resources/favicon.ico";
    }
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) throws Exception{
    	
    	// 서버가 시작되면 broker를 구독한다. 
    	//Mqtt_Sub_Client mqttSubClient = new Mqtt_Sub_Client();
    	init("tcp://61.42.251.202:1883", "daisy-sub").subscribe("test/#");
    	
        logger.info("home");
        //logger.info("index");
        
        List<fuelVO> fuelList = service.selectFuel();
        List<infoVO> infoList = infoDao.getInfo();
        
        model.addAttribute("fuelList", fuelList);
        model.addAttribute("infoList", infoList);
 
        return "home";
        //return "index";
    }
    @RequestMapping(value = "/home_MQTT")
    public String MQTT(Locale locale, Model model) throws Exception{
 
        logger.info("home_MQTT");
        //logger.info("index");
		/*
		 * List<fuelVO> fuelList = service.selectFuel(); List<infoVO> infoList =
		 * infoDao.getInfo();
		 * 
		 * model.addAttribute("fuelList", fuelList); model.addAttribute("infoList",
		 * infoList);
		 */
        return "/home_MQTT";
        //return "index";
    }
	/*
	 * @GetMapping("MQTT") public String getMQTT(Model model, HttpServletRequest
	 * request) throws Exception{ List<infoVO> infoList = infoDao.getInfo();
	 * 
	 * String route = request.getParameter("selectBox"); //int price =
	 * Integer.parseInt(request.getParameter("price")); //int categoryCode =
	 * Integer.parseInt(request.getParameter("categoryCode"));
	 * 
	 * String message = route; model.addAttribute("message", message);
	 * model.addAttribute("infoList", infoList);
	 * 
	 * return "/MQTT"; //return "/index_messageResult"; }
	 */
    
    
	// 1. Httpservlet�쓽 request �솢�슜�빐 �뙆�씪誘명꽣 諛쏆븘�삤湲�
	@GetMapping("regist")
	public void getRegist() {}
	
	@PostMapping("regist")
	public String postRegist(Model model, HttpServletRequest request) throws Exception{
        List<infoVO> infoList = infoDao.getInfo();
		String route = request.getParameter("selectBox");
		//int price = Integer.parseInt(request.getParameter("price"));
		//int categoryCode = Integer.parseInt(request.getParameter("categoryCode"));
		
		String message = route;
		model.addAttribute("message", message);
        model.addAttribute("infoList", infoList);

		return "/messageResult";
		//return "/index_messageResult";
	}
	
	// clientId는 broker가 클라이언트를 식별하기 위한 문자열 - 고유해야함 
	public HomeController init(String server, String clientId) {
		
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
	
	@Override
	public void connectionLost(Throwable cause) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void messageArrived(String topic, MqttMessage message) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("---------메세지가 도착했습니다.---------");
		System.out.println(message);
		System.out.println("topic : " + topic + ", id : " + message.getId() + ", payload : " + new String(message.getPayload()));
		
		System.out.println("---------메세지 저장 메소드.---------");
		
		if(!messageInsertToDB(topic, message)) {
			System.out.println("---------메세지 저장 실패!!!!!!!"); 
		}else {
			System.out.println("---------메세지 저장 성공!!!!!!!"); 
		};
	}

	@Override
	public void deliveryComplete(IMqttDeliveryToken token) {
		// TODO Auto-generated method stub
		
	} 
	
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
	
	// 구독 신청
	public boolean subscribe(String topic) {
		
		boolean result = true;
		
		try {
			if(topic!= null) {
				// topic과 Qos를 전달
				// Qos : 메세지가 도착하기 위한 품질 값 설정 - 서비스 품질 (0,1,2)
				mqttClient.subscribe(topic, 0);
			}
		} catch (MqttException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = false;
		}
		
		return result;
	}
}
    
