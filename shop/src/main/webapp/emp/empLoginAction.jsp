<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
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
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	/* select emp_id empId from emp where active='on' and emp_id=? and emp_pw password(?) */
	
	/* 실패: /emp/empLoginForm.jsp 
	   성공: /emp/empList.jsp
	*/		
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "select emp_id empId, emp_name empName, grade from emp where active='on' and emp_id=? and emp_pw=password(?)";		
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,empId);
	stmt.setString(2,empPw);
	rs = stmt.executeQuery();
	
	if(rs.next()){
		System.out.println("로그인 성공");
		//세션안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String,Object> loginEmp = new HashMap<String,Object>();
		loginEmp.put("empId",rs.getString("empId"));
		loginEmp.put("empName",rs.getString("empName"));
		loginEmp.put("grade",rs.getInt("grade"));
		
		session.setAttribute("loginEmp", loginEmp);
		
		//디버깅
		HashMap<String,Object> m = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
		System.out.println((String)(m.get("empId")));//로그인된 empId
		System.out.println((String)(m.get("empName")));//로그인된 empName
		System.out.println((Integer)(m.get("grade")));//로그인된 grade
		
		response.sendRedirect("/shop/emp/empList.jsp");
	}else{
		System.out.println("로그인 실패");
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
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