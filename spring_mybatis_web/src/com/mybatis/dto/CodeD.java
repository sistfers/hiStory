package com.mybatis.dto;

import java.io.Serializable;

public class CodeD implements Serializable {
	
	private int     cd_id   ;
	private String cd_d_id ;
	private String cd_d_nm ;
	private String use_yn  ;
	private String reg_id  ;
	private String reg_dt  ;
	private String mod_id  ;
	private String mod_dt  ;		
	/**
	 * @return the cd_id
	 */
	public int getCd_id() {
		return cd_id;
	}
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "CodeD [cd_id=" + cd_id + ", cd_d_id=" + cd_d_id + ", cd_d_nm=" + cd_d_nm + ", use_yn=" + use_yn
				+ ", reg_id=" + reg_id + ", reg_dt=" + reg_dt + ", mod_id=" + mod_id + ", mod_dt=" + mod_dt + "]";
	}
	/**
	 * @param cd_id the cd_id to set
	 */
	public void setCd_id(int cd_id) {
		this.cd_id = cd_id;
	}
	/**
	 * @return the cd_d_id
	 */
	public String getCd_d_id() {
		return cd_d_id;
	}
	/**
	 * @param cd_d_id the cd_d_id to set
	 */
	public void setCd_d_id(String cd_d_id) {
		this.cd_d_id = cd_d_id;
	}
	/**
	 * @return the cd_d_nm
	 */
	public String getCd_d_nm() {
		return cd_d_nm;
	}
	/**
	 * @param cd_d_nm the cd_d_nm to set
	 */
	public void setCd_d_nm(String cd_d_nm) {
		this.cd_d_nm = cd_d_nm;
	}
	/**
	 * @return the use_yn
	 */
	public String getUse_yn() {
		return use_yn;
	}
	/**
	 * @param use_yn the use_yn to set
	 */
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	/**
	 * @return the reg_id
	 */
	public String getReg_id() {
		return reg_id;
	}
	/**
	 * @param reg_id the reg_id to set
	 */
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	/**
	 * @return the reg_dt
	 */
	public String getReg_dt() {
		return reg_dt;
	}
	/**
	 * @param reg_dt the reg_dt to set
	 */
	public void setReg_dt(String reg_dt) {
		this.reg_dt = reg_dt;
	}
	/**
	 * @return the mod_id
	 */
	public String getMod_id() {
		return mod_id;
	}
	/**
	 * @param mod_id the mod_id to set
	 */
	public void setMod_id(String mod_id) {
		this.mod_id = mod_id;
	}
	/**
	 * @return the mod_dt
	 */
	public String getMod_dt() {
		return mod_dt;
	}
	/**
	 * @param mod_dt the mod_dt to set
	 */
	public void setMod_dt(String mod_dt) {
		this.mod_dt = mod_dt;
	}


}
