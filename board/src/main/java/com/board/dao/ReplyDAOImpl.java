package com.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.domain.ReplyVO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {
	
	// mybatis
	@Inject
	private SqlSession sql;
	
	// mapper
	private static String namespace = "com.board.mappers.reply";
	
	// 댓글 조회
	@Override
	public List<ReplyVO> readReply(int bno) throws Exception {
		return sql.selectList(namespace + ".readReply", bno);
	}

	// 댓글 작성
	@Override
	public void writeReply(ReplyVO vo) throws Exception {
		sql.insert(namespace + ".writeReply", vo);
	}

	// 특정 댓글 조회
	@Override
	public ReplyVO readReplySelect(int rno) throws Exception {
		return sql.selectOne(namespace + ".updateReply", rno);
	}

	// 댓글 수정
	@Override
	public void replyUpdate(ReplyVO vo) throws Exception {
		sql.update(namespace + ".updateReply", vo);
		
	}

	// 댓글 삭제
	@Override
	public void replyDelete(ReplyVO vo) throws Exception {
		sql.delete(namespace + ".deleteReply", vo);
	}
}
