package com.lan.tour.model.dao;

import java.util.List;

import com.lan.tour.model.dto.RoomDto;

public interface RoomDao {

	String NAMESPACE = "room.";

	public List<RoomDto> selectList(int hotel_no);
	
	public RoomDto selectOne(int room_no);

	public int insert(RoomDto dto);

	public int delete(int room_no);
	
	public int deleteAll(int hotel_no);
}
