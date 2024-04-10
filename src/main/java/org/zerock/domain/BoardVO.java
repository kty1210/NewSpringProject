package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

  private Long bno; // 게시글 번호
  private String title; // 제목
  private String content; // 내용
  private String writer; // 작성자
  private Date regDate; // 작성시각
  private Date updateDate; // 수정시각
  
  //파일 업로드 관련 필드
  private int replyCnt;
  private List<BoardAttachVO> attachList;
}
