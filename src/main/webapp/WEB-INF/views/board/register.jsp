<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

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

	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Register</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Register</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<form role="form" action="/board/register" method="post">
						<!-- 제목 -->
						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title">
						</div>
						<!-- 내용 -->
						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" name="content"></textarea>
						</div>
						<!-- 파일업로드 -->
						<div class="form-group uploadDiv">
							<input type="file" name="uploadFile" multiple>
						</div>
						<div class="uploadResult">
							<ul>
							
							</ul>
						</div>
						<!-- 작성자 -->
						<div class="form-group">
							<label>Writer</label> <input class="form-control" name="writer">
						</div>
						<button type="submit" class="btn btn-default">Submit
							Button</button>
						<button type="reset" class="btn btn-default">Reset Button</button>
					</form>

				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->

<script>

	$(document).ready(function(e){
		
		var formObj = $("form[role='form']");
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880;

		function showUpload
		
		function checkExtension(fileName, fileSize){
			if(fileSize >= maxSize){
				alert("파일 사이즈 초과");
				return false;
			} 
			if(regex.test(fileName)){
				alert("해당 종류의 파일은 업로드할 수 없습니다.");
				return false;
			} return true;
		}
		
		
		 function showUploadResult(uploadResultArr){

			 if(!uploadResultArr || uploadResultArr.length == 0){return;}
			 var uploadUL = $(".uploadResult ul");
             var str = "";
             $(uploadResultArr).each(
                     function (i, obj){
                     
                    	 if (obj.image) {
                    		  var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);

                    		  str += "<li><div>";
                    		  str += "<span>" + obj.fileName + "</span>";
                    		  str += "<button type='button' class='btn btn-danger btn-circle'><i class='fa fa-times'></i></button><br>";
                    		  str += "<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-pencil'></i></button><br>";
                    		  str += "<img src='/display?fileName=" + fileCallPath + "'>";
                    		  str += "</div>";

                    		} else {
                    		  str += "</li>";

                    		  var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                    		  var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

                    		  str += "<li><div>";
                    		  str += "<span>" + obj.fileName + "</span>";
                    		  str += "<button type='button' class='btn btn-danger btn-circle'><i class='fa fa-times'></i></button><br>";
                    		  str += "<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-pencil'></i></button><br>";
                    		  str += "<a href='" + fileLink + "'><img src='/resources/img/attach.png'></a>";
                    		  str += "</div>";

                    		  str += "</li>";
                    		}
                 });
                 uploadUL.append(str);
         }
		
		$("button[type='submit']").on("click", function(e){
			e.preventDefault();
			console.log("submit clicked");
		});
		
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			for(var i = 0; i < files.length; i++){
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
                     showUploadResult(result);
                     
                 }
             }); //$.ajax
		});
	});
	
	
	window.onpageshow = function(event) {
		//back 이벤트 일 경우
		if (event.persisted) {
			location.reload(true);
		}

	}
</script>
<%@include file="../includes/footer.jsp"%>