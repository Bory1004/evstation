package com.board.qna.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="QNARECOM")
@Setter
@Getter
@SequenceGenerator(name="qnarecom_seq_ge",sequenceName="qnarecom_seq",initialValue=1,allocationSize=1)
public class QnARecom {


	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="qnarecom_seq_ge")
	private Long temp;
	private String id;
	private Long num;
}

