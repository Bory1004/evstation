package com.board.ds.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.*;


import lombok.Getter;
import lombok.Setter;

@Table(name="QNABOARD")
@Entity
@Getter
@Setter
@SequenceGenerator(
        name="QNA_SEQ_GEN", //시퀀스 제너레이터 이름
        sequenceName="QNABOARD_SEQ", //시퀀스 이름
        initialValue=1, //시작값
        allocationSize=1 //메모리를 통해 할당할 범위 사이즈
        )
public class DsEntity implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,  generator="QNA_SEQ_GEN")
	@Column(name="board_num")
	private Long boardnum;   
	@Column(name="BOARD_MEM_NUM")
	private Long boardmemnum;
	@Column(name="BOARD_TITLE", length=20)
	private String boardtitle;
	@Column(name="BOARD_WRITER", length=20)
	private String boardwriter;
	@Column(name="BOARD_DATE", insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date boarddate;  
	@Column(name="BOARD_SEE",insertable = false, updatable = false, columnDefinition ="number default 0")
	private Long boardsee;
	@Column(name="BOARD_RECOM", columnDefinition ="number default 0")
	private Long boardrecom;
	@Column(name="BOARD_CONTENT", length=4000)
	private String boardcontent;
	@Column(name="BOARD_TYPE")
	private Long boardtype;
	@Column(name="BOARD_YN", length=20) // 답변 여부 
	private String boardyn;
	@Column(name="BOARD_REF", columnDefinition ="number default 0")
    private Long boardref;
	@Column(name="BOARD_RESTEP")
    private Long boardrestep;
	@Column(name="BOARD_RELEVEL",columnDefinition ="number default 0")
    private Long boardrelevel;

	
}
