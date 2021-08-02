package com.lan.tour.model.dto;

public class CalendarDto {
	
	private int cal_no;
	private int member_no;
	private String cal_title;
	private String cal_content;
	private String cal_startdate;
	private String cal_enddate;
	
	
	public CalendarDto() {
	}


	public CalendarDto(int cal_no, int member_no, String cal_title, String cal_content, String cal_startdate,
			String cal_enddate) {
		this.cal_no = cal_no;
		this.member_no = member_no;
		this.cal_title = cal_title;
		this.cal_content = cal_content;
		this.cal_startdate = cal_startdate;
		this.cal_enddate = cal_enddate;
	}


	public int getCal_no() {
		return cal_no;
	}


	public void setCal_no(int cal_no) {
		this.cal_no = cal_no;
	}


	public int getMember_no() {
		return member_no;
	}


	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}


	public String getCal_title() {
		return cal_title;
	}


	public void setCal_title(String cal_title) {
		this.cal_title = cal_title;
	}


	public String getCal_content() {
		return cal_content;
	}


	public void setCal_content(String cal_content) {
		this.cal_content = cal_content;
	}


	public String getCal_startdate() {
		return cal_startdate;
	}


	public void setCal_startdate(String cal_startdate) {
		this.cal_startdate = cal_startdate;
	}


	public String getCal_enddate() {
		return cal_enddate;
	}


	public void setCal_enddate(String cal_enddate) {
		this.cal_enddate = cal_enddate;
	}
	
	
	
	
	
	

}
