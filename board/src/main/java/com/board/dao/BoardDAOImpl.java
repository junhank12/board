package com.board.dao;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	// mybatis
	@Inject
	private SqlSession sql;
	
	// mapper
	private static String namespace = "com.board.mappers.board";

	// 게시물 작성
	@Override
	public void write(BoardVO vo) throws Exception {
		sql.insert(namespace + ".write", vo);
	}
	
	// 게시물 조회
	@Override
	public BoardVO view(int bno) throws Exception {
		return sql.selectOne(namespace + ".view", bno);
	}
	
	// 게시물 수정
	@Override
	public void modify(BoardVO vo) throws Exception {
		sql.update(namespace + ".modify", vo);		
	}
	
	// 게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		sql.delete(namespace + ".delete", bno);
	}

	// 게시물 총 갯수
	@Override
	public int listCount() throws Exception {
		return sql.selectOne(namespace + ".listCount");
	}
	
	// 게시물 목록
	@Override
	public List<BoardVO> list() throws Exception {
		return sql.selectList(namespace + ".list");
	}

	// 게시물 목록 + 페이징 처리
	@Override
	public List<BoardVO> listPage(Criteria cri) throws Exception {
		return sql.selectList(namespace + ".listPage", cri);
	}

	// 게시물 목록 + 페이징 + 검색
	@Override
	public List<BoardVO> listSearch(SearchCriteria scri) throws Exception {
		return sql.selectList(namespace + ".listSearch", scri);
	}

	// 검색 결과 갯수
	@Override
	public int countSearch(SearchCriteria scri) throws Exception {
		return sql.selectOne(namespace + ".countSearch", scri); 
	}
}