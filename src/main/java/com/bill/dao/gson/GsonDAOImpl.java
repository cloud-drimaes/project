package com.bill.dao.gson;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bill.vo.gson.gsonVO;

@Repository
public class GsonDAOImpl implements GsonDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private static final String Namespace = "com.bill.mapper.gsonMapper";
	
	@Override
	public List<gsonVO> getRpm() throws Exception{
		
		return sqlSession.selectList(Namespace+".getRpm");
	}

}
