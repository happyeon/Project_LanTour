package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.NoticeDto;
import com.lan.tour.model.dto.NoticePagingDto;

@Repository
public class NoticeDaoImpl implements NoticeDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<NoticeDto> selectList(NoticePagingDto dto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "notice_selectlist", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public NoticeDto selectOne(int notice_no) {
		NoticeDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE + "notice_selectOne", notice_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public int insert(NoticeDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "notice_insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int update(NoticeDto dto) {
		int res = 0;

		try {
			res = sqlSession.update(NAMESPACE + "notice_update", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int delete(int notice_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE + "notice_delete", notice_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}
	
	@Override
	public int countTotal() {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "notice_countTotal");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<NoticeDto> selectTitleList(NoticePagingDto dto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "notice_selectlist_title", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<NoticeDto> selectContentList(NoticePagingDto dto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "notice_selectlist_content", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<NoticeDto> selectTCList(NoticePagingDto dto) {
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "notice_selectlist_title_content", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int countT(String category) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "notice_countT", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int countC(String category) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "notice_countC", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int countTC(String category) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE + "notice_countTC", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<NoticeDto> noticelist() {
		// TODO Auto-generated method stub
		List<NoticeDto> list = new ArrayList<NoticeDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"noticelist");
		} catch (Exception e) {
			
		}
		return list;
	}

	@Override
	public int noticeupdate(NoticeDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"noticeupdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int popUpdate(NoticeDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"popupdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<NoticeDto> selectPopupList() {
		List<NoticeDto> list =new ArrayList<NoticeDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"selectPopupList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
}
