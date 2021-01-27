<!-- fileSelect.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>

<!-- 문법적으로 post이어야지 파일이 전송된다!! 이부분은 공식이라서 외우기! -->
<form method="post" enctype="multipart/form-data"
action="viewPage.jsp">
	<!-- 3개를 던지면 받아야한다!!!getParameter 로는 못받음 -->
	user : <input name="user" value="홍길동"><br>
	title : <input name="title" value="파일업로드"><br>
	file : <input type="file" name="upload"><br>
	<input type="submit" value="파일전송">
</form>
