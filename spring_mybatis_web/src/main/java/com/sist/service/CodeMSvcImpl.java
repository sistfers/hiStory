package com.sist.service;

import com.sist.model.CodeDDto;
import com.sist.model.CodeMDto;
import com.sist.repository.CodeMDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-17.
 */
@Service
public class CodeMSvcImpl implements CodeMSvc {
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CodeMDao codeMDao;

	@Override
	public String getBean() {
		return codeMDao.getBean();
	}

	@Override
	public String getDualMsg() {
		return codeMDao.getDualMsg();
	}

	@Override
	public List<CodeDDto> do_selectCodeDList(Map<String, Object> condition) {
		return codeMDao.do_selectCodeDList(condition);
	}

	@Override
	public List<HashMap<String, Object>> do_selectCodeMList(Map<String, Object> search_con) {
		return codeMDao.do_selectCodeMList(search_con);
	}

	@Override
	public CodeMDto do_selectCodeM(int cdId) {

		return codeMDao.do_selectCodeM(cdId);
	}

	/*
	 * 등록 Upsert
	 */
	@Override
	public int do_upsertCodeM(CodeMDto codeM) {

		return codeMDao.do_upsertCodeM(codeM);
	}

	@Transactional
	@Override
	public int do_insertCodeM(List<CodeMDto> codeMList) throws SQLException {
		int flagCnt = 0;

		for (CodeMDto codeM : codeMList) {
			int flag = codeMDao.do_insertCodeM(codeM);
			flagCnt += flag;
		}
		return flagCnt;
	}
}
