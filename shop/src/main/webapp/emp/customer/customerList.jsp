<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<!-- Controller Layer -->
<%
	//인증분기: 세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	String gender = request.getParameter("gender");
	System.out.println(gender);	

	int currentPage=1;
	
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String sql = "select count(*) cnt from customer";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	
	int totalRow = 0;
	if(rs.next()){
		totalRow = rs.getInt("cnt");
	}
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage !=0){
		lastPage = lastPage +1;
	}
	int startRow = (currentPage-1)*rowPerPage;
	
	String sql2 = null;
	PreparedStatement stmt2 = null;
	if(gender==null){
		sql2 = "select user_mail userMail, user_name userName, user_birth userBirth, user_gender gender from customer order by user_name asc limit ?,?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setInt(1,startRow);
		stmt2.setInt(2,rowPerPage);
	}else{
		sql2 = "select user_mail userMail, user_name userName, user_birth userBirth, user_gender gender from customer where gender=? order by user_name asc limit ?,?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1,gender);
		stmt2.setInt(2,startRow);
		stmt2.setInt(3,rowPerPage);
	}
	ResultSet rs2 = null;
	System.out.println(stmt2);
	rs2 = stmt2.executeQuery();
	
	ArrayList<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
	
	while(rs2.next()){
		HashMap<String,Object> s = new HashMap<String,Object>();
		s.put("userMail",rs2.getString("userMail"));
		s.put("userName",rs2.getString("userName"));
		s.put("userBirth",rs2.getString("userBirth"));
		s.put("gender",rs2.getString("gender"));
		
		list.add(s);
	}
	System.out.println(list);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>	
<body>
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<div>
		<a href="/shop/emp/customer/addCustomerForm.jsp">신규 소비자</a>
	</div>
	
	<div>
		<a href="/shop/emp/customerList.jsp">전체</a>
	</div>
		
	<!-- goods 목록출력 -->
	<div>
		<h3>고객목록</h3>
			<div>
				<%
					for(HashMap<String,Object> s : list){
						%>
						<div>
							이름:
							<%=(String)(s.get("userName"))%>
							</div>
							<div>
							생년월일:
							<%=(String)(s.get("userBirth"))%>
							</div>
							<div>
							성별:
						<%=(String)(s.get("gender"))%>
						</div>
					</div>
				<%
			}
		%>	
	</div>	
	
	<nav aria-label="Page navigation example">
  	<ul class="pagination justify-content-center">	
  	
  			<%
				if(currentPage > 1){
			%>
				<div class="page-item">
					<a class ="page-link" href="./customerList.jsp?currentPage=1"> << </a>
				</div>
				<div class="page-item">
					<a class ="page-link" href="./customerList.jsp?currentPage=<%=currentPage-1%>">이전</a>
				</div>
			<%		
				} else{
			%>
				<div class="page-item disabled">
					<a class ="page-link" href="./customerList.jsp?currentPage=1"> << </a>
				</div>	
				<div class="page-item disabled">
					<a class ="page-link" href="./customerList.jsp?currentPage=<%=currentPage-1%>">이전</a>
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
					<a class ="page-link" href="./customerList.jsp?currentPage=<%=currentPage+1%>">다음</a>
				</div>
				<div class="page-item">
					<a class ="page-link" href="./customerList.jsp?currentPage=<%=lastPage%>">>></a>
				</div>
				
			<%		
				}
			%>
		</ul>
		</nav>			
					
</body>
</html>