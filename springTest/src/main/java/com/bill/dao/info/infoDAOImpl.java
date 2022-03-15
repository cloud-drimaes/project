package com.bill.dao.info;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bill.vo.info.infoVO;

@Repository
public class infoDAOImpl implements infoDAO{
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String Namespace = "com.bill.mapper.infoMapper";
	
	@Override
	public List<infoVO> getInfo() throws Exception{
		
		return sqlSession.selectList(Namespace+".getInfo");
	}
}
