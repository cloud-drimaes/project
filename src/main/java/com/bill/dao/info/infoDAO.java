package com.bill.dao.info;

import java.util.List;

import com.bill.vo.info.infoVO;

public interface infoDAO {
		
	public List<infoVO> getInfo() throws Exception;
	
}
