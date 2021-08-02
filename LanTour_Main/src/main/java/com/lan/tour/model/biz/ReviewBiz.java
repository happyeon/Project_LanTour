package com.lan.tour.model.biz;

import java.util.List;
import java.util.Map;

import com.lan.tour.model.dto.ReviewDto;


public interface ReviewBiz {

	
	public List<ReviewDto> selectList(String type, int no);
	public List<ReviewDto> scoreList(String type);
	public ReviewDto selectscore(String type, int no);
	public ReviewDto selectOne(String type, int review_no);
	public int insert(ReviewDto dto);
	public int delete(int number);
	public int update(ReviewDto dto);
	public List<ReviewDto> selectList(String type, Map<String, Integer> smap, String sort, String filter);
	public int deleteByMemberNo(int Member_no);
	public int deleteByLantourNo(int Lantour_no);
	public int deleteByHotelNo(int hotel_no);

	
	
	
}
