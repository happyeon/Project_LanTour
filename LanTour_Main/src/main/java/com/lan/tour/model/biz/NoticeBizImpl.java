package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.NoticeDao;
import com.lan.tour.model.dto.NoticeDto;
import com.lan.tour.model.dto.NoticePagingDto;

@Service
public class NoticeBizImpl implements NoticeBiz {

	@Autowired
	private NoticeDao dao;

	@Override
	public List<NoticeDto> selectList(NoticePagingDto dto) {

		return dao.selectList(dto);
	}

	@Override
	public NoticeDto selectOne(int notice_no) {

		return dao.selectOne(notice_no);
	}

	@Override
	public int insert(NoticeDto dto) {

		return dao.insert(dto);
	}

	@Override
	public int update(NoticeDto dto) {

		return dao.update(dto);
	}

	@Override
	public int delete(int notice_no) {

		return dao.delete(notice_no);
	}
	
	@Override
	public int countTotal() {

		return dao.countTotal();
	}

	@Override
	public List<NoticeDto> selectTitleList(NoticePagingDto dto) {

		return dao.selectTitleList(dto);
	}

	@Override
	public List<NoticeDto> selectContentList(NoticePagingDto dto) {

		return dao.selectContentList(dto);
	}

	@Override
	public List<NoticeDto> selectTCList(NoticePagingDto dto) {

		return dao.selectTCList(dto);
	}

	@Override
	public int countT(String category) {

		return dao.countT(category);
	}

	@Override
	public int countC(String category) {

		return dao.countC(category);
	}

	@Override
	public int countTC(String category) {
		return dao.countTC(category);
	}
	
	@Override
	public List<NoticeDto> noticelist() {
		// TODO Auto-generated method stub
		return dao.noticelist();
	}

	@Override
	public int noticeupdate(NoticeDto dto) {
		// TODO Auto-generated method stub
		return dao.noticeupdate(dto);
	}

	@Override
	public int popUpdate(NoticeDto dto) {
		return dao.popUpdate(dto);
	}

	@Override
	public List<NoticeDto> selectPopupList() {
		// TODO Auto-generated method stub
		return dao.selectPopupList();
	}

	
	
	
}
