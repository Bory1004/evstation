package com.board.ds_entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;


import lombok.Getter;
import lombok.Setter;

@Table(name="QNABOARD")
@Entity
@Getter
@Setter
@SequenceGenerator(
        name="QNA_SEQ_GEN", //시퀀스 제너레이터 이름
        sequenceName="QNA_SEQ", //시퀀스 이름
        initialValue=1, //시작값
        allocationSize=1 //메모리를 통해 할당할 범위 사이즈
        )
public class DsEntity implements Serializable {

	
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,  generator="QNA_SEQ_GEN")
    @Column(name= "board_num")
	private Long boardnum;   
	@Column(name= "board_mem_num")	
	private Long boardmemnum;
	@Column(name= "board_title")
	private String boardtitle;
	@Column(name= "board_writer")
	private String boardwriter;
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date board_date;  
	@Column(name ="board_see", insertable = false, updatable = false, columnDefinition ="number default 0")
	private Long boardsee;
	@Column(name= "board_recom")
	private Long boardrecom;
	@Column(name= "board_content")
	private String boardcontent;
	@Column(name= "board_type")
	private Long boardtype;
	@Column(name= "board_yn")
	private String boardyn;

	private Long reNum;
	private Long reStep;
	private Long reLevel;
	
}
