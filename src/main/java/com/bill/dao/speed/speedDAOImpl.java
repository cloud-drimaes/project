package com.bill.dao.speed;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bill.vo.speed.speedVO;

@Repository
public class speedDAOImpl implements speedDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String Namespace = "com.bill.mapper.speedMapper";
	
	@Override
	public List<speedVO> getSpeed() throws Exception{
		
		return sqlSession.selectList(Namespace+".getSpeed");
	}

}
