<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
<style>
        .uploadResult {
            width: 100%;
            background-color: gray;
        }

        .uploadResult ul {
            display: flex;
            flex-flow: row;
            justify-content: center;
            align-items: center;
        }

        .uploadResult ul li {
            list-style: none;
            padding: 10px;
        }

        .uploadResult ul li img {
            width: 20px;
        }
</style>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Upload with Ajax</title>
</head>
<body>
	<h1>Upload with Ajax</h1>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple/>
	</div>
	
	<div class="uploadResult">
		<ul>
		
		</ul>
	</div>
	
	<button id="uploadBtn">upload</button>
	
	

	
</body>
<script>

		

		$(document).ready(function(){
			
			
			
			
			let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
            let maxSize = 5242880; //5MB

            let uploadResult =$(".uploadResult ul")
            //json데이터 받아서 해당 파일의 이름 추가
            function showUploadedFile(uploadResultArr){

                var str = "";
                $(uploadResultArr).each(
                        function (i, obj){
                        
                        	console.log("=================");
                        	console.log(obj.fileName);
                            if(!obj.image){
                            	
                                str += "<li><img src='/resources/img/icon.png'>"
                                    + obj.fileName +"</li>";
                                    
                            }else{
                            	
                            	console.log("testtest..............")
                                //str += "<li>" + obj.fileName + "</li>";
                                let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid + "_" + obj.fileName );
                                str += "<li><img src='/display?fileName="+fileCallPath+"'></li>";
                            }
                    });
                    uploadResult.append(str);
            }
			
            
            function checkExtension(fileName, fileSize) {

                if (fileSize >= maxSize) {
                    alert("파일 사이즈 초과");
                    return false;
                }

                if (regex.test(fileName)) {
                    alert("해당 종류의 파일은 업로드할 수 없습니다.");
                    return false;
                }
                return true;
            }
			
            let cloneObj = $(".uploadDiv").clone();
            
            $("#uploadBtn").on("click", function (e){

                let formData = new FormData();
                let inputFile = $("input[name='uploadFile']");
                let files = inputFile[0].files;

                console.log(files);

                   /* add filedate to formata */
                   for(let i = 0; i< files.length; i++){
                       if(!checkExtension(files[i].name, files[i].size)){
                           return false;
                       }

                       formData.append("uploadFile", files[i]);
                   }

                   $.ajax({
                       url: '/uploadAjaxAction',
                       processData: false,
                       contentType: false,
                       data: formData,
                       type: 'POST',
                       dataType:'json',
                       success: function (result){
                          
                           console.log(result);
                           
                           showUploadedFile(result);

                           $(".uploadDiv").html(cloneObj.html());

                       }
                   }); //$.ajax
                   
                   
               });
            
            
		});
	</script>
	
</html>