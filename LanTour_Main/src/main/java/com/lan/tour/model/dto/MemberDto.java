package com.lan.tour.model.dto;

public class MemberDto {

	private int member_no;
	private String member_id;
	private String member_name;
	private String member_password;
	private String member_grade;
	private int member_age;
	private String member_gender;
	private String member_email;
	private String member_phone;
	private String member_secession;
	private int count;
	private String regdate;

	public MemberDto() {
	}

	public MemberDto(int member_no, String member_id, String member_name, String member_password, String member_grade,
			int member_age, String member_gender, String member_email, String member_phone, String member_secession,
			int count, String regdate) {
		this.member_no = member_no;
		this.member_id = member_id;
		this.member_name = member_name;
		this.member_password = member_password;
		this.member_grade = member_grade;
		this.member_age = member_age;
		this.member_gender = member_gender;
		this.member_email = member_email;
		this.member_phone = member_phone;
		this.member_secession = member_secession;
		this.count = count;
		this.regdate = regdate;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	public String getMember_password() {
		return member_password;
	}

	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}

	public String getMember_grade() {
		return member_grade;
	}

	public void setMember_grade(String member_grade) {
		this.member_grade = member_grade;
	}

	public int getMember_age() {
		return member_age;
	}

	public void setMember_age(int member_age) {
		this.member_age = member_age;
	}

	public String getMember_gender() {
		return member_gender;
	}

	public void setMember_gender(String member_gender) {
		this.member_gender = member_gender;
	}

	public String getMember_email() {
		return member_email;
	}

	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}

	public String getMember_phone() {
		return member_phone;
	}

	public void setMember_phone(String member_phone) {
		this.member_phone = member_phone;
	}

	public String getMember_secession() {
		return member_secession;
	}

	public void setMember_secession(String member_secession) {
		this.member_secession = member_secession;
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
