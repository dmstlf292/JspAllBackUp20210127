<!-- postGuestBookProc.jsp -->
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%request.setCharacterEncoding("EUC-KR");%>
<!-- �������� �޾ƾ��Ѵ�!! -->
<jsp:useBean id="mgr" class="guestbook.GuestBookMgr"/>
<jsp:useBean id="bean" class="guestbook.GuestBookBean"/>
<jsp:setProperty property="*" name="bean"/>
<%
	if(bean.getSecret()==null){
		bean.setSecret("0");
	}	
	mgr.insertGuestBook(bean);
	response.sendRedirect("showGuestBook.jsp");
%>