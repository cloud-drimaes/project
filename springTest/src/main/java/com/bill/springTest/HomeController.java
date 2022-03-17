package com.bill.springTest;
 
import java.util.List;
import java.util.Locale;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.inject.Inject;
 
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
import com.bill.dao.info.infoDAO;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping("/")
public class HomeController {
    
    private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
    
    @Inject
    private fuelService service;
    @Autowired
    infoDAO infoDao;
    
    
    /**
     * Simply selects the home view to render by returning its name.
     */
    //"https://favicon.io/" �뿉�꽌 �뙆鍮꾩퐯 �떎�슫濡쒕뱶
    @RequestMapping("/favicon.ico")
    public String favicon() {
    	return "forward:/resources/favicon.ico";
    }
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String home(Locale locale, Model model) throws Exception{
 
        logger.info("home");
        //logger.info("index");
        
        List<fuelVO> fuelList = service.selectFuel();
        List<infoVO> infoList = infoDao.getInfo();
        
        model.addAttribute("fuelList", fuelList);
        model.addAttribute("infoList", infoList);
 
        return "home";
        //return "index";
    }
    
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
}
    
