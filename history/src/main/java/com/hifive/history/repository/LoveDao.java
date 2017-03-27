package com.hifive.history.repository;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hifive.history.model.iDto;

/**
 * Created by Admin on 2017-03-24.
 */
@Repository
public class LoveDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.LoveCode";
	
	@Autowired
	private SqlSessionTemplate sqlSession; 

	@Override
	public int hi_insert(iDto dto) {
		String statement = namespace +".hi_insert";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.insert(statement,dto);
	}

	@Override
	public int hi_update(iDto dto) {
		String statement = namespace +".hi_update";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.update(statement,dto);
	}

	//공감한 사람 목록 보기(글별)
	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	//내가 공감한 글 목록 확인
	public List<Map<String, Object>> hi_selectListMy(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectListMy";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	//글 공감 높은 순위 (날짜별)
	public List<Map<String, Object>> hi_selectListRank(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectListRank";
		logger.debug("statement"+statement);
		logger.debug("condition.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	
//= 사용안함 =========================================	
	@Override
	public iDto hi_detail(iDto dto) {
		return null;
	}

	@Override
	public int hi_delete(int cnt) {
		return 0;
	}
}
