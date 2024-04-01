<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	//인증분기 :세션변수 이름 -> loginEmp
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println(loginEmp+"<--loginEmp");
	
	if(session.getAttribute("loginEmp")!= null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>로그인</h1>
	<form method="post" action="/shop/emp/empLoginAction.jsp">
	<div>
		<div>empId:</div>
		<input type="text" name="empId">
		<div>empPw:</div>
		<input type="text" name="empPw">
	</div><br>
		<button type="submit">로그인</button>	
	</form>
</body>
</html>