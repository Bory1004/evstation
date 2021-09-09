package com.board.hj.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name="member01")
@Setter
@Getter
@ToString
public class Member implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	private Long memnum;
	
	@Column(updatable = false)
	//@NotBlank(message = "아이디를 입력해주세요.")
	//@Pattern(regexp = "^[a-zA-Z0-9]*$", message = "숫자, 영어로 구성된 아이디를 입력해주세요.")
	private String id;
	
	//@NotBlank(message = "비밀번호를 입력해주세요")
	//@Pattern(regexp = "^[A-Za-z0-9]{6,12}$", message = "숫자, 문자 포함의 6~12자리 이내로 입력해주세요.")
	private String mempw;
	
	private String memphoto;
	
	//@NotBlank(message = "이름을 입력해주세요.")
	//@Pattern(regexp = "^[가-힣]*$", message = "한글만 입력해주세요.")
	private String name;
	
	//@NotBlank(message = "이메일을 입력해주세요.")
	//@Email(message = "이메일 형식에 맞게 넣으세요")
	private String mememail;
	
	private String memphone;
	
	//@NotBlank(message = "주소를 입력해주세요.")
	private String memaddress;
	
	//@NotBlank(message = "상세주소를 입력해주세요.")
	private String memaddressdetail; //상세주소
	
	//@DateTimeFormat(pattern = "yyyyMMdd")
	private Date membirth;
	
	private String memcar;
	
	private String memcharge; //충전타입
	
	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date memdate; //가입일
	
}
