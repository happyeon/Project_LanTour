package com.lan.tour.model.biz;

import java.util.List;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.ReviewDao;
import com.lan.tour.model.dto.ReviewDto;

@Service
public class ReviewBizImpl implements ReviewBiz {

	@Autowired
	ReviewDao dao;

	@Override
	public List<ReviewDto> selectList(String type, int no) {
		return dao.selectList(type,no);
	}

	@Override
	public ReviewDto selectOne(String type, int review_no) {
		return dao.selectOne(type, review_no);
	}

	@Override
	public int insert(ReviewDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int delete(int number) {
		return dao.delete(number);
	}

	@Override
	public int update(ReviewDto dto) {
		return dao.update(dto);
	}

	@Override
	public List<ReviewDto> scoreList(String type) {
		return dao.scoreList(type);
	}

	@Override
	public List<ReviewDto> selectList(String type, Map<String, Integer> smap, String sort, String filter) {
		return dao.selectList(type, smap, sort, filter);
	}

	@Override
	public ReviewDto selectscore(String type, int no) {
		return dao.selectscore(type,no);
	}

	@Override
	public int deleteByMemberNo(int Member_no) {
		return dao.deleteByMemberNo(Member_no);
	}

	@Override
	public int deleteByLantourNo(int Lantour_no) {
		return dao.deleteByLantourNo(Lantour_no);
	}

	@Override
	public int deleteByHotelNo(int hotel_no) {
		return dao.deleteByHotelNo(hotel_no);
	}

	

}
