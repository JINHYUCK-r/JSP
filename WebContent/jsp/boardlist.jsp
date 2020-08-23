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
List<BoardVO> boardlist = new ArrayList();
Connection con = null; //Connection 객체: 자바랑DB랑 연결담
PreparedStatement ps = null; //커리문 실행 담당(+문장완성기능 )
ResultSet rs = null;//select일때 결과를 담는다 


String sql = "select i_board,title,i_student " + "from t_board order by i_board desc";
String name="";
try{
	con = getCon();
	ps = con.prepareStatement(sql);
	rs = ps.executeQuery(); //select할때만쓰인다.
	while(rs.next()){
		int i_board = rs.getInt("i_board");
		String title = rs.getNString("title");
		int i_student = rs.getInt("i_student");
		
		BoardVO vo = new BoardVO();
		//중요함! 이걸 while문안에서 만들어야함. while문 밖에서 만들면 마지막 주소값(같은값) 만나온다 
		vo.setI_board(i_board);
		vo.setTitle(title);
		vo.setI_student(i_student);
		
		boardlist.add(vo);
	}
	
	
}catch(Exception e){
	e.printStackTrace();
}finally{
	if(rs != null){try{rs.close();} catch(Exception e){}}
	if(ps != null){try{ps.close();} catch(Exception e){}}
	if(con != null){try{con.close();} catch(Exception e){}}
}
//열었으면 닫아줘야한다. 마지막에 오픈한거부터 닫아줌
//각각 try catch 감싸준이유는 같이 감싸주면 rs가 먼저 catc로 바로 가버리기 때문
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div>게시판 리스트
	<a href="/jsp/boardWrite.jsp"><button>글쓰기</button></a>
	</div>
<table>
	<tr>
	<th>No.</th>
	<th>제목</th>
	<th>작성</th>
	</tr>
	<% for(BoardVO vo : boardlist){ %>
	<tr>
	<td><%= vo.getI_board()%></td>
	<td>
	 <a href = "/jsp/boardDetail.jsp?i_board=<%=vo.getI_board()%>">
	<!-- ?뒤에는 쿼리스트링이라고 한다. i_board는키값 뒤에는 밸류값. 디테일 jsp파일에서 키값을 이용해서밸류값을 가져온 
	-->
	<%=vo.getTitle() %> 
	</a>
	</td>
	<td><%=vo.getI_student() %></td>
	</tr>
	<%} %>

</table>
</body>
</html>