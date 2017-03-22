package com.sist.model;

import java.io.Serializable;

/**
 * Created by Admin on 2017-03-20.
 */
public class CodeDDto implements Serializable {
	private int    cd_id   ;
	private String cd_d_id ;
	private String cd_d_nm ;
	private String use_yn  ;
	private String reg_id  ;
	private String reg_dt  ;
	private String mod_id  ;
	private String mod_dt  ;

	public int getCd_id() {
		return cd_id;
	}

	public void setCd_id(int cd_id) {
		this.cd_id = cd_id;
	}

	public String getCd_d_id() {
		return cd_d_id;
	}

	public void setCd_d_id(String cd_d_id) {
		this.cd_d_id = cd_d_id;
	}

	public String getCd_d_nm() {
		return cd_d_nm;
	}

	public void setCd_d_nm(String cd_d_nm) {
		this.cd_d_nm = cd_d_nm;
	}

	public String getUse_yn() {
		return use_yn;
	}

	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
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
		return "CodeDDto{" +
				"cd_id=" + cd_id +
				", cd_d_id='" + cd_d_id + '\'' +
				", cd_d_nm='" + cd_d_nm + '\'' +
				", use_yn='" + use_yn + '\'' +
				", reg_id='" + reg_id + '\'' +
				", reg_dt='" + reg_dt + '\'' +
				", mod_id='" + mod_id + '\'' +
				", mod_dt='" + mod_dt + '\'' +
				'}';
	}
}
