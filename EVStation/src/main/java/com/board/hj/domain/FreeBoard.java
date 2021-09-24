package com.board.hj.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="FREEBOARD")
@Setter
@Getter
@ToString
@SequenceGenerator(name="FREEBOARD_SEQ_GEN", sequenceName="FREEBOARD_SEQ", initialValue=1, allocationSize=1)
public class FreeBoard implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="FREEBOARD_SEQ_GEN")
	private Long boardnum; //게시판 글번호
	
	@Column(name="MEMNUM", insertable = false, updatable = false)
	private Long boardmennum; //작성자 회원번호
	
	//@Column(updatable = false)
	private String boardwriter; //작성자 아이디
	
	private String boardtitle; //제목
	
	@Column(length = 4000)
	private String boardcontent; //내용
	
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date boarddate; //작성일
	
	@Column(insertable = false, updatable = false, columnDefinition ="number default 0")
	private Long boardsee; //조회수	
	
	@Column(columnDefinition ="number default 0")
	private Long boardrecom; //추천수
	
	@Column(insertable = false, updatable = false, columnDefinition ="number default 1")
	private int boardtype; //글 타입(자유게시판 1)
	
	private Long boardstnum; //리뷰게시판에 쓸 충전소 번호	
	
	@ManyToOne
	@JoinColumn(name="MEMNUM")
	private Member member;	
	
	//private String boardwriter = member.getId();
	
}