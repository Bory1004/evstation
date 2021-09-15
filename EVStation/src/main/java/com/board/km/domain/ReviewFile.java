package com.board.km.domain;

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
@Table(name="REVIEWFILE")
@Setter
@Getter
@ToString
@SequenceGenerator(name="REVFILE_SEQ_GEN", sequenceName="REVFILE_SEQ", initialValue=1,allocationSize=1)  
public class ReviewFile {

	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="REVBOARD_SEQ_GEN")
	@Column(name = "file_num")
	private Long filenum;
	@Column(name= "board_num")
	private Long boardnum;
	@Column(name= "file_path")
	private String filepath;
	
	
}
