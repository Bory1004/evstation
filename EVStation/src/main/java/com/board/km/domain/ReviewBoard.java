package com.board.km.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="BOARD02")
@Setter
@Getter             
@ToString
@SequenceGenerator(name="BOARD_SEQ_GEN", sequenceName="BOARD_SEQ", initialValue=1,allocationSize=1)  
public class ReviewBoard {
	
private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="BOARD_SEQ_GEN")
	@Column(name = "board_num")
	private Long boardnum;
	@Column(name = "board_mem_num")
	private Long boardmemnum;
	@Column(name = "board_title")
	private String boardtitle;
	@Column(name= "board_date" ,insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date boarddate;
	@Column(name= "board_see", insertable = false, updatable = false, columnDefinition ="number default 0")
	private Long boardsee;
	@Column(name="board_recom",insertable =false, columnDefinition ="number default 0")
	private Long boardrecom;
	@Column(name="board_writer", updatable = false)
	private String boardwriter;
	@Column(name="board_content")
	private String boardcontent;
	@Column(name="board_type")
	private Long boardtype;
	@Column(name="board_st_num")
	private Long boardstnum;
	
}
