package com.lan.tour.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lan.tour.model.dao.CommentDao;
import com.lan.tour.model.dto.CommentDto;

@Service
public class CommentBizImpl implements CommentBiz {

	@Autowired
	private CommentDao dao;
	
	@Override
	public List<CommentDto> selectList(int community_no) {
		// TODO Auto-generated method stub
		return dao.selectList(community_no);
	}

	@Override
	public int insert(CommentDto dto) {
		// TODO Auto-generated method stub
		return dao.insert(dto);
	}

	@Override
	public int update(CommentDto dto) {
		// TODO Auto-generated method stub
		return dao.update(dto);
	}

	@Override
	public int delete(int comment_no) {
		// TODO Auto-generated method stub
		return dao.delete(comment_no);
	}

	@Override
	public int deleteAll(int community_no) {
		// TODO Auto-generated method stub
		return dao.deleteAll(community_no);
	}
	
	@Override
	public List<CommentDto> commentlist() {
		// TODO Auto-generated method stub
		return dao.commentlist();
	}

	@Override
	public int commentMemberDelete(int member_no) {
		// TODO Auto-generated method stub
		return dao.commentMemberDelete(member_no);
	}

}
