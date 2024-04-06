<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board Read</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board Read Paging</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
				
					<div class="form-group">
						<label>Bno</label> <input class="form-control" name="bno"
						value='<c:out value="${board.bno}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label> <input class="form-control" name="title"
						value='<c:out value="${board.title}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" row="3" name="content"
						readonly="readonly"><c:out value="${board.content}" /></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> <input class="form-control" name="writer"
						value='<c:out value="${board.writer}" />'readonly="readonly">
					</div>
					
					<form id = 'actionForm' action="/board/list" method='get'>
						<input type="hidden" name='pageNum' value='${cri.pageNum}'>
						<input type="hidden" name='amount' value='${cri.amount}'>
						<input type="hidden" name='bno' value='${board.bno}'>
					</form>
					
					<form id='operForm' action="/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" 
						value='<c:out value="${board.bno}"/>' />
						<input type="hidden" name="pageNum" 
						value='<c:out value="${cri.pageNum}"/>' />
						<input type="hidden" name="amount" 
						value='<c:out value="${cri.amount}"/>' />
						<input type="hidden" name="keyword" 
						value='<c:out value="{cri.keyword}"/>' />
						<input type="hidden" name="type" 
						value='<c:out value="{cri.type}"/>' />
					</form>
					
					
					<button type="button" class="btn btn-default listBtn">
					<a href='/board/list'>List</a></button>
					<button type="button" class="btn btn-default modBtn">
					<a href='/board/modify?bno=<c:out value="${board.bno}"/>'>Modify</a></button>
					
					<script>
						var actionForm = $("#actionForm");
						
						$(".listBtn").click(function(e){
							e.preventDefault();
							actionForm.submit();
						});
						$(".modBtn").click(function(e){
							e.preventDefault();
							actionForm.attr("action","/board/modify");
							actionForm.submit();
						});
					</script>
					

				</div>
				<!-- /.panel-body -->
			</div>
			<!-- /.panel -->
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
</div>
<!-- /#wrapper -->
<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
	
	console.log("=============================");
	console.log("JS TEST");
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	
	replyService.add(
	{reply:"JS TEST", replier:"tester", bno:bnoValue},
	function(result){
		alert("RESULT: " + result);
	}
	);		
	

</script>

<script type ="text/javascript">
	$(document).ready(function(){
		
		console.log(replyService);
		
		var operForm = $("#operForm");
		
		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
	})
</script>

<script>
	window.onpageshow = function(event) {
		//back 이벤트 일 경우
		if (event.persisted) {
			location.reload(true);
		}

	}
</script>
<%@include file="../includes/footer.jsp"%>