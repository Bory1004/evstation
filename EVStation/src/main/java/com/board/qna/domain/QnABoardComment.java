package com.board.qna.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import com.board.member.domain.Member;
import com.board.review.domain.ReviewBoard;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Entity
@Table(name="QNACOMMENT")
@Setter
@Getter
@ToString
@SequenceGenerator(name="RE_QNA_SEQ_GEN",sequenceName="QNA_RE_SEQ",initialValue=1,allocationSize=1)
public class QnABoardComment implements Serializable {

	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="RE_QNA_SEQ_GEN")
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
	private QnABoard dsEntity;
	@ManyToOne
	@JoinColumn(name="com_mem_num",insertable = false, updatable=false)
	private Member member;
   
}
