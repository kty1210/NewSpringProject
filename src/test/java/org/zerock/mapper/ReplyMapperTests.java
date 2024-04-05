package org.zerock.mapper;

import java.util.stream.IntStream;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.ReplyVO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
//웹 애플리케이션 구성
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

  private Long[] bnoArr = {2049L, 2047L, 2046L, 2045L, 2044L};
  
  @Setter 
  @Autowired
  private ReplyMapper mapper;
  
  @Test
  public void testCreate() {
    IntStream.rangeClosed(1, 10).forEach(i-> {
      ReplyVO vo = new ReplyVO();
      
      vo.setBno(bnoArr[i%5]);
      vo.setReply("댓글 테스트" + i);
      vo.setReplier("replier" + i);
      
      mapper.insert(vo);
    });
  }
  
  @Test
  public void testMapper() {
    log.info(mapper);
  }
  
  @Test
  public void testRead() {
    Long targetRno = 5L;
    
    ReplyVO vo = mapper.read(targetRno);
    
    log.info(vo);
  }
  
  @Test
  public void testDelete() {
    
    Long targetRno = 1L;
    
    mapper.delete(targetRno);
  }
  
  @Test
  public void testUpdate() {
    
    Long targetRno = 10L;
    
    ReplyVO vo = mapper.read(targetRno);
    
    vo.setReply("Update Reply");
    
    int count = mapper.update(vo);
    
    log.info("UPDATE COUNT: " + count);
  }
}
