package com.board.KW.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.*;

import com.board.hj.domain.Member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "chargelist2")
@Setter
@Getter
public class Charge implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="st_num")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long stnum;
	
	@Column(name="st_name")
	private String stname;
	
	@Column(name="st_closedday") 
	private String stclosedday;
	
	@Column(name="st_time")
	private String sttime;
	
	@Column(name="st_closetime")
	private String stclosetime;
	
	@Column(name="st_slowcharge")
	private String stslowcharge;
	
	@Column(name="st_fastcharge")
	private String stfastcharge;
	
	@Column(name="st_fastcharge_type")
	private String stfastcharge_type;
	
	@Column(name="st_slowcharge_num")
	private String stslowcharge_num;
	
	@Column(name="st_fastcharge_num")
	private String stfastcharge_num;
	
	@Column(name="st_park")
	private String stpark;
	
	@Column(name="st_address1")
	private String staddress1;
	
	@Column(name="st_address2")
	private String staddress2;
	
	@Column(name="st_agency")
	private String stagency;
	
	@Column(name="st_longitude")
	private String stlongitude;
	
	@Column(name="st_latitude")
	private String stlatitude;
	
	@Column(updatable = false, insertable = false, columnDefinition = "number default 0")
	private Long book;
	
	
	  
	  @GeneratedValue private Long num; private String title;
	  
	  @Column(updatable = false) private String writer; private String content;
	  
	  @Column(insertable = false, updatable = false, columnDefinition =
	  "date default sysdate") private Date createDate;
	  
	  @Column(insertable = false, updatable = false, columnDefinition
	  ="number default 0") private Long cnt;
	 
	
}
