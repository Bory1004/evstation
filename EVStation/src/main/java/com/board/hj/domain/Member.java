package com.board.hj.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import com.board.ay.domain.NoticeComment;
import com.board.ds.domain.DsComment;
import com.board.ds.domain.DsEntity;
import com.board.km.domain.Alarm;
import com.board.km.domain.BoardComment;
import com.board.km.domain.ReviewBoard;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Entity
@Table(name = "member01")
@Setter
@Getter
@ToString
@SequenceGenerator(name = "MEM_SEQ_GEN", sequenceName = "MEM_SEQ", initialValue = 1, allocationSize = 1)
public class Member implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "MEM_SEQ_GEN")
	private Long memnum;

	@Column(updatable = false)
	// @NotBlank(message = "아이디를 입력해주세요.")
	// @Pattern(regexp = "^[a-zA-Z0-9]*$", message = "숫자, 영어로 구성된 아이디를 입력해주세요.")
	private String id;

	// @NotBlank(message = "비밀번호를 입력해주세요")
	// @Pattern(regexp = "^[A-Za-z0-9]{6,12}$", message = "숫자, 문자 포함의 6~12자리 이내로
	// 입력해주세요.")
	private String mempw;

	private String memphoto = "/profile/basic.png";

	// @NotBlank(message = "이름을 입력해주세요.")
	// @Pattern(regexp = "^[가-힣]*$", message = "한글만 입력해주세요.")
	private String name;

	// @NotBlank(message = "이메일을 입력해주세요.")
	// @Email(message = "이메일 형식에 맞게 넣으세요")
	private String mememail;

	private String memphone;

	// @NotBlank(message = "주소를 입력해주세요.")
	private String memaddress;

	// @NotBlank(message = "상세주소를 입력해주세요.")
	private String memaddressdetail; // 상세주소

	@DateTimeFormat(pattern = "yyyyMMdd")
	private Date membirth;

	private String memcar;

	private String memcharge; // 충전타입

	@Column(insertable = false, updatable = false, columnDefinition = "date default sysdate")
	private Date memdate; // 가입일

	/*
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<ReviewBoard> reviewboards = new
	 * ArrayList<ReviewBoard>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<Alarm> alarm = new ArrayList<Alarm>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<BoardComment> boardcomment = new
	 * ArrayList<BoardComment>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<FreeBoardComment> freeboardcomment = new
	 * ArrayList<FreeBoardComment>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<FreeBoard> freeboard = new
	 * ArrayList<FreeBoard>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<DsComment> dscomment = new
	 * ArrayList<DsComment>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<DsEntity> dsentity = new ArrayList<DsEntity>();
	 * 
	 * @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval =
	 * true) private transient List<NoticeComment> noticecomment = new
	 * ArrayList<NoticeComment>();
	 */

}
