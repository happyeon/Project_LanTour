package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.CommentDto;

@Repository
public class CommentDaoImpl implements CommentDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<CommentDto> selectList(int community_no) {
		// TODO Auto-generated method stub
		List<CommentDto> list = null;
		try {
			list = sqlSession.selectList(NAMESPACE+"selectList", community_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		 
		return list;
	}

	@Override
	public int insert(CommentDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int update(CommentDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"update", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int delete(int comment_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"delete", comment_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteAll(int community_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteAll", community_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<CommentDto> commentlist() {
		// TODO Auto-generated method stub
		List<CommentDto> list = new ArrayList<CommentDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"commentlist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int commentMemberDelete(int member_no) {
		int res = 0;

		try {
			res = sqlSession.delete(NAMESPACE+"commentmemberdelete", member_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

}
