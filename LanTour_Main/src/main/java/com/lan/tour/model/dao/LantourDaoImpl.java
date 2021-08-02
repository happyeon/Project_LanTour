package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.LantourDto;

import com.lan.tour.model.dto.LantourPagingDto;

@Repository
public class LantourDaoImpl implements LantourDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<LantourDto> selectList(LantourPagingDto dto) {

		List<LantourDto> list = new ArrayList<LantourDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "lantour_selectlist");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	@Override
	public List<LantourDto> selectList(int member_no) {
		
		List<LantourDto> res = new ArrayList<LantourDto>();
		try {
			res = sqlSession.selectList(NAMESPACE+"lantourlist_member",member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public LantourDto selectOne(int lantour_no) {
		LantourDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE + "lantourOne", lantour_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int insert(LantourDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "lantourinsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int delete(int lantour_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE + "lantourdelete", lantour_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int update(LantourDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE + "lantourupdate", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int rtcupdate(LantourDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE + "rtcupdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<LantourDto> lantourchart() {
		// TODO Auto-generated method stub
		List<LantourDto> list = null;
		try {
			list = sqlSession.selectList(NAMESPACE + "lantourchart");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}


	@Override
	public int countTotal() {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "lantour_countTotal");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<LantourDto> selectTitleList(LantourPagingDto dto) {
		List<LantourDto> list = new ArrayList<LantourDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "lantour_selectlist_title", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<LantourDto> selectContentList(LantourPagingDto dto) {
		List<LantourDto> list = new ArrayList<LantourDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "lantour_selectlist_content", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<LantourDto> selectTCList(LantourPagingDto dto) {
		List<LantourDto> list = new ArrayList<LantourDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "lantour_selectlist_title_content", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int countT(String category) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "lantour_countT", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int countC(String category) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "lantour_countC", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int countTC(String category) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "lantour_countTC", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<LantourDto> lantourList() {
		// TODO Auto-generated method stub
		List<LantourDto> list = new ArrayList<LantourDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"lantourlist");
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<LantourDto> listAll(String search_option, String keyword, int start, int end) {
		Map<String,Object> map = new HashMap<>();
        map.put("search_option", search_option);
        map.put("keyword", keyword);
        map.put("start", start); 
        map.put("end", end);
		
		return sqlSession.selectList(NAMESPACE+"listAll",map);
	}

	@Override
	public int deleteByMemberNo(int meber_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE + "deleteByMemberNo", meber_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
		
	}
	
	
}
