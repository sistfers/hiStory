<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title> 포스트쓰기 </title>

	<!-- Bootstrap CSS -->
	<link href="/resources/css/bootstrap.css" rel="stylesheet" type="text/css"/>
	
	<!-- ckeditor -->
	<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
	
</head>
<body>
<!--헤더 START-->
<jsp:include page="../main/header.jsp"/>
<!--헤더 END-->
<br><br><br><br>

<!-- 중간 START -->
<div class="container" >
	<form class="form-horizontal postForm" action="write.hi" method="post">
	
<!-- 카테고리 -->
		<div class="form-group col-xs-3" style="margin-left: 7px">
			<select class="form-control" id="category">
			       <option>여행</option>
			       <option>요리</option>
			       <option>축구</option>
		    </select>
	    </div>
	    
<!--제목  -->	    
		<div class="col-xs-9">
			<input type="text" name="TITLE" id="TITLE" class="form-control" placeholder="제목을 입력해 주세요">
		</div>
		
<!--내용  -->		
		<div class="col-xs-12">
		<textarea name="CONTENT" rows="500"></textarea>
		<script type="text/javascript">
			CKEDITOR.replace( 'CONTENT',{
				filebrowserUploadUrl: 'ckeditorImageUpload.hi'
			}); 
		</script>
		</div>
		
		<div class="form-group col-xs-4" style="margin-left: 7px; padding-top: 10px;">
			<label for="field"> 주제 선택 </label>
			<select class="form-control" id="FIELD" name="FIELD">
			       <option>선택안함</option>
			       <option>일상</option>
			       <option>기타</option>
			       <option>IT</option>
			       <option>게임</option>
			       <option>영화</option>
		    </select>
	    </div>
	    <div class="form-group col-xs-4" style="margin-left: 7px; padding-top: 10px;">
	    	<label for="field"> 댓글허용</label>
			<select class="form-control" id="CO_STATE" name="CO_STATE">
			       <option>허용</option>
			       <option>비허용</option>
		    </select>
	    </div>
	    <div class="form-group col-xs-4" style="margin-left: 7px; padding-top: 10px;">
	    	<label for="field"> 공개범위</label>
			<select class="form-control" id="STATE" name="STATE">
			       <option>전체공개</option>
			       <option>비공개</option>
			       <option>이웃공개</option>
		    </select>
	    </div>
	
	
	<div class="col-xs-8" style="margin-left: 7px;">
		<input type="text" name="tag_w" id="tag_w" class="form-control" size="30" placeholder="태그입력"/></div>
	<div class="col-xs-3"><span style="color: #4374D9; font-size: 14px;"> *태그를 입력하고 스페이스바를 눌러주세요.</span></div>
	<div class="col-xs-1"></div>
	
	<!-- 태그 뿌려지는 부분 -->
	<div id="after_tag" class="col-xs-12"></div>
	<input type="hidden" name="tag" id="tag"/>	<!--연결된 태그값 넘기기  -->
</form>


<script>
/* 태그 달기 js입니다 */       
	$(document).ready(function(){
	 
	    $("#tag_w").on('keyup',function(e){
	
	        var children = $("#after_tag").children('span').length;
	        var special =  /[`~!@#$%^&*|\\\'\";:\/?]/gi;

	        var check = $(this).val();
	        
	        if(special.test(check) == true){
	        
	            alert('특수문자는 사용할 수 없습니다.');
	            $("#tag_w").val("");
	            return false;
	        }
	        
	        if(e.which == 32 || e.which == 188){
	            
	            var tag = $("#tag_w").val();
	            tag = tag.trim();
	            
	            if(tag != "" && tag != ',' ){
	        
	                if(tag.match(',')){
	                    tag = tag.substring(0 , tag.length-1);
	                }

	            var resister_tag = "<span class='before_tag' id='tag_"+children+"' style='margin-left:7px;'>#<b>"+tag+"</b>"+
	        					    "<a href='javascript:deltag("+children+")' style='margin-left:7px; color:red;'>"+
	        					    "<b>x</b></a></span>";
	            
	            $("#after_tag").append(resister_tag);
	            
	            //초기화
	            $("#tag_w").val("");
	        
	            }else{
	            
	                if(tag == ""){
	                    alert("첫단어 공백은 불가합니다.");
	                    $("#tag_w").val("");
	                    return false;
	                }else{
	                    alert("첫단어 쉼표는 불가합니다.");
	                    $("#tag_w").val("");
	                    return false;}
	            }
	        }
	    });
	});
	 
	function deltag(n){
	    var id = "#tag_" + n;
	    $(id).remove();
	}
	 
	function tag_post(){
	 
	    var ts = "";
	    var t = $("#after_tag").children('span');
	    t.each(function(){
	            var v = $(this).html();
	            var rt = v.split('<a');
	            ts += rt[0] +"#";
	    });
	    $("#tag").val(ts);			/* 태그들 다 연결되어 붙은 값 */
	    
	    console.log("해시태그 ="+$("#tag").val(ts));
	}
	 
	 
	</script>
<div class="clearfix"></div><br><br>	 <!--줄띄기  -->
<!-- 버튼 -->
		<button class="btn btn-danger col-xs-2 col-xs-offset-4" id="save">
			<span class="glyphicon glyphicon-pencil"></span>
			&nbsp;&nbsp; <b>확&nbsp;&nbsp;인</b>&nbsp;
		</button>
		<button class="btn btn-default col-xs-2 col-xs-offset-1" id="cancle"> &nbsp;&nbsp; 취&nbsp;&nbsp;소&nbsp;</button>

</div>


<script type="text/javascript">
/* 글쓰기 눌렀을때 액션 */
$("#save").click(function(){
	
	var frm = document.searchForm;

	tag_post();
	
   if(!$("#TITLE").val()){
       alert('제목을 입력해주세요.');
       $("#TITLE").focus();
       return false;
   }
   frm.submit();
});

/* 취소버튼 */
$("#cancle").click(function(){
	location.href = history.go(-1);
});

</script>
	<!--중간 END -->

<!--푸터 START -->
<jsp:include page="../main/footer.jsp"/>
<!--푸터 START -->

</body>
</html>