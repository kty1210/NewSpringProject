package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;

public interface BoardMapper {

  
  public List<BoardVO> getList(); // 게시글 리스트
  
  public List<BoardVO> getListWithPaging(Criteria cri);
  
  public void insert(BoardVO board);// 게시글 추가
  
  public void insertSelectKey(BoardVO board);//번호를 확인하고 데이터 추가
  
  public BoardVO read(Long bno); // 조회
  
  public int delete (Long bno); // 삭제
  
  public int update (BoardVO board); //수정
  
  public int getTotalCount(Criteria cri);
  
}
