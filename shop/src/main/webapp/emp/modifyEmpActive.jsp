<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	System.out.println(empId+"<--empId");
	System.out.println(active+"<--active");
	
	if(active.equals("ON")){
		active="OFF";
	} else{
		active="ON";
	}
	
	Class.forName("org.mariadb.jdbc.Driver");
	ResultSet rs = null;
	Connection conn = null;
	PreparedStatement stmt = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "UPDATE `shop`.`emp` SET `active`=? WHERE  `emp_id`=?";
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,active);
	stmt.setString(2,empId);
	rs = stmt.executeQuery();
	System.out.println(stmt);
	
	
	response.sendRedirect("/shop/emp/empList.jsp");
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