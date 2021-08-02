package com.lan.tour.model.dao;

import java.util.List;

import com.lan.tour.model.dto.CommentDto;

public interface CommentDao {

	String NAMESPACE = "comment.";

	public List<CommentDto> selectList(int community_no);

	public int insert(CommentDto dto);

	public int update(CommentDto dto);

	public int delete(int comment_no);
	
	public int deleteAll(int community_no);
	
	public List<CommentDto> commentlist();
	public int commentMemberDelete(int member_no);
	
}
