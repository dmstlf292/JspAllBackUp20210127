<%@ page import="evaluation.UserDAO"%>
<%@ page import="evaluation.EvaluationDAO"%>
<%@ page import="evaluation.LikeyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page  contentType="text/html; charset=EUC-KR"%>
<!-- 선언문사용, 함수이용 -->
<%!
	public static String getClientIP(HttpServletRequest request){
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip==null||ip.length()==0){
			ip=request.getHeader("Proxy-Client-IP");		
		}if(ip==null||ip.length()==0){
			ip=request.getHeader("WL-Proxy-Client-IP");		
		}if(ip==null||ip.length()==0){
			ip=request.getRemoteAddr();
		}
		return ip;
		
}

%>


<%
			request.setCharacterEncoding("EUC-KR");
			String userID = null;
			
			if(session.getAttribute("userID") != null) {
			
				userID = (String) session.getAttribute("userID");
			
			}
			
			if(userID == null) {
			
				PrintWriter script = response.getWriter();
			
				script.println("<script>");
			
				script.println("alert('로그인을 해주세요.');");
			
				script.println("location.href = 'userLogin.jsp'");
			
				script.println("</script>");
			
				script.close();
			
				return;
			
			}
			
		
			
			String evaluationID = null;
			

			
			if(request.getParameter("evaluationID") != null) {
			
				evaluationID = (String) request.getParameter("evaluationID");
			
			}
			
			EvaluationDAO evaluationDAO = new EvaluationDAO();
			LikeyDAO likeDAO = new LikeyDAO();//초기화
			int result = likeDAO.like(userID, evaluationID, getClientIP(request));
		
			if(result ==1){
					//실제 평가글이 추천개수만큼 늘려지는기능
					if(result==1){
						PrintWriter script = response.getWriter();
						
						script.println("<script>");
					
						script.println("alert('추천완료');");
					
						script.println("location.href='index.jsp'");
					
						script.println("</script>");
					
						script.close();
						return;
					
					}else {
						PrintWriter script = response.getWriter();
						
						script.println("<script>");
					
						script.println("alert('디비오류');");
					
						script.println("history.back();");
					
						script.println("</script>");
					
						script.close();
					
						return;
					}
				
				}else{
					PrintWriter script = response.getWriter();
					
					script.println("<script>");
				
					script.println("alert('이미 추천 누른 글입니다.');");
				
					script.println("history.back();");
				
					script.println("</script>");
				
					script.close();
				
					return;
				}
			
			

%>