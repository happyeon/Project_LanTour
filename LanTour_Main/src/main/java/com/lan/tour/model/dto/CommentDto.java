package com.lan.tour.model.dto;


public class CommentDto {

	private int comment_no;
	private int member_no;
	private int community_no;
	private String comment_content;
	private String comment_date;
	private String comment_delflag;
	private String member_name;

	public CommentDto() {

	}

	public CommentDto(int comment_no, int member_no, int community_no, String comment_content, String comment_date,
			String comment_delflag, String member_name) {
		this.comment_no = comment_no;
		this.member_no = member_no;
		this.community_no = community_no;
		this.comment_content = comment_content;
		this.comment_date = comment_date;
		this.comment_delflag = comment_delflag;
		this.member_name = member_name;
	}

	public int getComment_no() {
		return comment_no;
	}

	public void setComment_no(int comment_no) {
		this.comment_no = comment_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getCommunity_no() {
		return community_no;
	}

	public void setCommunity_no(int community_no) {
		this.community_no = community_no;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public String getComment_date() {
		return comment_date;
	}

	public void setComment_date(String comment_date) {
		this.comment_date = comment_date;
	}

	public String getComment_delflag() {
		return comment_delflag;
	}

	public void setComment_delflag(String comment_delflag) {
		this.comment_delflag = comment_delflag;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}

	
}
