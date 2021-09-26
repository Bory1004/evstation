package com.board.qna.domain;

import java.io.Serializable;
import javax.persistence.*;

import lombok.Getter;
import lombok.Setter;

@Entity
@Table
@Getter    
@Setter
@SequenceGenerator(
        name="EMAIL_SEQ_GEN", //시퀀스 제너레이터 이름
        sequenceName="EMAIL_SEQ", //시퀀스 이름
        initialValue=1, //시작값
        allocationSize=1 //메모리를 통해 할당할 범위 사이즈
        )
public class QnAEmail implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,  generator="EMAIL_SEQ_GEN")
	private Long Emailnum;
	private String subject;
	private String content;
	private String Emaildate;
	private String receiver;
	@Column(columnDefinition = "number default 0")
	private long Emailcnt;
}
