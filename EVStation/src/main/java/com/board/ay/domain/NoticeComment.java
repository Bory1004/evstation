package com.board.ay.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.board.hj.domain.FreeBoard;
import com.board.hj.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="NOTICECOMMENT")
@Getter
@Setter
@ToString
@SequenceGenerator(name="COMMENT_SEQ_GEN", sequenceName="COMMENT_SEQ", initialValue=1, allocationSize=1)
public class NoticeComment implements Serializable{
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="COMMENT_SEQ_GEN")
	private Long comnum; //댓글 번호
	
	@Column(name="MEMNUM", insertable = false, updatable = false)
	private Long commennum;
	
	private Long comgroupnum; //댓글 그룹번호
	
	private String comcontent; //내용
	
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date comdate; //작성일
	
	private Long comrecom; //추천수

	private Long num; //게시글 번호
	
	
	@ManyToOne
	@JoinColumn(name="NUM", insertable = false, updatable = false)
	private Board3 board;
	
	@ManyToOne
	@JoinColumn(name="MEMNUM")
	private Member member;

}
