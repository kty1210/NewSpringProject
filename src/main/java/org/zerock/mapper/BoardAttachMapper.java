package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {

	//삽입
	public void insert(BoardAttachVO vo);
	
	//삭제
	public void delete(String uuid);
	
	//게시글 번호로 첨부파일 조회
	public List<BoardAttachVO> findByBno(Long bno);
}
