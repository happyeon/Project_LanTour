package com.lan.tour.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.CalendarDto;

@Repository
public class CalendarDaoImpl implements CalendarDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<CalendarDto> selectList(int member_no) {
		
		List<CalendarDto> list = null;
		
		try {
			list = sqlSession.selectList(NAMESPACE+"cal_selectList", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public CalendarDto selectOne(int cal_no) {
		CalendarDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "cal_selectOne", cal_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public int insert(CalendarDto dto) {
		
		int res = 0;

		try {
			res = sqlSession.insert(NAMESPACE+"cal_insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int update(CalendarDto dto) {
		
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"cal_update", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int delete(int cal_no) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"cal_delete", cal_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int dragUpdate(CalendarDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"cal_dargUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int deleteByMemberNo(int member_no) {
		
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"deleteByMemberNo", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}


}
