package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.RoomDao;
import com.lan.tour.model.dto.RoomDto;

@Service
public class RoomBizImpl implements RoomBiz {

	@Autowired
	private RoomDao dao;
	
	@Override
	public List<RoomDto> selectList(int hotel_no) {
		// TODO Auto-generated method stub
		return dao.selectList(hotel_no);
	}
	
	@Override
	public RoomDto selectOne(int room_no) {
		// TODO Auto-generated method stub
		return dao.selectOne(room_no);
	}

	@Override
	public int insert(RoomDto dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	@Override
	public int delete(int room_no) {
		// TODO Auto-generated method stub
		return dao.delete(room_no);
	}

	@Override
	public int deleteAll(int hotel_no) {
		// TODO Auto-generated method stub
		return dao.deleteAll(hotel_no);
	}


}
