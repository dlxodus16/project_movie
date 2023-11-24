<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/bootstrap.css">
<style>
	.text{color:black;}
	.text:hover{color:black;}
	.login {list-style: none; display:inline; float:right; margin:8px;}
	.form-control {
  display: block;
  width: 100%;
  height: 40px;
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
.container1 {
  padding-right: 600px;
  padding-left: 600px;
  margin-right: auto;
  margin-left: auto;
}
</style>
</head>
<jsp:include page="top.jsp" flush="false"/><br><br><br>
<div class="container1">
	<div class="col-lg-4"></div>
	<div class="jumbotron" style="padding:30px;">

	<form action="LoginAction.jsp">
        <input type="text" name="id" class="form-control" placeholder="아이디를 입력해주세요." required autofocus> <br>
        <input type="password" name="pw" class="form-control" placeholder="비밀번호를 입력해주세요" required> 
        <br>
        <button class="btn btn-lg btn-primary btn-block" type="submit">로그인</button>
      </form>
</div>
	<ul>
		<li class="login"><a class="text" href="Searchpw.jsp">비밀번호찾기</a></li>
		<li class="login"><a class="text" href="Searchid.jsp">아이디찾기</a></li>
		<li class="login"><a class="text" href="Signup.jsp">회원가입</a></li>
	</ul>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
</body>
</html>