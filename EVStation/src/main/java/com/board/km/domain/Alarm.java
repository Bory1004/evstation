package com.board.km.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.board.hj.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="ALARM")
@Setter
@Getter
@ToString
@SequenceGenerator(name="ALA_SEQ_GEN",sequenceName="ALA_SEQ",initialValue=1,allocationSize=1)
public class Alarm {

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="ALA_SEQ_GEN")
	@Column(name="ala_num")
	private Long alanum;
	@Column(name="mem_num", nullable=true)
	private Long memnum;
	@Column(name="ala_type",columnDefinition="number")
	private Long alatype;
	@Column(name="ala_check",columnDefinition="number default 0")
	private Long alacheck;
	@Column(name="ala_frommemnum", columnDefinition="number", nullable=true)
	private Long frommemnum;
	@Column(name="board_num", columnDefinition="number")
	private Long boardnum;
	
	@ManyToOne
	@JoinColumn(name="ala_frommemnum",insertable=false,updatable=false)
	private Member member;
}
