package com.bill.service;

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
 
}


