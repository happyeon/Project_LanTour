package com.lan.tour.model.dto;

import java.util.Date;

public class LantourDto {

	private int lantour_no;
	private int member_no;
	private String lantour_title;
	private String lantour_content;
	private Date lantour_regdate;
	private String lantour_rtc;
	private String lantour_addr;
	private String lantour_image;
	private int lantour_maxcount;
	private int lantour_price;
	private String lantour_date;
	private int count;
	private String regdate;

	public LantourDto() {

	}

	public LantourDto(int lantour_no, String lantour_rtc) {
		this.lantour_no = lantour_no;
		this.lantour_rtc = lantour_rtc;
	}

	public LantourDto(int lantour_no, int member_no, String lantour_title, String lantour_content, Date lantour_regdate,
			String lantour_rtc, String lantour_addr, String lantour_image, int lantour_maxcount, int lantour_price,
			String lantour_date, int count, String regdate) {
		this.lantour_no = lantour_no;
		this.member_no = member_no;
		this.lantour_title = lantour_title;
		this.lantour_content = lantour_content;
		this.lantour_regdate = lantour_regdate;
		this.lantour_rtc = lantour_rtc;
		this.lantour_addr = lantour_addr;
		this.lantour_image = lantour_image;
		this.lantour_maxcount = lantour_maxcount;
		this.lantour_price = lantour_price;
		this.lantour_date = lantour_date;
		this.count = count;
		this.regdate = regdate;
	}

	public int getLantour_no() {
		return lantour_no;
	}

	public void setLantour_no(int lantour_no) {
		this.lantour_no = lantour_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getLantour_title() {
		return lantour_title;
	}

	public void setLantour_title(String lantour_title) {
		this.lantour_title = lantour_title;
	}

	public String getLantour_content() {
		return lantour_content;
	}

	public void setLantour_content(String lantour_content) {
		this.lantour_content = lantour_content;
	}

	public Date getLantour_regdate() {
		return lantour_regdate;
	}

	public void setLantour_regdate(Date lantour_regdate) {
		this.lantour_regdate = lantour_regdate;
	}

	public String getLantour_rtc() {
		return lantour_rtc;
	}

	public void setLantour_rtc(String lantour_rtc) {
		this.lantour_rtc = lantour_rtc;
	}

	public String getLantour_addr() {
		return lantour_addr;
	}

	public void setLantour_addr(String lantour_addr) {
		this.lantour_addr = lantour_addr;
	}

	public String getLantour_image() {
		return lantour_image;
	}

	public void setLantour_image(String lantour_image) {
		this.lantour_image = lantour_image;
	}

	public int getLantour_maxcount() {
		return lantour_maxcount;
	}

	public void setLantour_maxcount(int lantour_maxcount) {
		this.lantour_maxcount = lantour_maxcount;
	}

	public int getLantour_price() {
		return lantour_price;
	}

	public void setLantour_price(int lantour_price) {
		this.lantour_price = lantour_price;
	}

	public String getLantour_date() {
		return lantour_date;
	}

	public void setLantour_date(String lantour_date) {
		this.lantour_date = lantour_date;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

}
