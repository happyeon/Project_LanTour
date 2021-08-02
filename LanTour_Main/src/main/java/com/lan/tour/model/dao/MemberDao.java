package com.lan.tour.model.dao;

import java.util.List;

import com.lan.tour.model.dto.MemberDto;

public interface MemberDao {

	String NAMESPACE = "member.";

	public List<MemberDto> selectList();
	
	public MemberDto selectOne(int member_no);

	public int update(MemberDto dto);

	public int delete(int member_no);

	public int insert(MemberDto dto);

	public MemberDto idCheck(MemberDto dto);

	public List<MemberDto> memberList();

	public int memberupdate(MemberDto dto);
	
	public String findId(MemberDto dto);
	
	public MemberDto findpw(MemberDto dto);
	
	public int updatepw(MemberDto dto);

	public MemberDto checkEmail(String member_email);
	
	public List<MemberDto> searchmember(String member_id);
	
	public List<MemberDto> manchartmember();
	
	public List<MemberDto> womanchartmember();

	public int deleteByMemberNo(int member_no);
	
}
