package com.hifive.history.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hifive.history.model.PostDto;
import com.hifive.history.model.iDto;

/**
 * Created by Admin on 2017-03-24.
 */
@Repository
public class PostDao implements iDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String namespace="com.hifive.history.repository.mappers.postCode";
	
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

	@Override
	public iDto hi_detail(iDto dto) {
		String statement = namespace +".hi_detail";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+dto.toString());
		return sqlSession.selectOne(statement,dto);
	}

	@Override
	public int hi_delete(int cnt) {
		String statement = namespace +".hi_delete";
		logger.debug("statement"+statement);
		logger.debug("cnt = "+cnt);
		return sqlSession.update(statement,cnt);
	}

	@Override
	public List<Map<String, Object>> hi_selectList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	public List<Map<String, Object>> hi_bloggerRankList() {
		String statement = namespace +".hi_bloggerRankList";
		logger.debug("statement"+statement);
		
		return sqlSession.selectList(statement);
	}
	public List<HashMap<String, Object>> hi_selectCommentRank(String id){
		String statement = namespace +".hi_selectCommentRank";
		logger.debug("statement"+statement);
		logger.debug("id"+id);
		return sqlSession.selectList(statement,id);
	}
	public List<HashMap<String, Object>> hi_selectTodayCommentRank(HashMap<String, String> map){
		String statement = namespace +".hi_selectTodayCommentRank";
		logger.debug("statement"+statement);
		logger.debug("map : "+map);
		return sqlSession.selectList(statement,map);
	}
	public List<HashMap<String, Object>> hi_selectLoveRank(HashMap<String, String> map){
		String statement = namespace +".hi_selectLoveRank";		
		logger.debug("statement"+statement);
		logger.debug("map : " + map);
		return sqlSession.selectList(statement,map);
	}
	
	public List<Map<String, Object>> hi_selectFollowerList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectFollowerList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	public List<Map<String, Object>> hi_selectThemeList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectThemeList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
	public List<Map<String, Object>> hi_selectSearchList(Map<String, Object> condition) throws Exception {
		String statement = namespace +".hi_selectSearchList";
		logger.debug("statement"+statement);
		logger.debug("dto.toString() = "+condition.toString());
		return sqlSession.selectList(statement,condition);
	}
	
}
