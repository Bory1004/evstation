package com.board.ay.domain;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Setter
@Getter
@ToString
public class Member implements Serializable {

	private static final long serialVersionUID = 1L;
	@Column(name="MEMBERID")
	@Id
	private String id; 
	private String password;
	private String name;
	
}
