package com.hifive.history.model;

import java.io.Serializable;

public class MessageDto implements iDto, Serializable {

	private static final long serialVersionUID = 4841893468544096972L;
	
	private	int		seq;
	private	String	send_id;
	private	String	take_id;
	private String  contents;
	private	String	wdate;
	private	String	rdate;
	private	String	state;
	
	public MessageDto() {
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getSend_id() {
		return send_id;
	}

	public void setSend_id(String send_id) {
		this.send_id = send_id;
	}

	public String getTake_id() {
		return take_id;
	}

	public void setTake_id(String take_id) {
		this.take_id = take_id;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getWdate() {
		return wdate;
	}

	public void setWdate(String wdate) {
		this.wdate = wdate;
	}

	public String getRdate() {
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
}
