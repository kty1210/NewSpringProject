package org.zerock.service;

import java.util.List;

import org.zerock.domain.BoardVO;


// 약결합
public interface BoardService {

  public void register(BoardVO board);
  
  public BoardVO get(Long bno);
  
  public boolean modify (BoardVO board);
  
  public boolean remove (BoardVO board);
  
  public List<BoardVO> getList();
}