package com.bill.service;

import java.util.List;
 
import com.bill.vo.fuelVO;
 
public interface fuelService {
    
    public List<fuelVO> selectFuel() throws Exception;
}

