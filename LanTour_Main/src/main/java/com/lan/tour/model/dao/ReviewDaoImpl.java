package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.ReviewDto;

@Repository
public class ReviewDaoImpl implements ReviewDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<ReviewDto> selectList(String type, int no) {		
		List<ReviewDto> list = new ArrayList<ReviewDto>();
		switch(type){
			case "hotel":
				try {
					int hotel_no = no;
					list = sqlSession.selectList(NAMESPACE+"select_hotel", hotel_no);

				}catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lantour":
				try {
					int lantour_no = no;
					list = sqlSession.selectList(NAMESPACE+"select_lantour", lantour_no);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	@Override
	public List<ReviewDto> selectList(String type, Map<String, Integer> map, String sort, String filter) {		
		List<ReviewDto> list = new ArrayList<ReviewDto>();
		try {
			if(!filter.equals("date")) {
				switch(type){
					case "hotel":
						if(sort.equals("ASC")) {
								list = sqlSession.selectList(NAMESPACE+"search_hotel_asc", map);
							
						}else {
								list = sqlSession.selectList(NAMESPACE+"search_hotel_desc", map);
						}
						break;
					case "lantour":
						if(sort.equals("ASC")) {
								list = sqlSession.selectList(NAMESPACE+"search_lantour_asc", map);


						}else {
								list = sqlSession.selectList(NAMESPACE+"search_lantour_desc", map);
						}
						break;
				}		
			}else {
				switch(type){
					case "hotel":
						if(sort.equals("ASC")) {
								list = sqlSession.selectList(NAMESPACE+"search_hotel_date_asc", map);
							
						}else {
								list = sqlSession.selectList(NAMESPACE+"search_hotel_date_desc", map);
						}
						break;
					case "lantour":
						if(sort.equals("ASC")) {
								list = sqlSession.selectList(NAMESPACE+"search_lantour_date_asc", map);


						}else {
								list = sqlSession.selectList(NAMESPACE+"search_lantour_date_desc", map);
						}
						break;
				}		
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	

	@Override
	public ReviewDto selectOne(String type, int review_no) {	
		ReviewDto dto = null;
		switch(type){
			case "hotel":
				try {
					dto = sqlSession.selectOne(NAMESPACE+"select_one_hotel", review_no);

				}catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lantour":
				try {
					dto = sqlSession.selectOne(NAMESPACE+"select_one_lantour", review_no);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dto;
	}

	@Override
	public int insert(ReviewDto dto) {
		int res = 0;
		if(dto.getHotel_no()!=0) {
			try {
				res = sqlSession.insert(NAMESPACE+"insert_hotel", dto);
			}catch (Exception e) {
				e.printStackTrace();
			}			
		}else {
			try {
				res = sqlSession.insert(NAMESPACE+"insert_lantour", dto);
			}catch (Exception e) {
				e.printStackTrace();
			}				
		}
		return res;
	}

	@Override
	public int delete(int review_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"delete_review", review_no);
		}catch (Exception e) {
			e.printStackTrace();
		}			
		return res;
	}

	@Override
	public int update(ReviewDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"update_review", dto);
		}catch (Exception e) {
			e.printStackTrace();
		}		
		return res;
		
	}

	@Override
	public List<ReviewDto> scoreList(String type) {
		List<ReviewDto> list = new ArrayList<ReviewDto>();
		switch(type){
			case "hotel":
				try {
					list = sqlSession.selectList(NAMESPACE+"select_hotel_score_avg");

				}catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lantour":
				try {
					list = sqlSession.selectList(NAMESPACE+"select_lantour_score_avg");
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return list;
	}

	@Override
	public ReviewDto selectscore(String type, int no) {
		ReviewDto dto = new ReviewDto();
		switch(type){
			case "hotel":
				try {
					int hotel_no = no;
					dto = sqlSession.selectOne(NAMESPACE+"select_score_hotel", hotel_no);
				}catch (Exception e) {
					e.printStackTrace();
				}
				break;
			case "lantour":
				try {
					int lantour_no = no;
					dto = sqlSession.selectOne(NAMESPACE+"select_score_lantour", lantour_no);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
		return dto;
	}

	@Override
	public int deleteByMemberNo(int Member_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteMyReview", Member_no);
		}catch (Exception e) {
			e.printStackTrace();
		}			
		return res;
	}

	@Override
	public int deleteByLantourNo(int Lantour_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteHotelReview", Lantour_no);
		}catch (Exception e) {
			e.printStackTrace();
		}			
		return res;
	}

	@Override
	public int deleteByHotelNo(int hotel_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteLantourReview", hotel_no);
		}catch (Exception e) {
			e.printStackTrace();
		}			
		return res;
	}


	

}
