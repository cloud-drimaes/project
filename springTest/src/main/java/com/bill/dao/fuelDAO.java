package com.bill.dao;

import java.util.HashMap;
import java.util.List;

import com.bill.vo.fuelVO;
 
public interface fuelDAO {
    
    public List<fuelVO> selectFuel() throws Exception;
    public void mqttInsertFuel(HashMap<String, Object> param) throws Exception;
}

