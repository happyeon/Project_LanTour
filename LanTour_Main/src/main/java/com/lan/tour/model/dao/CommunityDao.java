package com.lan.tour.model.dao;

import java.util.List;

import com.lan.tour.model.dto.CommunityDto;

public interface CommunityDao {

	String NAMESPACE = "community.";

	public List<CommunityDto> selectList();

	public CommunityDto selectOne(int community_no);

	public int insert(CommunityDto dto);

	public int update(CommunityDto dto);

	public int delete(int community_no);
	
	public List<CommunityDto> selecttitlesearchList(String community_title);

	public List<CommunityDto> selectcontentsearchList(String community_content);
	
	public List<CommunityDto> selectnamesearchList(String member_name);
	
	public int readcount(int community_no);

	public List<CommunityDto> boardlist();
	
	public int boardupdate(CommunityDto dto);
	
	public int communityAlldelete(int community_no);
	
	public int community_refaire(int community_no);
	
	public List<CommunityDto> communitychart();
	
	public List<CommunityDto> mypostList(int member_no);

	public List<CommunityDto> selectlistmember(int member_no);
	

}
