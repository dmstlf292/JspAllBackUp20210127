<!-- fileSelect.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>

<!-- ���������� post�̾���� ������ ���۵ȴ�!! �̺κ��� �����̶� �ܿ��! -->
<form method="post" enctype="multipart/form-data"
action="viewPage.jsp">
	<!-- 3���� ������ �޾ƾ��Ѵ�!!!getParameter �δ� ������ -->
	user : <input name="user" value="ȫ�浿"><br>
	title : <input name="title" value="���Ͼ��ε�"><br>
	file : <input type="file" name="upload"><br>
	<input type="submit" value="��������">
</form>
