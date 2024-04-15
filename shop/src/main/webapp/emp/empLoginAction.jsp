<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<%@ page import = "shop.dao.*" %>
<%
	//인증분기 :세션변수 이름 -> loginEmp
	/* String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println(loginEmp+"<--loginEmp"); */
	
	if(session.getAttribute("loginEmp")!= null){
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%	
	//controller
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	//모델 호출하는 코드
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);

	if(loginEmp == null){  // 로그인실패
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감	
	}else {	
		System.out.println("로그인성공");
		session.setAttribute("loginEmp", loginEmp);	
		response.sendRedirect("/shop/emp/empList.jsp");
	}

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

</body>
</html>