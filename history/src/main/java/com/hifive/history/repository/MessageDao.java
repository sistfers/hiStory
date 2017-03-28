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
public class MessageDao implements iDao {
	
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.messageCode";
	
	@Autowired
	private SqlSessionTemplate sqlSession; 

	// 쪽지 쓰기
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

	// 쪽지 읽기
	@Override
	public iDto hi_detail(iDto dto) {
		
		String statement = namespace +".hi_detail";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		
		return sqlSession.selectOne(statement, dto);
	}

	// 쪽지 삭제
	@Override
	public int hi_delete(int cnt) {
		
		String statement = namespace +".hi_delete";
		logger.debug("statement"+statement);
		logger.debug("cnt = "+cnt);
		
		return sqlSession.delete(statement, cnt);
	}

	// 즐겨찾기 : 내가 추가한
	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> dto) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.selectList(statement,dto);
	}
	
	// 보낸 쪽지함
	public List<Map<String, Object>> hi_select_sendlist(String sendId) {
				
		String statement = namespace +".hi_select_sendlist";
		logger.debug("statement"+statement);
		logger.debug("sendId "+sendId);
			
		return sqlSession.selectList(statement, sendId);
	}
	
	// 받은 쪽지함
	public List<Map<String, Object>> hi_select_getlist(Map<String, Object> search_info) {
					
		String statement = namespace +".hi_select_getlist";
		logger.debug("----------------------------------------------------------");
		logger.debug("[[[statement  ]]] "+statement);
		logger.debug("[[[search_info]]] "+search_info.toString());
				
		return sqlSession.selectList(statement, search_info);
	}	
}


