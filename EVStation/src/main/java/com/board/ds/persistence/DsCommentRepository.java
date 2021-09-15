package com.board.ds.persistence;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.board.ds.domain.DsComment;

public interface DsCommentRepository extends JpaRepository<DsComment, Long> {

	List<DsComment> findByBoardnumOrderByComnumAsc(Long boardnum);

}
