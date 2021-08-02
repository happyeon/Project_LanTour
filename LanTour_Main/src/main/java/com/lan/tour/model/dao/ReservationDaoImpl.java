package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.ReservationDto;
import com.lan.tour.model.dto.ReviewDto;

@Repository
public class ReservationDaoImpl implements ReservationDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<ReservationDto> selectList() {
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "selectlist");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public ReservationDto selectOne(ReservationDto dto) {

		ReservationDto res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE + "selectOne", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public List<ReservationDto> selectList(String type, int no, int rno) {
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		if (type.equals("hotel")) {
			if (rno == 0) {
				try {
					int hotel_no = no;
					list = sqlSession.selectList(NAMESPACE + "selectList_hotel", hotel_no);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				Map<String, Integer> map = new HashMap<String, Integer>();
				map.put("hotel_no", no);
				map.put("room_no", rno);
				try {
					list = sqlSession.selectList(NAMESPACE + "selectList_room", map);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		} else {
			try {
				int lantour_no = no;
				list = sqlSession.selectList(NAMESPACE + "selectList_lantour", lantour_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}

	@Override
	public List<ReservationDto> countDate(String date, int no) {
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		ReservationDto dto = new ReservationDto();
		dto.setReservation_date(date);
		dto.setLantour_no(no);
		try {
			list = sqlSession.selectList(NAMESPACE + "countDate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int insert(ReservationDto dto) {
		int res = 0;
		if (dto.getRoom_no() == 0) {
			try {
				res = sqlSession.insert(NAMESPACE + "insert_lantour", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else {
			try {
				res = sqlSession.insert(NAMESPACE + "insert_room", dto);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return res;
	}

	@Override
	public List<ReservationDto> selectList(int member_no) {
		List<ReservationDto> list = new ArrayList<ReservationDto>();

		try {
			list = sqlSession.selectList(NAMESPACE + "selectlist_MemberNo", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int updatepay(ReservationDto dto) {
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "update_pay", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public ReservationDto selectOne(int reservaition_no) {
		
		ReservationDto res = new ReservationDto();

		try {
			res = sqlSession.selectOne(NAMESPACE + "selectOne_Res", reservaition_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public List<ReservationDto> selectListLanM(int member_no) {
		List<ReservationDto> list = new  ArrayList<ReservationDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "selectList_M_lan", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<ReservationDto> selectListRoomM(int member_no) {

		List<ReservationDto> list = new ArrayList<ReservationDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "selectList_M_room", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<ReservationDto> selectListCheckDate(String check_in, String check_out, String hotel_type) {
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		Map<String, String> map = new HashMap<>();
		map.put("check_in", check_in);
		map.put("check_out", check_out);
		map.put("hotel_type", hotel_type);
		try {
			list = sqlSession.selectList(NAMESPACE + "searchHoteldate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<ReservationDto> selectListJoin(int member_no) {

		List<ReservationDto> list = new ArrayList<ReservationDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"selectListJoin",member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public ReservationDto selectcount(String type, int no) {
		ReservationDto dto = new ReservationDto();
		if(type.equals("room")) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			int room_no = no;

			try {
				dto = sqlSession.selectOne(NAMESPACE+"selectcount_room", room_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		}else {
			try {
				int lantour_no = no;
				dto = sqlSession.selectOne(NAMESPACE+"selectcount_lantour", lantour_no);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	public List<ReservationDto> selectchart() {
		// TODO Auto-generated method stub
		List<ReservationDto> list = null;

		try {
			list = sqlSession.selectList(NAMESPACE + "reservationchart");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int deleteByMemberNo(int member_no) {
		int res = 0;

		try {
			res = sqlSession.delete(NAMESPACE + "deleteByMemberNo", member_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public List<ReservationDto> selectListRooomByDate(String check_in, String check_out, int hotel_no) {
		List<ReservationDto> list = new ArrayList<ReservationDto>();
		Map<String, String> map = new HashMap<String, String>();
		map.put("check_in", check_in);
		map.put("check_out", check_out);
		map.put("hotel_no", Integer.toString(hotel_no));
		try {
			list = sqlSession.selectList(NAMESPACE + "searchRoomdate", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
