package com.bill.dao;

import java.util.List;

import com.bill.vo.fuelVO;
 
public interface fuelDAO {
    
    public List<fuelVO> selectFuel() throws Exception;
}

