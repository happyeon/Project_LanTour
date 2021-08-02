package com.lan.tour.model.dao;

import java.util.List;

import com.lan.tour.model.dto.HotelDto;

public interface HotelDao {

	String NAMESPACE = "hotel.";

	public List<HotelDto> selectList();

	public HotelDto selectOne(int hotel_no);

	public int insert(HotelDto dto);

	public int delete(int hotel_no);

	public int update (HotelDto dto);
	
	public List<HotelDto> searchList(HotelDto dto);
	
	public List<HotelDto> hotelchart();

	public List<HotelDto> selectList(int member_no);

	public int deleteByMemberNo(int member_no);
}
