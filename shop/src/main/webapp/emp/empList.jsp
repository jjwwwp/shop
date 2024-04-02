<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
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
	//request 분석
	//페이징
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int startRow = (currentPage-1)*rowPerPage;
	
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql2 = "select count(*) cnt from emp";
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
	int totalRow = 0;
	if(rs2.next()){
		totalRow = rs2.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage +1;
	}
	
%>
<!-- Model Layer -->
<% 	
	//모델:(특수한 형태의 데이터(RBDMS:mariadb)) -> API사용(JDBC API)하여 자료구조(ResultSet) 취득 -> 일반화된 자료구조(ArrayList<HashMap>로 변경 -> 모델 취득
	String sql = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by hire_date desc limit ?,?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);	
	stmt.setInt(1,startRow);
	stmt.setInt(2,rowPerPage);
	rs = stmt.executeQuery(); //JDBC API 종속된 자료구조 모델 ResultSet -> 기본 API자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	//ResultSet -> ArrayList<HashMap<String,Object>>
	while(rs.next()){
		HashMap<String, Object> m = new HashMap<String,Object>();
		m.put("empId",rs.getString("empId"));
		m.put("empName",rs.getString("empName"));
		m.put("empJob",rs.getString("empJob"));
		m.put("hireDate",rs.getString("hireDate"));
		m.put("active",rs.getString("active"));
		list.add(m); 
	}
	//JDBC API사용이 끝났다면 DB자원들을 반납
%>

<!-- View Layer: 모델(ArrayList<HashMap<String,Object>> ) 출력 -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	<h1>사원목록</h1>
	<table>
		<tr>
			<td>empId</td>
			<td>empName</td>
			<td>empJob</td>
			<td>hireDate</td>
			<td>active</td>
		</tr>
		<%
			for(HashMap<String,Object>m:list){
		%>
		<tr>
			<td><%=(String)(m.get("empId"))%></td> <!-- 글자는 object타입으로 해도 출력가능 하지만 -->
			<td><%=(String)(m.get("empName"))%></td>
			<td><%=(String)(m.get("empJob"))%></td>
			<td><%=(String)(m.get("hireDate"))%></td>
			<td>
				<a href='modifyEmpActive.jsp?active=<%=(String)(m.get("active"))%>&empId=<%=(String)(m.get("empId"))%>'>>
				<%=(String)(m.get("active"))%>
				</a>
			</td>
		</tr>
		<%
			}
		%>
	</table>
	<%
		if(currentPage > 1){
	%>
		<div class="page-item">
			<a class ="page-link" href="./diaryList.jsp?currentPage=1"> << </a>
		</div>
		<div class="page-item">
			<a class ="page-link" href="./diaryList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		</div>
	<%		
		} else{
	%>
		<div class="page-item disabled">
			<a class ="page-link" href="./diaryList.jsp?currentPage=1"> << </a>
		</div>	
		<div class="page-item disabled">
			<a class ="page-link" href="./diaryList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		</div>
	<%
		}
	%>
		
		<div>
			<span class="btn btn-outline-secondary">
					<%=currentPage%> 
			</span>
		</div>
		
	<%		
		
		if(currentPage < lastPage) {
	%>
		<div class="page-item">
			<a class ="page-link" href="./diaryList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		</div>
		<div class="page-item">
			<a class ="page-link" href="./diaryList.jsp?currentPage=<%=lastPage%>">>></a>
		</div>
		
	<%		
		}
	%>
	
		
</body>
</html>