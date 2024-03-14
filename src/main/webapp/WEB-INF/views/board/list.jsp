<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@include file="../includes/header.jsp"%>

<div id="page-wrapper">
	<div class="row">
		<div class="col-lg-12">
			<h1 class="page-header">Board List Page</h1>
		</div>
		<!-- /.col-lg-12 -->
	</div>
	<!-- /.row -->
	<div class="row">
		<div class="col-lg-12">
			<div class="panel panel-default">
				<div class="panel-heading">Board List Page</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<table width="100%"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example">
						<thead>
							<tr>
								<th>번호</th>
								<th>제목</th>
								<th>작성자(s)</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<c:forEach items="${list}" var="board">
							<tr>
								<td><c:out value="${board.bno}" /></td>
								<td><c:out value="${board.title}" /></td>
								<td><c:out value="${board.writer}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regDate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updateDate}" /></td>
							</tr>
						</c:forEach>


					</table>
					<!-- 모달시작 -->
					<div id="myModal" class="modal" tabindex="-1" role="dialog">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title">Modal title</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<p>처리가 완료되었습니다.</p>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary">Save
										changes</button>
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
					<!-- 모달종료 -->
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
<script>
   
	$(document).ready(function() {
		
		let result = "<c:out value='${result}'/>";
		
		checkModal(result);
		
		function checkModal(result){
			if(result === ''){
				return
			}
			
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글" + parseInt(result) + " 빈이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
	});
</script>
<%@include file="../includes/footer.jsp"%>