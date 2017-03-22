package com.sist.model;

import java.io.Serializable;

/**
 * Created by Admin on 2017-03-17.
 */
public class CodeMDto implements Serializable {
	private String msg;
	private int    cd_id;
	private String cd_nm ;
	private String reg_id ;
	private String reg_dt ;
	private String mod_id;
	private String mod_dt;

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public int getCd_id() {
		return cd_id;
	}

	public void setCd_id(int cd_id) {
		this.cd_id = cd_id;
	}

	public String getCd_nm() {
		return cd_nm;
	}

	public void setCd_nm(String cd_nm) {
		this.cd_nm = cd_nm;
	}

	public String getReg_id() {
		return reg_id;
	}

	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}

	public String getReg_dt() {
		return reg_dt;
	}

	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}

	public String getMod_id() {
		return mod_id;
	}

	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}

	public String getMod_dt() {
		return mod_dt;
	}

	public void setMod_dt(String mod_dt) {
		this.mod_dt = mod_dt;
	}

	@Override
	public String toString() {
		return "CodeMDto{" +
				"msg='" + msg + '\'' +
				", cd_id=" + cd_id +
				", cd_nm='" + cd_nm + '\'' +
				", reg_id='" + reg_id + '\'' +
				", reg_dt='" + reg_dt + '\'' +
				", mod_id='" + mod_id + '\'' +
				", mod_dt='" + mod_dt + '\'' +
				'}';
	}
}
