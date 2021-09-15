package com.board.km.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

import com.board.hj.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="BOARDCOMMENT")
@Setter
@Getter
@ToString
@SequenceGenerator(name="RE_COM_SEQ_GEN",sequenceName="COM_SEQ",initialValue=1,allocationSize=1)
public class BoardComment {

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="RE_COM_SEQ_GEN")
	@Column(name="com_num")
	private Long comnum;
	@Column(name="com_mem_num")
	private Long commemnum;
	@Column(name="com_groupnum")
	private Long comgroupnum;
	@Column(name="com_re_step")
	private Long comrestep;
	@Column(name="com_content")
	private String comcontent;
	@Column(name="com_date",insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date comdate;
	@Column(name="com_recom",insertable = false, columnDefinition = "number default 0")
	private Long comrecom;
	@Column(name="board_num")
	private Long boardnum;
	
	@ManyToOne
	@JoinColumn(name="board_num",insertable = false, updatable = false)
	private ReviewBoard reviewboard;
	@ManyToOne
	@JoinColumn(name="com_mem_num",insertable = false, updatable=false)
	private Member member;
	
	
	
}
