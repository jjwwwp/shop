<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	if(session.getAttribute("loginCustomer")!= null){
		response.sendRedirect("/shop/emp/goodsList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<h1>로그인</h1>
	<form method="post" action="/shop/emp/customer/customerLoginAction.jsp">
	<div>
		<div>이메일</div>
		<input type="text" name="customerMail">
		<div>비밀번호</div>
		<input type="text" name="customerPw">
	</div><br>
		<button type="submit">로그인</button><br>
		
		<a href="/shop/emp/customer/addCustomerForm.jsp">회원가입</a>
	</form>
</body>
</html>