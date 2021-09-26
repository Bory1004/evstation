package com.board.review.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;

import com.board.member.domain.Member;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.Value;


@Setter
@Getter             
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AllTableDTO {

	private Long boardnum;
	private String boardtitle;
	private String boardwriter;
	private Date boarddate;
	private Long boardsee;
	private Long boardrecom;
	private Long boardtype;

	
	
}
