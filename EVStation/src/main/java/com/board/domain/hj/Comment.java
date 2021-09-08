package com.board.domain.hj;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Entity
@Table(name="COMMENT01")
@Getter
@Setter
@ToString
@SequenceGenerator(name="COM_SEQ_GEN", sequenceName="COM_SEQ", initialValue=1, allocationSize=1)
public class Comment implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="COM_SEQ_GEN")
	private Long comnum; //댓글 번호
	
	
	//@Column(updatable = false)
	//private String writer; //작성자
	
	@JoinColumn(name="MEMNUM")
	private Long commennum;
	
	private Long comgroupnum; //댓글 그룹번호
	private String comcontent; //내용
	
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date comdate; //작성일
	
	private Long comrecom; //추천수
	
	//@JoinColumn(name = "BOARDNUM", insertable = false, updatable = false)
	@JoinColumn(name = "BOARDNUM")
	private Long boardnum; //게시글 번호
	
	//@ManyToOne
	//@JoinColumn(name = "MEMNUM")
	//Member member;
	
	//@ManyToOne
	//@JoinColumn(name = "BOARDNUM", insertable = false, updatable = false)
	//Board board;
	
}