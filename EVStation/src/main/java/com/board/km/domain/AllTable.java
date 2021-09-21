package com.board.km.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;

import com.board.hj.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Setter
@Getter             
@ToString
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public abstract class AllTable {

	@Id
	@Column(name = "board_num")
	private String boardnum;
	@Column(name = "board_mem_num")
	private Long boardmemnum;
	@Column(name = "board_title")
	private String boardtitle;
	@Column(name="board_writer")
	private String boardwriter;
	@Column(name= "board_date")
	private Date boarddate;
	@Column(name= "board_see")
	private Long boardsee;
	@Column(name="board_recom")
	private Long boardrecom;
}
