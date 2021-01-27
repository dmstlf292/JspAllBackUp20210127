<!-- viewPage.jsp -->
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<%
		request.setCharacterEncoding("EUC-KR");
		//업로드 파일 저장 위치
		final String SAVEFOLDER = "C:/Jsp/myapp/WebContent/upload/storage/";
		//업로드 파일명 인코딩
		final String ENCODING="EUC-KR";//이거 세팅안하면 한글파일이 깨져서 저장이 된다.
		//업로드 파일 크기
		final int MAXSIZE=1024*1024*10;//10MG(메가)
		try{
			//객체 생성이 되면 파일 업로드 완료-> request 객체는 request 되는순간 null로 된다.(멀티로 다 넘어가기 때문!)
			MultipartRequest multi = 
				new MultipartRequest(request,SAVEFOLDER,MAXSIZE, ENCODING, 
						new DefaultFileRenamePolicy());
			String user = multi.getParameter("user");
			String title = multi.getParameter("title");
			//upload는 form에 type이 file의 name값
			String fileName=multi.getFilesystemName("upload");
			String fileType=multi.getContentType("upload");
			//파일의 정보를 
			File f= multi.getFile("upload");
			long len=0;
			if(f!=null)
				len=f.length();
			out.println("파일명 : "+fileName+"<br>");
			out.println("파일타입 : "+fileType+"<br>");
			out.println("파일크기 : "+len+"<br>");
			out.println("user : "+user+"<br>");
			out.println("title : "+title+"<br>");
		}catch(Exception e){
			e.printStackTrace();
		}
%>