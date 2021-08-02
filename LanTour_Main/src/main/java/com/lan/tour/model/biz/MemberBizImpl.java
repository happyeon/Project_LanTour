package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.MemberDao;
import com.lan.tour.model.dto.MemberDto;

@Service
public class MemberBizImpl implements MemberBiz {

	@Autowired
	private MemberDao dao;

	@Override
	public List<MemberDto> selectList() {
		return dao.selectList();
	}

	@Override
	public MemberDto selectOne(int member_no) {
		return dao.selectOne(member_no);
	}

	@Override
	public int update(MemberDto dto) {
		return dao.update(dto);
	}

	@Override
	public int delete(int member_no) {
		return dao.delete(member_no);
	}

	@Override
	public int insert(MemberDto dto) {
		return dao.insert(dto);
	}

	@Override
	public MemberDto idCheck(MemberDto dto) {
		return dao.idCheck(dto);
	}

	@Override
	public List<MemberDto> memberList() {
		// TODO Auto-generated method stub
		return dao.memberList();
	}

	@Override
	public int memberupdate(MemberDto dto) {
		// TODO Auto-generated method stub
		return dao.memberupdate(dto);
	}

	@Override
	public String findId(MemberDto dto) {
		// TODO Auto-generated method stub
		return dao.findId(dto);
	}

	@Override
	public MemberDto findpw(MemberDto dto) {
		// TODO Auto-generated method stub
		return dao.findpw(dto);
	}

	@Override
	public int updatepw(MemberDto dto) {
		// TODO Auto-generated method stub
		return dao.updatepw(dto);
	}

	@Override
	public MemberDto checkEmail(String member_email) {
		return dao.checkEmail(member_email);
	}

	@Override
	public List<MemberDto> searchmember(String member_id) {
		// TODO Auto-generated method stub
		return dao.searchmember(member_id);
	}

	@Override
	public List<MemberDto> manchartmember() {
		// TODO Auto-generated method stub
		return dao.manchartmember();
	}

	@Override
	public List<MemberDto> womanchartmember() {
		// TODO Auto-generated method stub
		return dao.womanchartmember();
	}

	@Override
	public int deleteByMemberNo(int member_no) {
		// TODO Auto-generated method stub
		return dao.deleteByMemberNo(member_no);
	}

}
