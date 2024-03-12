package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
 public void list (Model model) {
   
   log.info("list");
   //addAttribute(a,b) -> b의 값을 a에 입력
   model.addAttribute("list", service.getList());
 }
 
}
