package com.lan.tour.model.biz;

import java.util.List;

import com.lan.tour.model.dto.CalendarDto;

public interface CalendarBiz {
	
	public List<CalendarDto> selectList(int member_no);
	public CalendarDto selectOne(int cal_no);
	public int insert(CalendarDto dto);
	public int update(CalendarDto dto);
	public int delete(int cal_no);
	public int dragUpdate(CalendarDto dto);
	public int deleteByMemberNo(int member_no);

}
