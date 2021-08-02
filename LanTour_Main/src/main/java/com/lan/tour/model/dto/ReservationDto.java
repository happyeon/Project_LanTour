package com.lan.tour.model.dto;

import java.util.Date;

public class ReservationDto {

	private int reservation_no;
	private int lantour_no;
	private int room_no;
	private int hotel_no;
	private int member_no;
	private String reservation_date;
	private String reservation_checkout_date;
	private int reservation_price;
	private String reservation_pay;
	private Date reservation_paydate;
	private String lantour_title;
	private String hotel_title;
	private String room_name;
	private int count;
	private String pay_date;

	public ReservationDto() {

	}

	public ReservationDto(int lantour_no, int member_no) {
		this.lantour_no = lantour_no;
		this.member_no = member_no;
	}

	public ReservationDto(int reservation_no, int lantour_no, int room_no, int hotel_no, int member_no,
			String reservation_date, String reservation_checkout_date, int reservation_price, String reservation_pay,
			Date reservation_paydate, int count, String pay_date) {
		this.reservation_no = reservation_no;
		this.lantour_no = lantour_no;
		this.room_no = room_no;
		this.hotel_no = hotel_no;
		this.member_no = member_no;
		this.reservation_date = reservation_date;
		this.reservation_checkout_date = reservation_checkout_date;
		this.reservation_price = reservation_price;
		this.reservation_pay = reservation_pay;
		this.reservation_paydate = reservation_paydate;
		this.count = count;
		this.pay_date = pay_date;
	}

	public int getReservation_no() {
		return reservation_no;
	}

	public void setReservation_no(int reservation_no) {
		this.reservation_no = reservation_no;
	}

	public int getLantour_no() {
		return lantour_no;
	}

	public void setLantour_no(int lantour_no) {
		this.lantour_no = lantour_no;
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

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getReservation_date() {
		return reservation_date;
	}

	public void setReservation_date(String reservation_date) {
		this.reservation_date = reservation_date;
	}

	public String getReservation_checkout_date() {
		return reservation_checkout_date;
	}

	public void setReservation_checkout_date(String reservation_checkout_date) {
		this.reservation_checkout_date = reservation_checkout_date;
	}

	public int getReservation_price() {
		return reservation_price;
	}

	public void setReservation_price(int reservation_price) {
		this.reservation_price = reservation_price;
	}

	public String getReservation_pay() {
		return reservation_pay;
	}

	public void setReservation_pay(String reservation_pay) {
		this.reservation_pay = reservation_pay;
	}

	public Date getReservation_paydate() {
		return reservation_paydate;
	}

	public void setReservation_paydate(Date reservation_paydate) {
		this.reservation_paydate = reservation_paydate;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getLantour_title() {
		return lantour_title;
	}

	public void setLantour_title(String lantour_title) {
		this.lantour_title = lantour_title;
	}

	public String getHotel_title() {
		return hotel_title;
	}

	public void setHotel_title(String hotel_title) {
		this.hotel_title = hotel_title;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	
	public String getPay_date() {
		return pay_date;
	}

	public void setPay_date(String pay_date) {
		this.pay_date = pay_date;
	}

}
