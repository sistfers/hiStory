package com.hifive.history.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by Admin on 2017-03-24.
 */
@Controller
public class GraphControl {
	
	@RequestMapping("chart/visit.hi")
	public String visit() {
		return "/chart/visit";
	}
	@RequestMapping("chart/age.hi")
	public String age() {
		return "/chart/age";
	}
	@RequestMapping("chart/menu.hi")
	public String menu() {
		return "/chart/menu";
	}
	@RequestMapping("chart/neighbor.hi")
	public String neighbor() {
		return "/chart/neighbor";
	}
	@RequestMapping("chart/control.hi")
	public String control() {
		return "/chart/control";
	}
}
