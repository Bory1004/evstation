package com.board.free.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import com.board.member.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Entity
@Table(name="FREEBOARDCOMMENT")
@Getter
@Setter
@ToString
@SequenceGenerator(name="FREECOM_SEQ_GEN", sequenceName="FREECOM_SEQ", initialValue=1, allocationSize=1)
public class FreeBoardComment implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="FREECOM_SEQ_GEN")
	private Long comnum; //댓글 번호
	
	@Column(name="MEMNUM", insertable = false, updatable = false)
	private Long commennum;
	
	private Long comgroupnum; //댓글 그룹번호
	
	private String comcontent; //내용
	
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date comdate; //작성일
	
	private Long comrecom; //추천수

	private Long boardnum; //게시글 번호
	
	
	@ManyToOne
	@JoinColumn(name="BOARDNUM", insertable = false, updatable = false)
	private FreeBoard board;
	
	@ManyToOne
	@JoinColumn(name="MEMNUM")
	private Member member;
	
}