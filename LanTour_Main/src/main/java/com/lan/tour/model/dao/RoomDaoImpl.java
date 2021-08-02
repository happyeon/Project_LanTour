package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.RoomDto;

@Repository
public class RoomDaoImpl implements RoomDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<RoomDto> selectList(int hotel_no) {
		// TODO Auto-generated method stub
		List<RoomDto> list = new ArrayList<RoomDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "roomselectlist", hotel_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public RoomDto selectOne(int room_no) {
		// TODO Auto-generated method stub
		RoomDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE + "roomselectOne", room_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public int insert(RoomDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "roominsert", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int delete(int room_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE + "roomdelete", room_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteAll(int hotel_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"roomdeleteAll", hotel_no);
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

}
