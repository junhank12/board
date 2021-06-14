package com.board.domain;

import java.util.Date;

public class BoardVO {
	
/*
	create table tbl_board(
	    bno number not null,                -- 글 번호
	    title VARCHAR2(30) not null,        -- 제목
	    content VARCHAR2(2000) not null,    -- 내용
	    writer VARCHAR2(30) not null,       -- 작성자
	    regDate date DEFAULT sysdate,       -- 작성일
	    viewCnt number DEFAULT 0,           -- 조회수
    primary key(bno)
	);
 */

	private int bno;
	private String title;
	private String content;
	private String writer;
	private Date regDate;
	private int viewCnt;
	
	public int getBno() {
		return bno;
	}
	public void setBno(int bno) {
		this.bno = bno;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}	
}