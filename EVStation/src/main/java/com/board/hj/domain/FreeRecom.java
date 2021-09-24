package com.board.hj.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name="FREERECOM")
@Setter
@Getter
@SequenceGenerator(name="freerecom_seq_ge", sequenceName = "freerecom_seq",initialValue=1,allocationSize=1 )
public class FreeRecom {
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator ="freerecom_seq_ge")
	private Long temp;
	private String id;
	private Long num;
	
}
