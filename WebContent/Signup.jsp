<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.css">
<style>
	.login {list-style: none; display:inline; float:right; margin:8px;}
	.container1 {
  padding-right: 600px;
  padding-left: 600px;
  margin-right: auto;
  margin-left: auto;
}
.form-control2 {
  display: inline-block;
  width: 32.9%;
  height: 34px;
  padding: 6px 12px;
  font-size: 14px;
  line-height: 1.42857143;
  color: #555;
  background-color: #fff;
  background-image: none;
  border: 1px solid #ccc;
  border-radius: 4px;
  -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
          box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
  -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
       -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
          transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}
</style>
</head>
<body>
<jsp:include page="top.jsp" flush="false"/><br><br>
<div class="container1">
<div class="col-lg-4"></div>
	<div class="jumbotron" style="padding: 30px;">
	<form method="post">
		아이디<input type="text" name="id" class="form-control" placeholder="아이디" required autofocus><br>	
		<input type="submit" value="중복확인" class="btn btn-sm btn-info pull-right" onclick="javascript: form.action='Doublecheck.jsp'"><br>
		비밀번호<input type="password" name="pw" class="form-control" placeholder="비밀번호" required> <br>
		비밀번호 확인<input type="password" name="pwcheck" class="form-control" placeholder="비밀번호 확인" required> <br>
		이메일<input type="text" name="email" class="form-control" placeholder="이메일" required> <br>
		생년월일<input type="date" name="birth" class="form-control"><br><br>
		<input type="submit" value="회원가입" class="btn btn-primary form-control" onclick="javascript: form.action='SignupAction.jsp'">
	</form>
	</div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>