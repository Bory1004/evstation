package com.board.ds_entity;

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
        sequenceName="BOARD_SEQ", //시퀀스 이름
        initialValue=1, //시작값
        allocationSize=1 //메모리를 통해 할당할 범위 사이즈
        )
public class DsEntity implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,  generator="QNA_SEQ_GEN")
	private Long boardnum;   
	private Long boardmemnum;
	private String boardtitle;
	private String boardwriter;
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date boarddate;  
	@Column(insertable = false, updatable = false, columnDefinition ="number default 0")
	private Long boardsee;
	private Long boardrecom;
	private String boardcontent;
	private Long boardtype;
	private String boardyn;
	@Column(columnDefinition ="number default 0")
    private Long ref;
    private Long restep;
    private Long relevel;

	
}
