package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/servlet/exServlet1")//여기가 URL mapping 값이다. 
public class ExServlet1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void service(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=EUC-KR");
		//인코딩을 charset=EUC-KR로 하는것(브라우저에서 실행하는데, 코드를 브라우저에 보낸다. 문자 charset을 EUC-KR(한글)로 보낸다는 설정값(한글로 인식해서 실행해달라는 요청)
		//응답 스트림(스트림? 통신하는것, 서버&브라우즈간의 통신! 서버에서 클라이언트 브라우저로 응답하는것. 아래의 것은 응답할때 사용하는 스트림이다.
		PrintWriter out = response.getWriter();
		HttpSession session= request.getSession();
		
		out.println("<html>");
		out.println("<body>");
		out.println("<h1>이클립스로 서블릿 만들기</h1>");
		out.println("세션ID : " +session.getId());
		out.println("</body>");
		out.println("</html>");
	}
}
