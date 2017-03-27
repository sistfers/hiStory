package com.hifive.history.service;

import java.util.List;
import java.util.Map;

import com.hifive.history.model.iDto;

public interface iService {
	
	public int hi_insert(iDto dto);			// 등록
	
	public int hi_update(iDto dto);			// 수정
	
	public iDto hi_detail(iDto dto);		// 로그인,상세보기(1건읽기)
	
	public int hi_delete(int cnt);			// 삭제(3으로 상태변경)
	
	public List<Map<String, Object>> hi_selectPage(Map<String, Object> dto) throws Exception;		// 목록 리스트 보기
}
