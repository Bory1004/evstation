package com.board.km.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="REVIEWRECOM")
@Setter
@Getter
@SequenceGenerator(name="rerecom_seq_ge",sequenceName="recom_seq",initialValue=1,allocationSize=1)
public class ReviewRecom {

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="rerecom_seq_ge")
	private Long temp;
	private String id;
	private Long num;
}
