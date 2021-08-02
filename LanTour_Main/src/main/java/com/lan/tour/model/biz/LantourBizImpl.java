package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.LantourDao;
import com.lan.tour.model.dto.LantourDto;
import com.lan.tour.model.dto.LantourPagingDto;
@Service
public class LantourBizImpl implements LantourBiz {
	
	@Autowired
	private LantourDao dao;
	
	@Override
	public List<LantourDto> selectList(LantourPagingDto dto) {
		// TODO Auto-generated method stub
		return dao.selectList(dto);
	}

	@Override
	public List<LantourDto> lantourList() {
		// TODO Auto-generated method stub
		return dao.lantourList();
	}
	
	@Override
	public List<LantourDto> listAll(String search_option, String keyword,int start, int end) {
		// TODO Auto-generated method stub
		System.out.println("listAll");
		return dao.listAll(search_option, keyword, start, end);
	}

	@Override
	public List<LantourDto> selectTitleList(LantourPagingDto dto) {
		// TODO Auto-generated method stub
		return dao.selectTitleList(dto);
	}
	
	@Override
	public List<LantourDto> selectContentList(LantourPagingDto dto) {
		// TODO Auto-generated method stub
		return dao.selectContentList(dto);
	}
	
	@Override
	public List<LantourDto> selectTCList(LantourPagingDto dto) {
		// TODO Auto-generated method stub
		return dao.selectTCList(dto);
	}
	
	@Override
	public int countT(String category) {
		// TODO Auto-generated method stub
		return dao.countT(category);
	}
	@Override
	public int countC(String category) {
		// TODO Auto-generated method stub
		return dao.countC(category);
	}

	@Override
	public int countTotal() {
		// TODO Auto-generated method stub
		return dao.countTotal();
	}

	@Override
	public List<LantourDto> selectList(int member_no) {
		// TODO Auto-generated method stub
		return dao.selectList(member_no);
	}

	@Override
	public LantourDto selectOne(int lantour_no) {
		// TODO Auto-generated method stub
		return dao.selectOne(lantour_no);
	}

	@Override
	public int insert(LantourDto dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	@Override
	public int delete(int lantour_no) {
		// TODO Auto-generated method stub
		return dao.delete(lantour_no);
	}

	@Override
	public int update(LantourDto dto) {
		// TODO Auto-generated method stub
		return dao.update(dto);
	}
	
	@Override
	public int rtcupdate(LantourDto dto) {
		return dao.rtcupdate(dto);
	}

	@Override
	public List<LantourDto> lantourchart() {
		// TODO Auto-generated method stub
		return dao.lantourchart();
	}

	@Override
	public int deleteByMemberNo(int member_no) {
		return dao.deleteByMemberNo(member_no);
	}
	
	
}
