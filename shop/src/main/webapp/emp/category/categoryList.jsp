<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%
	//인증분기: 세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	String sql = "select category, create_date createDate from category order by category asc";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);	
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	while(rs.next()){
		HashMap<String,Object> m = new HashMap<String,Object>();
		m.put("category",rs.getString("category"));
		m.put("createDate",rs.getString("createDate"));
		
		list.add(m);
	}
	System.out.println(list);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<!-- 카테고리 목록 출력 -->
	<div>
		<div><h3>카테고리 목록
			<a href="/shop/emp/category/addCategoryForm.jsp">추가</a></h3>
		</div>
	</div>
	
	<div>
		<table>
			<tr>
				<th>카테고리</th>
				<th>생성일</th>
			</tr>
	
			<%
				for(HashMap m: list){
			%>
			<tr>
					<td><%=(String)(m.get("category"))%></td>
					<td><%=(String)(m.get("createDate"))%></td>
					<td>
						<a href="/shop/emp/category/deleteCategoryForm.jsp?category=<%=(String)(m.get("category"))%>">삭제
						</a>
					</td>	
			</tr>		
			<%
				}
			%>		
		</table>
	</div>
</body>
</html>