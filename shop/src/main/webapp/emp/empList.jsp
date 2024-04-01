<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.net.*"%>
<%
	//인증분기 :세션변수 이름 -> loginEmp
	String loginEmp = (String)(session.getAttribute("loginEmp"));
	System.out.println(loginEmp+"<--loginEmp");
	
	if(session.getAttribute("loginEmp")== null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	
	
	String sql = "select emp_id empId, emp_name empName, emp_job empJob,hire_date hireDate active from emp order by asc, hire_date desc";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<h1>사원목록</h1>
</body>
</html>