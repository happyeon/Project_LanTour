package com.lan.tour.model.dto;

public class RoomDto {

	private int room_no;
	private int hotel_no;
	private String room_content;
	private int room_price;
	private String room_convinence;
	private int room_maxcount;
	private String room_image;
	private String room_name;
	private int member_no;

	public RoomDto() {

	}

	public RoomDto(int room_no, int hotel_no, String room_content, int room_price, String room_convinence,
			int room_maxcount, String room_image, String room_name, int member_no) {
		this.room_no = room_no;
		this.hotel_no = hotel_no;
		this.room_content = room_content;
		this.room_price = room_price;
		this.room_convinence = room_convinence;
		this.room_maxcount = room_maxcount;
		this.room_image = room_image;
		this.room_name = room_name;
		this.member_no = member_no;
	}

	public int getRoom_no() {
		return room_no;
	}

	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}

	public int getHotel_no() {
		return hotel_no;
	}

	public void setHotel_no(int hotel_no) {
		this.hotel_no = hotel_no;
	}

	public String getRoom_content() {
		return room_content;
	}

	public void setRoom_content(String room_content) {
		this.room_content = room_content;
	}

	public int getRoom_price() {
		return room_price;
	}

	public void setRoom_price(int room_price) {
		this.room_price = room_price;
	}

	public String getRoom_convinence() {
		return room_convinence;
	}

	public void setRoom_convinence(String room_convinence) {
		this.room_convinence = room_convinence;
	}

	public int getRoom_maxcount() {
		return room_maxcount;
	}

	public void setRoom_maxcount(int room_maxcount) {
		this.room_maxcount = room_maxcount;
	}

	public String getRoom_image() {
		return room_image;
	}

	public void setRoom_image(String room_image) {
		this.room_image = room_image;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

}
