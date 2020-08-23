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

String sql = "select i_board,title,i_student,ctnt " + "from t_board where i_board=?";

String stri_board = request.getParameter("i_board");

int i_board = Integer.parseInt(stri_board);

BoardVO vo = new BoardVO();

try{
	con = getCon();
	ps = con.prepareStatement(sql);
	ps.setInt(1, i_board); //왜1일까?
	rs = ps.executeQuery(); 
	
	if(rs.next()){
		
		String title = rs.getNString("title");
		int i_student = rs.getInt("i_student");
		String ctnt = rs.getNString("ctnt");
		 
		vo.setI_board(i_board);
		vo.setTitle(title);
		vo.setCtnt(ctnt);
		vo.setI_student(i_student);
		
	}
	
}catch(Exception e){
	e.printStackTrace();
	
}finally{
	if(rs != null){try{rs.close();} catch(Exception e){}}
	if(ps != null){try{ps.close();} catch(Exception e){}}
	if(con != null){try{con.close();} catch(Exception e){}}
}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 내</title>
</head>
<body>
	<a href ="/jsp/boardlist.jsp">리스트</a>
	<br>
	<a href= "/jsp/boardMod.jsp?i_board=<%=vo.getI_board() %>">글수정 </a>
	<br>
	<a href ="/jsp/boardDelete.jsp?i_board=<%=vo.getI_board() %>">글삭제</a>
	<br>
	<div> 글번호: <%=vo.getI_board() %> </div>
	<div> 제목: <%=vo.getTitle() %> </div>
	<div> 작성자: <%=vo.getI_student() %> </div>
	<div> 내용: <%=vo.getCtnt() %> </div>
	
</body>
</html>