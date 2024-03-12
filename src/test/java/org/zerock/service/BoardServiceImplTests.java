package org.zerock.service;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.zerock.domain.BoardVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardServiceImplTests {

  //4.3 이상부터는 Autowired 한 개 이상일때 할 필요없음 
  //Test에서는 해야됨
  @Autowired
  private BoardService service;
  
  @Test
  public void testExist() {
    log.info(service);
    
    //null값 아닌지 확인
    assertNotNull(service);
  }
  
  @Test
  public void testRegister() {
  
    BoardVO board =new BoardVO();
    
    board.setTitle("새로 작성하는 글 selectKey-ser");
    board.setContent("새로 작성하는 글 내용 selectKey-ser");
    board.setWriter("newbie-ser");
    
    service.register(board);
    
    log.info("생성된 게시물의 번호 : " + board.getBno());
  }
  
  @Test
  public void testGetList() {
    service.getList().forEach(board -> log.info(board));
  }
}
