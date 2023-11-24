<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.container1 {
  padding-right: 600px;
  padding-left: 600px;
  margin-right: auto;
  margin-left: auto;
}
</style>
<script>
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }    
}
</script>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container1">
	<form action="MovieWriteAction.jsp" method="post" enctype="multipart/form-data">
		영화 제목<input type="text" name="title" class="form-control" placeholder="영화 제목을 입력해주세요." required autofocus><br>
		감독<input type="text" name="director" class="form-control" placeholder="감독을 입력해주세요." required><br>
		출연자<input type="text" name="actor" class="form-control" placeholder="출연자를 입력해주세요." required><br>
		장르<input type="text" name="type" class="form-control" placeholder="장르를 입력해주세요." required><br>
		개봉일<input type="date" name="open" class="form-control"><br><br>
		종영일<input type="date" name="close" class="form-control"><br><br>
              관람등급<select name="age" class="form-control">
              <option value="00">ALL</option>
              <option value="07">7</option>
              <option value="12">12</option>
              <option value="15">15</option>
              <option value="19">19</option>
              </select><br>
              관람시간<input type="number" name="time" class="form-control" maxlength="3" oninput="maxLengthCheck(this)" required><br>
		상세 설명<textarea name="content" class="form-control" placeholder="내용을 입력해주세요."maxlength="2048" style="height: 200px;"required></textarea><br>
		<input type="file" name="image"><br><br>
		<button class="btn btn-lg btn-primary btn-block" type="submit">등록</button><br><br>
	</form>
</div>
</body>
</html>