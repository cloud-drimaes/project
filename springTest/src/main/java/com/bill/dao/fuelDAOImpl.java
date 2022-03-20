package com.bill.dao;

import java.util.HashMap;
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

	@Override
	public void mqttInsertFuel(HashMap<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		try {
			sqlSession.insert(Namespace+".mqttInsertFuel", param);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
 
}

