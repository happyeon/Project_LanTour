package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.CommunityDao;
import com.lan.tour.model.dto.CommunityDto;

@Service
public class CommunityBizImpl implements CommunityBiz {

	@Autowired
	private CommunityDao dao;
	
	@Override
	public List<CommunityDto> selectList() {
		// TODO Auto-generated method stub
		return dao.selectList();
	}

	@Override
	public CommunityDto selectOne(int community_no) {
		// TODO Auto-generated method stub
		return dao.selectOne(community_no);
	}

	@Override
	public int insert(CommunityDto dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	@Override
	public int update(CommunityDto dto) {
		// TODO Auto-generated method stub
		return dao.update(dto);
	}

	@Override
	public int delete(int community_no) {
		// TODO Auto-generated method stub
		return dao.delete(community_no);
	}

	@Override
	public List<CommunityDto> selecttitlesearchList(String community_title) {
		// TODO Auto-generated method stub
		return dao.selecttitlesearchList(community_title);
	}

	@Override
	public List<CommunityDto> selectcontentsearchList(String community_content) {
		// TODO Auto-generated method stub
		return dao.selectcontentsearchList(community_content);
	}

	@Override
	public List<CommunityDto> selectnamesearchList(String member_name) {
		// TODO Auto-generated method stub
		return dao.selectnamesearchList(member_name);
	}
	
	@Override
	public List<CommunityDto> boardlist() {
		// TODO Auto-generated method stub
		return dao.boardlist();
	}

	@Override
	public int readcount(int community_no) {
		// TODO Auto-generated method stub
		return dao.readcount(community_no);
	}

	@Override
	public int boardupdate(CommunityDto dto) {
		// TODO Auto-generated method stub
		return dao.boardupdate(dto);
	}

	@Override
	public int communityAlldelete(int community_no) {
		// TODO Auto-generated method stub
		return dao.communityAlldelete(community_no);
	}

	@Override
	public int community_refaire(int community_no) {
		// TODO Auto-generated method stub
		return dao.community_refaire(community_no);
	}

	@Override
	public List<CommunityDto> communitychart() {
		// TODO Auto-generated method stub
		return dao.communitychart();
	}
	
	@Override
	public List<CommunityDto> mypostList(int member_no) {
		// TODO Auto-generated method stub
		return dao.mypostList(member_no);
	}

	@Override
	public List<CommunityDto> selectlistmember(int member_no) {
		// TODO Auto-generated method stub
		return dao.selectlistmember(member_no);
	}


}
