package com.lan.tour.model.dto;

import java.util.Date;

public class NoticeDto {
	
	private int notice_no;
	private int member_no;
	private String notice_title;
	private String notice_content;
	private Date notice_date;
	private String notice_popup;
	
	
	public NoticeDto() {
	}
	
	public NoticeDto(int notice_no, int member_no, String notice_title, String notice_content, Date notice_date) {
		this.notice_no = notice_no;
		this.member_no = member_no;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
		this.notice_date = notice_date;
	}
	
	public int getNotice_no() {
		return notice_no;
	}
	public void setNotice_no(int notice_no) {
		this.notice_no = notice_no;
	}
	public int getMember_no() {
		return member_no;
	}
	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}
	public String getNotice_title() {
		return notice_title;
	}
	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}
	public String getNotice_content() {
		return notice_content;
	}
	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}
	public Date getNotice_date() {
		return notice_date;
	}
	public void setNotice_date(Date notice_date) {
		this.notice_date = notice_date;
	}

	public String getNotice_popup() {
		return notice_popup;
	}

	public void setNotice_popup(String notice_popup) {
		this.notice_popup = notice_popup;
	}
}
