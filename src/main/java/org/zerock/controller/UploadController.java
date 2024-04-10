package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.zerock.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {

  String uploadFolder = "C:\\upload";
  
  private String getFolder() {

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    Date date = new Date();

    String str = sdf.format(date);

    return str.replace("-", File.separator);
}
  
  @GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
  @ResponseBody
  public ResponseEntity<Resource> downloadFile(String fileName){
    log.info("download file: " + fileName);
    
    Resource resource = new FileSystemResource("C:\\Downloads\\" + fileName);
    
    log.info("resource: " + resource);
    
    String resourceName = resource.getFilename();
    
    HttpHeaders headers = new HttpHeaders();
    try {
      headers.add("Content-Disposition", "attachment; filename=" + new String (resourceName.getBytes("UTF-8"), "ISO-8859-1"));
    } catch (Exception e) {
      e.printStackTrace();
    }
    
    return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
  }
  
  @GetMapping("/uploadForm")
  public void uploadForm() {
    log.info("upload form");
  }
  
  //파일을 확인하기 위한 컨트롤러
  @PostMapping("/uploadFormAction")
  public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
   
    for(MultipartFile multipartFile : uploadFile) {
      
      log.info("---------------------------------------------");
      log.info("Upload File Name: " + multipartFile.getOriginalFilename());
      log.info("Upload File Name: " + multipartFile.getSize());
      
      File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
      
      try {
        multipartFile.transferTo(saveFile);
      } catch (Exception e) {
        log.error(e.getMessage());
      }
    }
  }
  
  @GetMapping("/uploadAjax")
  public void uploadAjax() {
    log.info("upload ajax");
  }
  
  //파일 이름 받아서 이미지 데이터 전송 코드
  @GetMapping("/display")
  @ResponseBody
  public ResponseEntity<byte[]> getFile(String fileName) {

      log.info("fileName: " + fileName);

      File file = new File("C:\\upload\\" + fileName);

      log.info("file: " + file);

      ResponseEntity<byte[]> result = null;

      try {
          HttpHeaders header = new HttpHeaders();

          header.add("Content-Type", Files.probeContentType(file.toPath()));
          result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
      } catch (IOException e) {
          // TODO Auto-generated catch block
          e.printStackTrace();
      }
      return result;
  }


  @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
  @ResponseBody
  public ResponseEntity<List<AttachFileDTO>>uploadAjaxPost(MultipartFile[] uploadFile) {

    String uploadFolder = "C:\\upload";
    
      log.info("update ajax post.........");
      
      List<AttachFileDTO> list = new ArrayList<>();
      
      String uploadFolderPath = getFolder();
      File uploadPath = new File(uploadFolder, uploadFolderPath);

      //log.info("upload path: " + uploadPath);

      if (uploadPath.exists() == false) {
          uploadPath.mkdirs();
      }
      // make yyyy/MM/dd folder


      for (MultipartFile multipartFile : uploadFile) {

          log.info("-------------------------------------");
          log.info("Upload File Name: " + multipartFile.getOriginalFilename());
          log.info("Upload File Size: " + multipartFile.getSize());

          AttachFileDTO attachDTO = new AttachFileDTO();
          
          String uploadFileName = multipartFile.getOriginalFilename();

          // IE has file path
          uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

         // log.info("only file name: " + uploadFileName);
          attachDTO.setFileName(uploadFileName);

          UUID uuid = UUID.randomUUID();

          uploadFileName = uuid.toString() + "_" + uploadFileName;
          

          //upload 폴더에 저장
          //File saveFile = new File(uploadFolder, uploadFileName);
          //날짜 경로로 저장
          File saveFile = new File(uploadPath, uploadFileName);

          
          try {
              multipartFile.transferTo(saveFile);
              
              attachDTO.setUuid(uuid.toString());
              attachDTO.setUploadPath(uploadFolderPath);
              
              //check image type file
              if(checkImageType(saveFile)) {
                
                attachDTO.setImage(true);
                FileOutputStream thumbnail= new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
                
                Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
                
                thumbnail.close();
              }
             list.add(attachDTO);

          } catch (Exception e) {
              log.error(e.getMessage());
          } // end catch

      } // end for
      return new ResponseEntity<>(list, HttpStatus.OK);
  }
  
  private boolean checkImageType(File file) {
    try {
      String contentType = Files.probeContentType(file.toPath());
      
      return contentType.startsWith("image");
    } catch (Exception e) {
      e.printStackTrace();
    }
    return false;

  }
}