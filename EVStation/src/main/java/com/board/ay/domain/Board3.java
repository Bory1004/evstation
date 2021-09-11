package com.board.ay.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity//table과의 매핑
@Table(name="BOARD03")
@Setter
@Getter
@ToString
@SequenceGenerator(name="board03_seq_ge", sequenceName="board03_seq", initialValue=1,allocationSize=1)
//initialValue=시작값,allocationSize=메모리 통해 할당 할 범위 사이즈
public class Board3 implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="board03_seq_ge")
	private Long num;
	private String title;
	@Column(updatable = false)
	private String writer;
	private String content;
	@Column(updatable = false, insertable = false, columnDefinition = "date default sysdate")
	private Date createDate;
	@Column(updatable = false, insertable = false, columnDefinition = "number default 0")
	private Long cnt;
	@Column(updatable = false, insertable = false, columnDefinition = "number default 0")
	private Long recom;
   
}
