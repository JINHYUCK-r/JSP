<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글 작</title>
</head>
<body>
	<form method="post" action="/jsp/boardWriteProc.jsp">
		제목: <input type="text" name="title"><br>
		내용: <textarea name="ctnt"></textarea><br>
		작성자: <input type="text" name="i_student"><br>
		<input type="submit" value="글작성">
	</form>

</body>
</html>