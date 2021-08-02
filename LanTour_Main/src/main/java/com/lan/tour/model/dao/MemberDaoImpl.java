package com.lan.tour.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lan.tour.model.dto.MemberDto;


@Repository
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	@Override
	public List<MemberDto> selectList() {
		List<MemberDto> res = new ArrayList<MemberDto>();
		try {
			res = sqlSession.selectList(NAMESPACE+"selectList");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	



	@Override
	public MemberDto selectOne(int member_no) {
		
		MemberDto res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE+"selectOne", member_no);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}
	

	@Override
	public int update(MemberDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"update", dto);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int delete(int member_no) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"delete", member_no);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public int insert(MemberDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"insert", dto);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

	@Override
	public MemberDto idCheck(MemberDto dto) {
		MemberDto res = null;
		try {
			res = sqlSession.selectOne(NAMESPACE+"idCheck", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		System.out.println("--------------dao");
		System.out.println(res);
		return res;
	}
	@Override
	public List<MemberDto> memberList() {
		List<MemberDto> res = new ArrayList<MemberDto>();
		try {
			res = sqlSession.selectList(NAMESPACE+"memberList");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}


	@Override
	public int memberupdate(MemberDto dto) {
		int res = 0;
		try{
			res = sqlSession.update(NAMESPACE+"memberupdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public String findId(MemberDto dto) {
		// TODO Auto-generated method stub
		String res =  "";
		try {
			res = sqlSession.selectOne(NAMESPACE+"findid", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}




	@Override
	public MemberDto findpw(MemberDto dto) {
		// TODO Auto-generated method stub
		MemberDto dto2 = null;
		try {
			dto2 = sqlSession.selectOne(NAMESPACE+"findpassword", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return dto2;
	}




	@Override
	public int updatepw(MemberDto dto) {
		// TODO Auto-generated method stub
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"updatepassword", dto);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return res;
	}




	@Override
	public MemberDto checkEmail(String member_email) {
		MemberDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"emailcheck",member_email);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}




	@Override
	public List<MemberDto> searchmember(String member_id) {
		// TODO Auto-generated method stub
		List<MemberDto> res = new ArrayList<MemberDto>();
		try {
			res = sqlSession.selectList(NAMESPACE+"adminsearch",member_id);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}




	@Override
	public List<MemberDto> manchartmember() {
		// TODO Auto-generated method stub
		List<MemberDto> list = new ArrayList<MemberDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"menchartmember");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Override
	public List<MemberDto> womanchartmember() {
		// TODO Auto-generated method stub
		List<MemberDto> list = new ArrayList<MemberDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"womenchartmember");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return list;
	}




	@Override
	public int deleteByMemberNo(int member_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteByMemberNo", member_no);
		}catch (Exception e) {
			e.printStackTrace();
		}

		return res;
	}

}
