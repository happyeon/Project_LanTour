package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.CommunityDto;

@Repository
public class CommunityDaoImpl implements CommunityDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<CommunityDto> selectList() {
		// TODO Auto-generated method stub
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "community_selectList");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public CommunityDto selectOne(int community_no) {
		// TODO Auto-generated method stub
		CommunityDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE + "community_selectOne", community_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int insert(CommunityDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE + "community_insert", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public int update(CommunityDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE + "community_update", dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public int delete(int community_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE + "community_delete", community_no);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return res;
	}

	@Override
	public List<CommunityDto> selecttitlesearchList(String community_title) {
		// TODO Auto-generated method stub
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "community_titleSearch", community_title);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CommunityDto> selectcontentsearchList(String community_content) {
		// TODO Auto-generated method stub
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "community_contentSearch", community_content);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<CommunityDto> selectnamesearchList(String member_name) {
		// TODO Auto-generated method stub
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "community_nameSearch", member_name);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<CommunityDto> boardlist() {
		// TODO Auto-generated method stub
		List <CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"boardlist");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public int boardupdate(CommunityDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"boardupdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return res;
	}

	@Override
	public int communityAlldelete(int community_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"communityAlldelete", community_no);
		} catch(Exception e){
			e.printStackTrace();
		}
		return res;
	}


	@Override
	public int readcount(int community_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"readcount_update", community_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int community_refaire(int community_no) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"community_refaired",community_no );
		}catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<CommunityDto> communitychart() {
		// TODO Auto-generated method stub
		List <CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"communitychart");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<CommunityDto> mypostList(int member_no) {
		
		List<CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE + "mypost_selectList", member_no);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<CommunityDto> selectlistmember(int member_no) {
		// TODO Auto-generated method stub
		List <CommunityDto> list = new ArrayList<CommunityDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"selectlistmember", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

}
