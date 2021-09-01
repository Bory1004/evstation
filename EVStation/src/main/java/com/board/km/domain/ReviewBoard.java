package com.board.km.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="BOARD01")
@Setter
@Getter
@ToString
public class ReviewBoard {
	
private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
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
	@Column(name="board_recom", columnDefinition ="number default 0")
	private Long boardrecom;
	@Column(name="board_writer", updatable = false)
	private String boardwriter;
	@Column(name="board_content")
	private String boardcontent;
	@Column(name="board_type")
	private Long boardtype;
	
	
}
