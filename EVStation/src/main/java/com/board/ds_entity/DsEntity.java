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
	private Long board_mem_num;
	private String board_title;
	private String board_writer;
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date board_date;  
	@Column(name ="board_see", insertable = false, updatable = false, columnDefinition ="number default 0")
	private Long boardsee;
	private Long board_recom;
	private String board_content;
	private Long board_type;
	private String board_yn;
	

	
}
