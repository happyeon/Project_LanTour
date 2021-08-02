package com.lan.tour.model.biz;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.ReservationDao;
import com.lan.tour.model.dto.ReservationDto;

@Service
public class ReservationBizImpl implements ReservationBiz {
	
	@Autowired
	private ReservationDao dao;

	@Override
	public List<ReservationDto> selectList() {
		return dao.selectList();
	}

	@Override
	public ReservationDto selectOne(ReservationDto dto) {
		return dao.selectOne(dto);
	}

	@Override
	public List<ReservationDto> selectList(String type, int no, int rno) {
		return dao.selectList(type, no, rno);
	}

	@Override
	public List<ReservationDto> countDate(String date, int no) {
		return dao.countDate(date, no);
	}

	@Override
	public int insert(ReservationDto dto) {
		return dao.insert(dto);
	}

	@Override
	public List<ReservationDto> selectList(int m_no) {
		return dao.selectList(m_no);
	}

	@Override
	public int updatepay(ReservationDto dto) {
		return dao.updatepay(dto);
	}

	@Override
	public ReservationDto selectOne(int Reservation_no) {
		return dao.selectOne(Reservation_no);
	}
	
	@Override
	public List<ReservationDto> selectListLanM(int member_no) {

		return dao.selectListLanM(member_no);
	}

	@Override
	public List<ReservationDto> selectListRoomM(int member_no) {

		return dao.selectListRoomM(member_no);
	}

	@Override
	public List<ReservationDto> selectListCheckDate(String check_in, String check_out, String hotel_type) {
		return dao.selectListCheckDate(check_in,check_out,hotel_type);
	}

	@Override
	public List<ReservationDto> selectListJoin(int member_no) {
		return dao.selectListJoin(member_no);
	}

	@Override
	public ReservationDto selectcount(String type, int no) {
		return dao.selectcount(type,no);
	}
	public List<ReservationDto> selectchart() {
		// TODO Auto-generated method stub
		return dao.selectchart();
	}

	@Override
	public int deleteByMemberNo(int member_no) {
		// TODO Auto-generated method stub
		return dao.deleteByMemberNo(member_no);
	}

	@Override
	public List<ReservationDto> selectListRooomByDate(String check_in, String check_out, int hotel_no) {
		return dao.selectListRooomByDate( check_in,  check_out,  hotel_no);
	}

}
