package com.board.ay.domain;

import java.io.Serializable;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Entity
@Table
@Setter
@Getter
@ToString
@SequenceGenerator(name="recom_seq_ge", sequenceName="recom_seq", initialValue=1,allocationSize=1)
public class Recom implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="recom_seq_ge")
	private Long temp;
	private String id;
	private Long num;
   
}
