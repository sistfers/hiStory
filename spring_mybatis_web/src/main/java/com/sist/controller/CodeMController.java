package com.sist.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.sist.model.CodeDDto;
import com.sist.model.CodeMDto;
import com.sist.service.CodeMSvc;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Admin on 2017-03-17.
 */
@Controller
public class CodeMController {

	Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private CodeMSvc codeMSvc;

	@RequestMapping("code/code_m.do")
	public String bean() {
		logger.debug("===========================");
		logger.debug("1 " + codeMSvc.toString());
		logger.debug("===========================");
		return "code/code_m";
	}

	@RequestMapping("code/code_msg.do")
	public String code_msg() {
		logger.debug("===========================");
		logger.debug("1 " + codeMSvc.getDualMsg());
		logger.debug("===========================");
		return "code/code_msg";
	}

	@RequestMapping(value = "code/do_search.do", method = RequestMethod.GET)
	public ModelAndView do_search(HttpServletRequest request) {
		// 코드 D List-------------------------------------
		logger.debug("코드 D List-------------------------------------");
		List<CodeDDto> pageCode = new ArrayList<CodeDDto>();
		List<CodeDDto> searchCode = new ArrayList<CodeDDto>();

		Map<String, Object> codeMap = new HashMap<String, Object>();
		List<String> codeList = new ArrayList<String>();
		codeList.add("100");
		codeList.add("110");
		codeMap.put("code_list", codeList);
		ArrayList<CodeDDto> codes = (ArrayList<CodeDDto>) codeMSvc.do_selectCodeDList(codeMap);

		// page, search 코드 분리
		for (int i = 0; i < codes.size(); i++) {
			CodeDDto codeData = codes.get(i);
			if (codeData.getCd_id() == 100) {
				pageCode.add(codeData);
			} else {
				searchCode.add(codeData);
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("code/codeM");
		mav.addObject("pageCode", pageCode);
		mav.addObject("searchCode", searchCode);

		// CodeD List --------------------------------------------


		// CodeM List --------------------------------------------
		Map<String, Object> search_con = new HashMap<String, Object>();
		String SEARCH_DIV = "";     // 조회 구분
		String SEARCH_WORD = "";    // 조회 TEXT
		String PAGE_SIZE = "10";      // 페이지 사이즈
		String PAGE_NUM = "1";       // 페이지 NUM

		SEARCH_DIV = (request.getParameter("SEARCH_DIV") == null) ? "" : request.getParameter("SEARCH_DIV");
		SEARCH_WORD = (request.getParameter("SEARCH_WORD") == null) ? "" : request.getParameter("SEARCH_WORD");
		PAGE_SIZE = (request.getParameter("PAGE_SIZE") == null) ? "10" : request.getParameter("PAGE_SIZE");
		PAGE_NUM = (request.getParameter("PAGE_NUM") == null
				|| request.getParameter("PAGE_NUM").equals("")) ? "1" : request.getParameter("PAGE_NUM");

		search_con.put("SEARCH_DIV", SEARCH_DIV);
		search_con.put("SEARCH_WORD", SEARCH_WORD + "%");
		search_con.put("PAGE_SIZE", PAGE_SIZE);
		search_con.put("PAGE_NUM", PAGE_NUM);
		logger.debug("search_con : " + search_con.toString());

		List<HashMap<String, Object>> lists = codeMSvc.do_selectCodeMList(search_con);
		mav.addObject("lists", lists);

		mav.addObject("SEARCH_DIV", SEARCH_DIV);
		mav.addObject("SEARCH_WORD", SEARCH_WORD);
		mav.addObject("PAGE_SIZE", PAGE_SIZE);
		mav.addObject("PAGE_NUM", PAGE_NUM);
		return mav;

	}

	@RequestMapping(value="code/do_detail.do", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public @ResponseBody
	String do_detail(HttpServletRequest res){	//Json을 쓸것이기 때문에 return 타입을 String으로 가져간다.
		int cdId = Integer.parseInt(res.getParameter("cd_id").trim());
		CodeMDto codeOne = this.codeMSvc.do_selectCodeM(cdId);
		Gson gson = new Gson();
		return gson.toJson(codeOne);
	}

	@RequestMapping(value="code/do_upsert.do",method=RequestMethod.POST)
	@ResponseBody
	public String do_upsert(HttpServletRequest res){
		int    cd_id = Integer.parseInt(res.getParameter("cd_id").trim());
		String cd_nm = res.getParameter("cd_nm").trim();
		String reg_id = res.getParameter("reg_id").trim();
		String reg_dt = res.getParameter("reg_dt").trim();
		String mod_id = res.getParameter("mod_id").trim();
		String mod_dt = res.getParameter("mod_dt").trim();

		CodeMDto codeM = new CodeMDto();
		codeM.setCd_id(cd_id);
		codeM.setCd_nm(cd_nm);
		codeM.setMod_dt(mod_dt);
		codeM.setMod_id(mod_id);
		codeM.setReg_dt(reg_dt);
		codeM.setReg_id(reg_id);

		int flag = codeMSvc.do_upsertCodeM(codeM);
		JsonObject jobj = new JsonObject();
		//{"msg":"true"}
		if(flag>0) jobj = new JsonParser().parse("{\"msg\":\"true\"}").getAsJsonObject();
		else jobj = new JsonParser().parse("{\"msg\":\"false\"}").getAsJsonObject();
		Gson gson = new Gson();
		return gson.toJson(jobj);
	}

	@RequestMapping("code/code_tran.do")
	public String do_tran() {
		List<CodeMDto> codeMList = new ArrayList<CodeMDto>();
		codeMList = this.getTran();
		logger.debug("=Controller tran==============");
		try {
			int flag = codeMSvc.do_insertCodeM(codeMList);
			logger.debug("=============flag : " + flag);
		} catch (Exception e) {
			logger.debug("tran:ex ================" + e.toString());
		}
		logger.debug("=Controller tran end=============");
		return "code/code_m";
	}

	private List<CodeMDto> getTran() {
		List<CodeMDto> codeMList = new ArrayList<CodeMDto>();
		for (int i = 0; i < 5; i++) {
			CodeMDto codeM = new CodeMDto();
			if (i == 4) {
				codeM.setCd_id(100);
			} else {
				codeM.setCd_id(i + 50001);
			}
			codeM.setCd_nm(i + "_Tran");
			codeM.setMod_id("Tran");
			codeM.setReg_id("Tran");
			codeMList.add(codeM);
		}
		return codeMList;
	}

}
