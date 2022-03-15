package com.bill.springTest.gson;

import java.util.List;
import java.util.Locale;

import javax.inject.Inject;

import java.text.DateFormat;
import java.util.Date;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import com.bill.vo.gson.gsonVO;
import com.bill.dao.gson.GsonDAO;
import com.bill.service.fuelService;
import com.bill.vo.fuelVO;
import com.bill.dao.speed.speedDAO;
import com.bill.vo.speed.speedVO;

@Controller
public class GsonController {
	

	private static final Logger logger = LoggerFactory.getLogger(GsonController.class);

	@Autowired
	GsonDAO gsonDao;
	@Autowired
	speedDAO speedDao;
    @Inject
    private fuelService service;


	@RequestMapping(value = "gson", method = RequestMethod.GET)

	public String gson(Locale locale, Model model) {

		return "gson";

	}

	@RequestMapping(value = "gsonList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")

	public @ResponseBody String gsonList(Locale locale, Model model) throws Exception {

		Gson gson = new Gson();

		List<gsonVO> list = gsonDao.getRpm();

		return gson.toJson(list);}

	@RequestMapping(value = "fuelList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")

	public @ResponseBody String fuelList(Locale locale, Model model) throws Exception {

		Gson gson_fuel = new Gson();

		List<fuelVO> list = service.selectFuel();

		return gson_fuel.toJson(list);
	}
	
	@RequestMapping(value = "speedList", method = RequestMethod.GET, produces="text/plain;charset=UTF-8")

	public @ResponseBody String speedList(Locale locale, Model model) throws Exception {

		Gson gson_speed = new Gson();

		List<speedVO> list = speedDao.getSpeed();

		return gson_speed.toJson(list);
	}

	

}
