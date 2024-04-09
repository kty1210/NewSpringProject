<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
						<label>Bno</label> 
						<input class="form-control" name="bno" value='<c:out value="${board.bno}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Title</label> 
						<input class="form-control" name="title" value='<c:out value="${board.title}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>Text area</label>
						<textarea class="form-control" row="3" name="content" readonly="readonly">
							<c:out value="${board.content}" />
						</textarea>
					</div>
					<div class="form-group">
						<label>Writer</label> 
						<input class="form-control" name="writer" value='<c:out value="${board.writer}" />' readonly="readonly">
					</div>

					<form id='actionForm' action="/board/list" method='get'>
						<input type="hidden" name='pageNum' value='${cri.pageNum}'>
						<input type="hidden" name='amount' value='${cri.amount}'>
						<input type="hidden" name='bno' value='${board.bno}'>
					</form>

					<form id='operForm' action="/board/modify" method="get">
						<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}"/>' />
						<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum}"/>' />
						<input type="hidden" name="amount" value='<c:out value="${cri.amount}"/>' />
						<input type="hidden" name="keyword" value='<c:out value="{cri.keyword}"/>' />
						<input type="hidden" name="type" value='<c:out value="{cri.type}"/>' />
					</form>

					<button type="button" class="btn btn-default listBtn">
						<a href='/board/list'>List</a>
					</button>
					<button type="button" class="btn btn-default modBtn">
						<a href='/board/modify?bno=<c:out value="${board.bno}"/>'>Modify</a>
					</button>

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

	<!-- 댓글 목록 처리 시작 -->
	<div class='row'>
		<div class="col-lg-12">
			<!-- /.panel -->

			<!-- 새 댓글 추가 -->
			<div class="panel panel-default">
				<div class="panel-heading">
					<i class="fa fa-comments fa-fw"></i> Reply
					<button id='addReplyBtn' class='btn btn-primary btn-xs pull-right'>New Reply</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<ul class="chat">
						<!--  Start reply -->
						<li class="left clearfix" data-rno='12'>
							<div>
								<div class="header">
									<strong class="primary-font">user00</strong> 
									<small class="pull-right text-muted">2022-07-26 10:16</small>
								</div>
								<p>Good Job!</p>
							</div>
						</li>
					</ul>
					<!-- ./ end ul -->
				</div>
				<!-- /.panel .chat-panel -->
				<div class="panel-footer"></div>
			</div>
		</div>
		<!-- ./ end row -->
	</div>

</div>
<!-- /#wrapper -->


<!-- Modal -->
<div id="myModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label>Reply</label> 
					<input class="form-control" name='reply' value='New Reply!!!'>
				</div>
				<div class="form-group">
					<label>Replier</label> 
					<input class="form-control" name='replier' value='replier'>
				</div>
				<div class="form-group">
					<label>Reply Date</label> 
					<input class="form-control" name='replyDate' value='2022-07-22'>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id='modalModBtn' class="btn btn-warning">Modify</button>
				<button type="button" id='modalRemoveBtn' class="btn btn-danger">Remove</button>
				<button type="button" id='modalRegisterBtn' class="btn btn-defalut" data-dismiss="modal">Register</button>
				<button type="button" id='modalCloseBtn' class="btn btn-info" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- 댓글 모달창 끝-->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
$(document).ready(function(){

	console.log("=============================");
	console.log("JS TEST");

	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");
	var pageNum = 1;
	var replyPageFooter = $(".panel-footer");


	showList(1);

	function showList(page) {
		replyService.getList({bno : bnoValue, page : page || 1 }, function(replyCnt, list) {

			if(page == -1){
				pageNum = Math.ceil(replyCnt/5.0);
				showList(pageNum);
				return
			}

			var str = "";

			if (list == null  || list.length == 0) {
				return;
			}
			for (var i = 0, len = list.length || 0; i < len; i++) {  
				str += "<li class='left clearfix' data-rno='"+list[i].rno+"'>";
				str += " <div><div class='header'>";
				str+= "<strong class='primary-font'>[" + list[i].rno   + "] " + list[i].replier + "</strong>";
				str += "<small class='pull-right text-muted'>" + replyService.displayTime(list[i].replyDate)   + "</small></div>";
				str += "    <p>" + list[i].reply + "</p></div></li>";
			}
			replyUL.html(str);

			showReplyPage(replyCnt);
		});

	}//end of showList

	function showReplyPage(replyCnt){
		var endNum = Math.ceil(pageNum / 5.0) * 5;
		var startNum = endNum - 4;

		var prev = startNum != 1;
		var next = false;

		if(endNum * 5 >= replyCnt){
			endNum = Math.ceil(replyCnt/5.0);
		}

		if(endNum * 5 < replyCnt){
			next = true;
		}

		var str = "<ul class='pagination pull-right'>";

		if(prev){
			str+= "<li class='page-item'><a class='page-link' href='" + (startNum-1)+"'>Previous</a></li>";
		}

		for(var i = startNum ; i<=endNum; i++){
			var active = pageNum == i? "active":"";
			str+= "<li calss='page-item '"+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
		}

		if(next){
			str+= "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
		}

		str += "</ul></div>";

		replyPageFooter.html(str);

	}//end of showReplyPage
	
	//댓글 클릭시 새로운 댓글 불러오기
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();
		console.log("page click");
		
		var targetPageNum = $(this).attr("href");
		
		console.log("targetPageNum: " + targetPageNum);
		
		pageNum = targetPageNum;
		
		showList(pageNum);
	});


	//댓글 모달창 관련 선언부
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputReplier = modal.find("input[name='replier']");
	var modalInputReplyDate = modal.find("input[name='replyDate']");

	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalRegisterBtn = $("#modalRegisterBtn");

	showList(1);

	//댓글 수정
	modalModBtn.on("click", function(e){
		var reply = {rno:modal.data("rno"), reply: modalInputReply.val(), replier: modalInputReplier.val()};

		replyService.update(reply,function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});

	//댓글 삭제
	modalRemoveBtn.on("click", function(e){
		var rno = modal.data("rno");

		replyService.remove(rno, function(result){
			alert(result);
			modal.modal("hide");
			showList(1);
		});
	});

	//댓글 등록 모달
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modalInputReplyDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();

		modalRegisterBtn.show();

		$(".modal").modal("show");
	});

	//댓글 등록 처리 & 자동 갱신
	modalRegisterBtn.on("click", function(e){
		var reply = {
			reply: modalInputReply.val(),
			replier: modalInputReplier.val(),
			bno:bnoValue
		};
		replyService.add(reply, function(result){
			alert(result);

			modal.find("input").val("");
			modal.modal("hide");

			showList(-1);
		});
	});

	//이벤트 처리
	$(".chat").on("click", "li", function(e){
		var rno = $(this).data("rno");

		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputReplier.val(reply.replier);
			modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
			.attr("readonly", "readonly");
			modal.data("rno", reply.rno);

			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModBtn.show();
			modalRemoveBtn.show();

			$(".modal").modal("show");


		});
	});

});


</script>

<script type ="text/javascript">
	$(document).ready(function(){

		console.log(replyService);

		var operForm = $("#operForm");

		$("button[data-oper='modify']").on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
	})
	replyService.add(
	{reply:"JS TEST", replier:"tester", bno:bnoValue},
	function(result){
		alert("RESULT: " + result);
	});
	replyService.getList({bno:bnoValue, page:1}, function(list){
		for(var i=0, len=list.length || 0; i<len; i++){
			console.log(list[i] + " : " + i );
		}
	});
</script>

<%@include file="../includes/footer.jsp"%>
