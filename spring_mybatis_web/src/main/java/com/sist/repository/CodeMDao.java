package com.sist.repository;

import com.sist.model.CodeDDto;
import com.sist.model.CodeMDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-17.
 */
public interface CodeMDao {
	public String getBean();
	public String getDualMsg();

	/**
	 * 코드 목록
	 * @param condition
	 * @return
	 */
	public List<CodeDDto> do_selectCodeDList(Map<String, Object> condition);

	public List<HashMap<String, Object>> do_selectCodeMList(Map<String, Object> search_con);

	public CodeMDto do_selectCodeM(int cdId);

	//등록Upsert
	public int do_upsertCodeM(CodeMDto codeM);

	public int do_insertCodeM(CodeMDto codeM);


}
