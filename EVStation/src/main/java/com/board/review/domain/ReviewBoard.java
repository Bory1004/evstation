package com.board.review.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.ColumnResult;
import javax.persistence.ConstructorResult;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.SqlResultSetMapping;
import javax.persistence.Table;

import com.board.member.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="BOARD02")
@Setter
@Getter             
@ToString
@NamedNativeQuery(
		name = "find_alltable",

		query="select boardnum,boardtitle,boardwriter,boarddate,boardsee,boardrecom,boardtype from"
				+ "("
				+ "   select board_num as boardnum ,board_title as boardtitle ,board_writer as boardwriter,"
				+ "	  board_date as boarddate ,board_see as boardsee ,board_recom as boardrecom,board_type as boardtype from board02 a where a.board_mem_num =?1"
				+ "   union all"
				+ "   select board_num as boardnum ,board_title as boardtitle ,board_writer as boardwriter,"
				+ "   board_date as boarddate ,board_see as boardsee, board_recom as boardrecom,board_type as boardtype from qnaboard b where b.board_mem_num =?1"
				+ "   union all"
				+ "   select boardnum, boardtitle, boardwriter ,"
				+ "   boarddate , boardsee  , boardrecom , boardtype from freeboard c where c.memnum =?1"
				+ ") te "
				+ "order by boarddate desc ",
		resultSetMapping = "alltable"
)
@SqlResultSetMapping(
		name="alltable",
		classes = @ConstructorResult(
			targetClass = AllTableDTO.class,
			columns = {
				@ColumnResult(name="boardnum", type = Long.class),
				@ColumnResult(name="boardtitle", type = String.class),
				@ColumnResult(name="boardwriter", type = String.class),
				@ColumnResult(name="boarddate", type = Date.class),
				@ColumnResult(name="boardsee", type = Long.class),
				@ColumnResult(name="boardrecom", type = Long.class),
				@ColumnResult(name="boardtype", type = Long.class)

			}
		)
)
@SequenceGenerator(name="REVBOARD_SEQ_GEN", sequenceName="BOARD02_SEQ", initialValue=1,allocationSize=1)  
public class ReviewBoard {
	
private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="REVBOARD_SEQ_GEN")
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
	@Column(name="board_thumbnail")
	private String boardthumbnail;
	
	@ManyToOne
	@JoinColumn(name="board_mem_num",insertable=false,updatable=false)
	private Member member;
	
}
