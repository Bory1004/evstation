package com.board.KW.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="BOOKMARK")
@Setter
@Getter
@ToString
@SequenceGenerator(name="bookmark_seq_ge", sequenceName="bookmark_seq", initialValue=1,allocationSize=1)
public class Book implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="bookmark_seq_ge")
	private Long temp;
	private String id;    
	private Long num;
	@Column(nullable=true)
	private long bk;
   
}