package com.board.ds_entity;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;


@Entity
@Getter
@Setter
@Table
public class DsAlam implements Serializable {

	
	private static final long serialVersionUID = 1L;
   @Id
	private String alaid;
	private String alaname;
	private String alaphoto;
	private String alaemail;
	@Column(columnDefinition ="number default 0")
	private long alanum;
   
}
