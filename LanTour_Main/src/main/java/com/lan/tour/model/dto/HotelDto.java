package com.lan.tour.model.dto;

import java.util.Date;

public class HotelDto {

	private int hotel_no;
	private int member_no;
	private String hotel_type;
	private String hotel_title;
	private String hotel_content;
	private Date hotel_regdate;
	private int hotel_price;
	private String hotel_addr;
	private String hotel_image;
	private String hotel_convinence;
	private int hotel_maxcount;;
	private int hotel_minprice;
	private int hotel_maxprice;
	private int count;
	private String regdate;

	public HotelDto() {

	}

	public HotelDto(int hotel_no, int member_no, String hotel_type, String hotel_title, String hotel_content,
			Date hotel_regdate, int hotel_price, String hotel_addr, String hotel_image, String hotel_convinence,
			int hotel_maxcount, int hotel_minprice, int hotel_maxprice, int count, String regdate) {
		this.hotel_no = hotel_no;
		this.member_no = member_no;
		this.hotel_type = hotel_type;
		this.hotel_title = hotel_title;
		this.hotel_content = hotel_content;
		this.hotel_regdate = hotel_regdate;
		this.hotel_price = hotel_price;
		this.hotel_addr = hotel_addr;
		this.hotel_image = hotel_image;
		this.hotel_convinence = hotel_convinence;
		this.hotel_maxcount = hotel_maxcount;
		this.hotel_minprice = hotel_minprice;
		this.hotel_maxprice = hotel_maxprice;
		this.count = count;
		this.regdate = regdate;
	}

	public int getHotel_no() {
		return hotel_no;
	}

	public void setHotel_no(int hotel_no) {
		this.hotel_no = hotel_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getHotel_type() {
		return hotel_type;
	}

	public void setHotel_type(String hotel_type) {
		this.hotel_type = hotel_type;
	}

	public String getHotel_title() {
		return hotel_title;
	}

	public void setHotel_title(String hotel_title) {
		this.hotel_title = hotel_title;
	}

	public String getHotel_content() {
		return hotel_content;
	}

	public void setHotel_content(String hotel_content) {
		this.hotel_content = hotel_content;
	}

	public Date getHotel_regdate() {
		return hotel_regdate;
	}

	public void setHotel_regdate(Date hotel_regdate) {
		this.hotel_regdate = hotel_regdate;
	}

	public int getHotel_price() {
		return hotel_price;
	}

	public void setHotel_price(int hotel_price) {
		this.hotel_price = hotel_price;
	}

	public String getHotel_addr() {
		return hotel_addr;
	}

	public void setHotel_addr(String hotel_addr) {
		this.hotel_addr = hotel_addr;
	}

	public String getHotel_image() {
		return hotel_image;
	}

	public void setHotel_image(String hotel_image) {
		this.hotel_image = hotel_image;
	}

	public String getHotel_convinence() {
		return hotel_convinence;
	}

	public void setHotel_convinence(String hotel_convinence) {
		this.hotel_convinence = hotel_convinence;
	}

	public int getHotel_maxcount() {
		return hotel_maxcount;
	}

	public void setHotel_maxcount(int hotel_maxcount) {
		this.hotel_maxcount = hotel_maxcount;
	}

	public int getHotel_minprice() {
		return hotel_minprice;
	}

	public void setHotel_minprice(int hotel_minprice) {
		this.hotel_minprice = hotel_minprice;
	}

	public int getHotel_maxprice() {
		return hotel_maxprice;
	}

	public void setHotel_maxprice(int hotel_maxprice) {
		this.hotel_maxprice = hotel_maxprice;
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
