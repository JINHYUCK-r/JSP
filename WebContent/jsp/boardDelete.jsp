<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@page import="com.rjh.board.BoardVO" %>
<%!
	public Connection getCon() throws Exception{
	String url = "jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC";
	Class.forName("com.mysql.jdbc.Driver").newInstance();
	Connection con = DriverManager.getConnection(url, "root", "1234");
	System.out.println("접속성공");
	return con;
}
%>

<%
Connection con = null; //Connection 객체: 자바랑DB랑 연결담
PreparedStatement ps = null; //커리문 실행 담당(+문장완성기능 )


String sql = "delete from t_board where i_board=?";
	//mysql에서 번호지정하고 값넣는 방법!!

	int i_board = Integer.parseInt(request.getParameter("i_board"));

	int result = 0;

try{
	con = getCon();
	ps = con.prepareStatement(sql);
	ps.setInt(1, i_board);
	
	
	result = ps.executeUpdate();
	
	
	
}catch(Exception e){
	e.printStackTrace();
	result = -1;
	
	
}finally{
	if(ps != null){try{ps.close();} catch(Exception e){}}
	if(con != null){try{con.close();} catch(Exception e){}}
}
if(result ==1){
	response.sendRedirect("/jsp/boardlist.jsp");
}else{
	response.sendRedirect("/jsp/boardDetail.jsp");
}

//열었으면 닫아줘야한다. 마지막에 오픈한거부터 닫아줌
//각각 try catch 감싸준이유는 같이 감싸주면 rs가 먼저 catc로 바로 가버리기 때문
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글삭제  DB</title>
</head>
<body>

</body>
</html>