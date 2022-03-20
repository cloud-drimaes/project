package com.bill.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.bill.vo.fuelVO;
 
@Service
public interface fuelService {
    
    public List<fuelVO> selectFuel() throws Exception;
    public void mqttInsertFuel(HashMap<String, Object> param) throws Exception;
}

