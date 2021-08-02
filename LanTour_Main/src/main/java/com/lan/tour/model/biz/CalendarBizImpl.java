package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.CalendarDao;
import com.lan.tour.model.dto.CalendarDto;

@Service
public class CalendarBizImpl implements CalendarBiz {
	
	@Autowired
	private CalendarDao dao;

	@Override
	public List<CalendarDto> selectList(int member_no) {

		return dao.selectList(member_no);
	}
	
	@Override
	public CalendarDto selectOne(int cal_no) {

		return dao.selectOne(cal_no);
	}

	@Override
	public int insert(CalendarDto dto) {

		return dao.insert(dto);
	}

	@Override
	public int update(CalendarDto dto) {

		return dao.update(dto);
	}

	@Override
	public int delete(int cal_no) {

		return dao.delete(cal_no);
	}

	@Override
	public int dragUpdate(CalendarDto dto) {
		
		return dao.dragUpdate(dto);
	}

	@Override
	public int deleteByMemberNo(int member_no) {
		// TODO Auto-generated method stub
		return dao.deleteByMemberNo(member_no);
	}

}
