package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
//생성자 생성
@AllArgsConstructor
public class BoardController {

 @Autowired
 private BoardService service;

 
 @GetMapping("/list")
 //Model은 스프링 프레임워크에서 사용되는 방식
 //자바에서 List 방식으로 들어가는 값이 할당
 public void list (Criteria cri, Model model) {
   
   log.info("list :" + cri);
   //addAttribute(a,b) -> b의 값을 a에 입력
   model.addAttribute("list", service.getList(cri));
   //model.addAttribute("pageMaker", new PageDTO(cri, 123));
   
   int total = service.getTotal(cri);
   
   log.info("total: " + total);
   
   model.addAttribute("pageMaker", new PageDTO(cri, total));
   
 }
 
 @PostMapping("/register")
 public String register (BoardVO board, RedirectAttributes rttr) {
   log.info("Received BoardVO: " + board);
   log.info("register: " + board);
   
   if(board.getAttachList() != null) {
     board.getAttachList().forEach(attach -> log.info(attach));
   }
   
   service.register(board);
   
   rttr.addFlashAttribute("result", board.getBno());
   
   return "redirect:/board/list";
 }
 
 
 @GetMapping({"/get", "modify"})
 // RequestParam 쿼리 스트링 받아옴
 //?bno=5
 //ModelAttribute 역할 : cri로 값의 이름을 줄여라
 public void get (@RequestParam("bno") Long bno, @ModelAttribute("cri")
 Criteria cri, Model model) {
   log.info("/get or modify");
   model.addAttribute("board", service.get(bno));
 }
 
 @PostMapping("/modify")
 public String modify (BoardVO board, @ModelAttribute("cri") Criteria cri, 
     RedirectAttributes rttr) {
   
   log.info("modify: " + board);
   
   if(service.modify(board)) {
     rttr.addFlashAttribute("result", "success");
   };

   rttr.addAttribute("pageNum", cri.getPageNum());
   rttr.addAttribute("amount", cri.getAmount());
   rttr.addAttribute("type", cri.getType());
   rttr.addAttribute("keyword", cri.getKeyword());
   
   return "redirect:/board/list";
 }
 
 @PostMapping("/remove")
 public String remove(@RequestParam("bno") Long bno, 
     @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
 
   log.info("remove...." + bno);
   
   if(service.remove(bno)) {
     rttr.addFlashAttribute("result", "success");
   }
   
   rttr.addAttribute("pageNum", cri.getPageNum());
   rttr.addAttribute("amount", cri.getAmount());
   rttr.addAttribute("type", cri.getType());
   rttr.addAttribute("keyword", cri.getKeyword());
   
   return "redirect:/board/list";    
 }
 
 @GetMapping("register")
 public void register() {
   
 }
 
}
