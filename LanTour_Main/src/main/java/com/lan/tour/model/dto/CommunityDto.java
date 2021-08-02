package com.lan.tour.model.dto;

import java.util.Date;

public class CommunityDto {
	private int community_no;
	private int member_no;
	private String community_title;
	private String community_content;
	private Date community_regdate;
	private int community_readcount;
	private String community_delflag;
	private String member_name;
	private int count;
	private String regdate;

	public CommunityDto() {
		// TODO Auto-generated constructor stub
	}

	public CommunityDto(int community_no, int member_no, String community_title, String community_content,
			Date community_regdate, int community_readcount, String community_delflag, String member_name, int count,
			String regdate) {
		this.community_no = community_no;
		this.member_no = member_no;
		this.community_title = community_title;
		this.community_content = community_content;
		this.community_regdate = community_regdate;
		this.community_readcount = community_readcount;
		this.community_delflag = community_delflag;
		this.member_name = member_name;
		this.count = count;
		this.regdate = regdate;
	}

	public int getCommunity_no() {
		return community_no;
	}

	public void setCommunity_no(int community_no) {
		this.community_no = community_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getCommunity_title() {
		return community_title;
	}

	public void setCommunity_title(String community_title) {
		this.community_title = community_title;
	}

	public String getCommunity_content() {
		return community_content;
	}

	public void setCommunity_content(String community_content) {
		this.community_content = community_content;
	}

	public Date getCommunity_regdate() {
		return community_regdate;
	}

	public void setCommunity_regdate(Date community_regdate) {
		this.community_regdate = community_regdate;
	}

	public int getCommunity_readcount() {
		return community_readcount;
	}

	public void setCommunity_readcount(int community_readcount) {
		this.community_readcount = community_readcount;
	}

	public String getCommunity_delflag() {
		return community_delflag;
	}

	public void setCommunity_delflag(String community_delflag) {
		this.community_delflag = community_delflag;
	}

	public String getMember_name() {
		return member_name;
	}

	public void setMember_name(String member_name) {
		this.member_name = member_name;
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
