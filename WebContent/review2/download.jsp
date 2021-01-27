<%@ page  contentType="text/html; charset=EUC-KR"%>
<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@page import="review2.BoardMgr"%>
<%
		request.setCharacterEncoding("EUC-KR");
		try{
			String tfilename = request.getParameter("tfilename");
			File file = new File(BoardMgr.SAVEFOLDER+
					File.separator+tfilename);
			byte b[] = new byte[(int)file.length()];
			
			response.setHeader("Accept-Ranges", "bytes");
			String strClient = request.getHeader("User-Agent");
			if (strClient.indexOf("Trident") > 0 || strClient.indexOf("MSIE") > 0) {
				response.setContentType("application/smnet;charset=UTF-8");
				response.setHeader("Content-Disposition", "tfilename="
				+ new String(tfilename.getBytes("EUC-KR"),"8859_1") + ";");
			} else {
				response.setContentType("application/smnet;charset=UTF-8");
				response.setHeader("Tcontent-Disposition",
						"attachment;tfilename=" 
				+ new String(tfilename.getBytes("UTF-8"),"ISO-8859-1") + ";");
			}
			out.clear();
			if (file.isFile()) {
				BufferedInputStream fin = new BufferedInputStream(
						new FileInputStream(file));
				BufferedOutputStream outs = new BufferedOutputStream(
						response.getOutputStream());
				int read = 0;
				while ((read = fin.read(b)) != -1) {
					outs.write(b, 0, read);
				}
				outs.close();
				fin.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
%>