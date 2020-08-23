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
ResultSet rs = null;//select일때 결과를 담는다 

String sql = "update t_board set title=?, ctnt=? where i_board=?";

String stri_board = request.getParameter("i_board");
int i_board = Integer.parseInt(stri_board);

String title = request.getParameter("title");
String ctnt = request.getParameter("ctnt");

int result =0;

try{
	con = getCon();
	ps = con.prepareStatement(sql);
	ps.setNString(1, title);
	ps.setNString(2, ctnt);
	ps.setInt(3,i_board);
	result = ps.executeUpdate();

	
}catch(Exception e){
	e.printStackTrace();
	
}finally{
	if(rs != null){try{rs.close();} catch(Exception e){}}
	if(ps != null){try{ps.close();} catch(Exception e){}}
	if(con != null){try{con.close();} catch(Exception e){}}
}
if(result ==1){
	response.sendRedirect("/jsp/boardlist.jsp");
}else{
	response.sendRedirect("/jsp/boardMod.jsp");
}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>