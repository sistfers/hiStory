package com.sist.service;

import com.sist.model.CodeDDto;
import com.sist.model.CodeMDto;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-17.
 */
public interface CodeMSvc {
	public String getBean();
	public String getDualMsg();

	// CodeD List 조회
	public List<CodeDDto> do_selectCodeDList(Map<String, Object> condition);

	// CodeM List 조회
	public List<HashMap<String, Object>> do_selectCodeMList(Map<String, Object> search_con);

	public CodeMDto do_selectCodeM(int cdId);

	//등록Upsert
	public int do_upsertCodeM(CodeMDto codeM);

	public int do_insertCodeM(List<CodeMDto> codeMList) throws SQLException;

}
