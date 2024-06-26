package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardSeviceImpl implements BoardService {

  
  
	// 매퍼 객체 주입
	@Autowired
	@Setter(onMethod_= @Autowired)
	private BoardMapper mapper;
	
	@Autowired
	@Setter
	private BoardAttachMapper attachMapper;

	//등록
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register ..." + board);
		
		mapper.insertSelectKey(board);
		
		if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
		  return;
		}
		
		board.getAttachList().forEach(attach -> {
		  attach.setBno(board.getBno());
		  attachMapper.insert(attach);
		});
		
		}

	//조회
	@Override
	public BoardVO get(Long bno) {
		log.info("get ..." + bno);

		return mapper.read(bno);
	}

	//수정
	@Override
	public boolean modify(BoardVO board) {
		log.info("modify...." + board);
		return mapper.update(board) == 1;
	}

	//삭제
	@Override
	public boolean remove(Long bno) {
		log.info("remove...." + bno);
		return mapper.delete(bno) == 1;
	}

	/*
	 * @Override public List<BoardVO> getList() {
	 * 
	 * log.info("getList...."); return mapper.getList(); }
	 */

	//리스트 조회
	@Override
	public List<BoardVO> getList(Criteria cri) {

		log.info("get List with criteria: " + cri);
		return mapper.getListWithPaging(cri);
	}
	
	

	@Override
	public int getTotal(Criteria cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {
		
		return attachMapper.findByBno(bno);
	}

}
