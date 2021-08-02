package com.lan.tour.model.dao;

import java.util.List;

import com.lan.tour.model.dto.LantourDto;
import com.lan.tour.model.dto.LantourPagingDto;

public interface LantourDao {

	String NAMESPACE = "lantour.";

	public List<LantourDto> selectList(LantourPagingDto dto);

	public List<LantourDto> lantourList();
	
	public List<LantourDto> listAll(String search_option, String keyword,int start, int end);

	public List<LantourDto> selectTitleList(LantourPagingDto dto);

	public List<LantourDto> selectContentList(LantourPagingDto dto);

	public List<LantourDto> selectTCList(LantourPagingDto dto);

	public int countT(String category);

	public int countC(String category);

	public int countTC(String category);

	public int countTotal();

	public LantourDto selectOne(int lantour_no);

	public int insert(LantourDto dto);

	public int delete(int lantour_no);

	public int update(LantourDto dto);

	public int rtcupdate(LantourDto dto);

	public List<LantourDto> lantourchart();

	public List<LantourDto> selectList(int member_no);

	public int deleteByMemberNo(int member_no);

}
