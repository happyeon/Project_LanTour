package com.lan.tour.model.biz;

import java.util.List;

import com.lan.tour.model.dto.NoticeDto;
import com.lan.tour.model.dto.NoticePagingDto;

public interface NoticeBiz {

	public List<NoticeDto> selectList(NoticePagingDto dto);
	public NoticeDto selectOne(int notice_no);
	public int insert(NoticeDto dto);
	public int update(NoticeDto dto);
	public int delete(int notice_no);
	public int countTotal();
	public List<NoticeDto> selectTitleList(NoticePagingDto dto);
	public List<NoticeDto> selectContentList(NoticePagingDto dto);
	public List<NoticeDto> selectTCList(NoticePagingDto dto);
	public int countT(String category);
	public int countC(String category);
	public int countTC(String category);
	
	public List<NoticeDto> noticelist();
	
	public int noticeupdate(NoticeDto dto);

	public List<NoticeDto> selectPopupList();
	public int popUpdate(NoticeDto dto);
}
