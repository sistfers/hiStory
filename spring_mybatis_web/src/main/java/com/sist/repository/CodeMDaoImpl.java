package com.sist.repository;

import com.sist.model.CodeDDto;
import com.sist.model.CodeMDto;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-17.
 */
@Repository
public class CodeMDaoImpl implements CodeMDao {
	Logger logger = LoggerFactory.getLogger(this.getClass());
	private final String  namespace = "com.sist.repository.mapper.CodeM";

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public String getBean() {
		return "CodeMDaoImpl : " + sqlSession.toString();
	}

	@Override
	public String getDualMsg() {
		String statement = namespace + ".sqlTest";
		return ((CodeMDto)sqlSession.selectOne(statement)).getMsg();
	}

	/**
	 * CodeD 목록
	 * @param condition
	 * @return
	 */
	@Override
	public List<CodeDDto> do_selectCodeDList(Map<String, Object> condition) {
		String statement = namespace + ".do_selectCodeDList";
		logger.debug("statement = " + statement);
		logger.debug("condition = " + condition.toString());
		return sqlSession.selectList(statement, condition);
	}

	/**
	 * CodeM 목록
	 * @param search_con
	 * @return
	 */
	@Override
	public List<HashMap<String, Object>> do_selectCodeMList(Map<String, Object> search_con) {
		String statement = namespace + ".do_selectCodeMList";
		logger.debug("statement = " + statement);
		logger.debug("condition = " + search_con.toString());
		return sqlSession.selectList(statement, search_con);
	}

	@Override
	public CodeMDto do_selectCodeM(int cdId) {
		String statement = namespace + ".do_selectCodeM";

		logger.debug("statement= " + statement);
		logger.debug("cdId = " + cdId);
		return sqlSession.selectOne(statement, cdId);
	}

	/*
	 * 등록 Upsert
	 */
	@Override
	public int do_upsertCodeM(CodeMDto codeM) {
		String statement = namespace + ".do_upsertCodeM";

		logger.debug("statement= " + statement);
		logger.debug("CodeMDto = " + codeM.toString());
		return sqlSession.update(statement, codeM);
	}

	@Override
	public int do_insertCodeM(CodeMDto codeM) {
		String statement = namespace + ".do_insertCodeM";

		logger.debug("statement= " + statement);
		logger.debug("CodeMDto = " + codeM.toString());
		return sqlSession.update(statement, codeM);
	}
}
