package com.bill.service;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
 
import org.springframework.stereotype.Service;
 
import com.bill.dao.fuelDAO;
import com.bill.vo.fuelVO;
 
@Service
public class fuelServiceImpl implements fuelService {
 
    @Inject
    private fuelDAO dao;
    
    @Override
    public List<fuelVO> selectFuel() throws Exception {
 
        return dao.selectFuel();
    }

	@Override
	public void mqttInsertFuel(HashMap<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		try {
			System.out.println("----------fuelService----------");
			dao.mqttInsertFuel(param);
		}catch (Exception e) {
			// TODO: handle exception 
			e.printStackTrace(); 
		}
	}
 
}


