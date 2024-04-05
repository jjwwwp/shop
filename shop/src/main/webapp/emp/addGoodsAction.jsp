<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%
	request.setCharacterEncoding("utf-8");
	//인증분기: 세션변수 이름 -loginEmp
	if(session.getAttribute("loginEmp")==null){
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<!-- Session 설정값: 입력시 로그인 emp의 emp_id값이 필요해서... -->
<%
	HashMap<String,Object>loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	System.out.println((String)(loginMember.get("empId")));
%>
<!-- Model Layer -->
<%
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsAmount = request.getParameter("goodsAmount");
	String goodsContent = request.getParameter("goodsContent");
	
	Part part = request.getPart("goodsImg");
	String originalName = part.getSubmittedFileName();
	// 원본이름에서 확장자만 분리
	int dotIdx = originalName.lastIndexOf(".");
	String ext = originalName.substring(dotIdx); // .png
	System.out.println(dotIdx);
	
	UUID uuid = UUID.randomUUID(); // 중복되지 않는 랜덤문자 생성
	String filename = uuid.toString().replace("-",""); // 문자열로 변경
	filename = filename + ext;
	
	System.out.println(goodsTitle);
	System.out.println(goodsPrice);
	System.out.println(goodsAmount);
	System.out.println(goodsContent);
	
	String sql = "insert into goods(category, emp_id, goods_title, filename, goods_price, goods_amount,goods_content)VALUES(?,?,?,?,?,?,?)";
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setString(1,category);
	stmt.setString(2,(String)(loginMember.get("empId")));
	stmt.setString(3,goodsTitle);
	stmt.setString(4,filename);
	stmt.setString(5,goodsPrice);
	stmt.setString(6,goodsAmount);
	stmt.setString(7,goodsContent);
	
	System.out.println(stmt+"<--stmt");
	
	int row = stmt.executeUpdate();
	if(row==1){ //insert 성공 -> 파일업로드 진행
		//part -> 1) inputStream -> 2) outputStream -> 3) 빈파일
		// 1)
		InputStream is = part.getInputStream();
		// 3)+2)
		String filePath = request.getServletContext().getRealPath("upload");
		File f = new File(filePath, filename); // 빈파일
		OutputStream os = Files.newOutputStream(f.toPath()); //객체 생성없이 파일이름으로 호출했기 때문에 static, os+file
		is.transferTo(os);
		
		os.close();
		is.close();
	}
	/* 
	파일 삭제 API
	File df = new File(filePath,rs.getString("filename"));
	df.delete(); 
	*/
%>
<!-- Controller Layer -->
<%
	if(row == 1){
	    response.sendRedirect("/shop/emp/goodsList.jsp");
	} else {
		String errMsg = URLEncoder.encode("작성에 실패했습니다. 확인 후 다시 입력하세요.", "utf-8");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp?errMsg=" + errMsg);
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

</body>
</html>