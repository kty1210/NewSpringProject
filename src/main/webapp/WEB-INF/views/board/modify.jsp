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
					<form action="/board/modify" method="post">
						<div class="form-group">
							<label>Bno</label> <input class="form-control" name="bno"
								value='<c:out value="${board.bno}" />' readonly="readonly">
						</div>
						<div class="form-group">
							<label>Title</label> <input class="form-control" name="title"
								value='<c:out value="${board.title}" />'>
						</div>
						<div class="form-group">
							<label>Text area</label>
							<textarea class="form-control" row="3" name="content"><c:out value="${board.content}" /></textarea>
						</div>
						<div class="form-group">
							<label>regDate</label> <input class="form-control" name="regDate"
								value='<fmt:formatDate pattern ="yyyy/MM/dd"
								value="${board.regDate}"/>' readonly="readonly">
						</div>
						<div class="form-group">
							<label>updateDate</label> <input class="form-control" name="updateDate"
								value='<fmt:formatDate pattern ="yyyy/MM/dd"
								value="${board.updateDate}"/>' readonly="readonly">
						</div>
						
						<button type="submit" data-oper='modify' class="btn btn-default">Modify</button>
						<button type="submit" data-oper='remove' class="btn btn-danger">Remove</button>
						<button type="submit" data-oper='list' class="btn btn-info">List</button>
							
					</form>
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
	window.onpageshow = function(event) {
		//back 이벤트 일 경우
		if (event.persisted) {
			location.reload(true);
		}

	}
</script>
<%@include file="../includes/footer.jsp"%>