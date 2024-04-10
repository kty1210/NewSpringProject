package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

// 페이징 처리 위한 클래스
@Getter
@ToString
public class PageDTO {

  private int startPage;
  private int endPage;
  private boolean prev, next;
  
  private int total;
  private Criteria cri;
  
  public PageDTO(Criteria cri ,int total) {
    super();
    this.total = total;
    this.cri = cri;
    
    this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
    
    this.startPage = this.endPage - 9;
    
    int realEnd = (int) Math.ceil(total / (double) cri.getAmount());
    
    if(realEnd < this.endPage) {
      this.endPage = realEnd;
    }
    
    this.prev = this.startPage > 1;
    this.next = this.endPage < realEnd;
  }
  
  
}
