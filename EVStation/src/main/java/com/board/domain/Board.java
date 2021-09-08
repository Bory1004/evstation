package com.board.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "chargelist2")
@Setter
@Getter
@ToString
public class Board implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	private Long st_num;
	private String st_name;
	private String st_closedday;
	private String st_time;
	private String st_closetime;
	private String st_slowcharge;
	private String st_fastcharge;
	private String st_fastcharge_type;
	private String st_slowcharge_num;
	private String st_fastcharge_num;
	private String st_park;
	private String st_address1;
	private String st_address2;
	private String st_agency;
	private String st_longitude;
	private String st_latitude;

	  
	  @GeneratedValue private Long num; private String title;
	  
	  @Column(updatable = false) private String writer; private String content;
	  
	  @Column(insertable = false, updatable = false, columnDefinition =
	  "date default sysdate") private Date createDate;
	  
	  @Column(insertable = false, updatable = false, columnDefinition
	  ="number default 0") private Long cnt;
	 
	
}
