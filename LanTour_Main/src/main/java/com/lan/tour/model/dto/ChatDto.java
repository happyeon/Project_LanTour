package com.lan.tour.model.dto;

import java.util.Date;

public class ChatDto {

	private int chat_no;
	private int member_clientno;
	private int member_hostno;
	private Date chat_date;
	private String chat_content;

	public ChatDto() {

	}

	public ChatDto(int chat_no, int member_clientno, int member_hostno, Date chat_date, String chat_content) {

		this.chat_no = chat_no;
		this.member_clientno = member_clientno;
		this.member_hostno = member_hostno;
		this.chat_date = chat_date;
		this.chat_content = chat_content;
	}

	public int getChat_no() {
		return chat_no;
	}

	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}

	public int getMember_clientno() {
		return member_clientno;
	}

	public void setMember_clientno(int member_clientno) {
		this.member_clientno = member_clientno;
	}

	public int getMember_hostno() {
		return member_hostno;
	}

	public void setMember_hostno(int member_hostno) {
		this.member_hostno = member_hostno;
	}

	public Date getChat_date() {
		return chat_date;
	}

	public void setChat_date(Date chat_date) {
		this.chat_date = chat_date;
	}

	public String getChat_content() {
		return chat_content;
	}

	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}

}
