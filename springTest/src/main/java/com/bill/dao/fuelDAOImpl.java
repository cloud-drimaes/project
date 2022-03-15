package com.bill.dao;

import java.util.List;

import javax.inject.Inject;
 
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
 
import com.bill.vo.fuelVO;
 
@Repository
public class fuelDAOImpl implements fuelDAO {
 
    @Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.bill.mapper.fuelMapper";
    
    @Override
    public List<fuelVO> selectFuel() throws Exception {
 
        return sqlSession.selectList(Namespace+".selectFuel");
    }
 
}

