<%@ page import="java.io.PrintWriter"%>
<%@page contentType="text/html; charset=EUC-KR" %>
<!doctype html>

<html>

  <head>

    <title>������ �� ����Ʈ</title>

    <meta charset="utf-8">
	<!-- �������� -->
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- ��Ʈ��Ʈ�� CSS �߰��ϱ� -->

    <link rel="stylesheet" href="evaluation/css/bootstrap.min.css">

    <!-- Ŀ���� CSS �߰��ϱ� -->

    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>
<%

	String userID = null;

	if(session.getAttribute("userID") != null) {

		userID = (String) session.getAttribute("userID");

	}

	if(userID != null) {

		PrintWriter script = response.getWriter();

		script.println("<script>");

		script.println("alert('�α����� �� �����Դϴ�.');");

		script.println("location.href = 'index.jsp'");

		script.println("</script>");

		script.close();	

	}

%>	
    <nav class="navbar navbar-expand-lg navbar-light bg-light">

      <a class="navbar-brand" href="index.jsp">������ �� ����Ʈ</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

        <ul class="navbar-nav mr-auto">

          <li class="nav-item active">

            <a class="nav-link" href="index.jsp">����</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              ȸ�� ����

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">
<%

	if(userID == null) {

%>
              <a class="dropdown-item" href="userLogin.jsp">�α���</a>

              <a class="dropdown-item" href="userRegister.jsp">ȸ������</a>
<%

	} else {

%>
              <a class="dropdown-item" href="userLogout.jsp">�α׾ƿ�</a>
<%

	}

%>
            </div>

          </li>

        </ul>

        <form action="index.jsp" method="get" class="form-inline my-2 my-lg-0">

          <input type="text" name="search" class="form-control mr-sm-2" placeholder="������ �Է��ϼ���.">

          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">�˻�</button>

        </form>

      </div>

    </nav>

    <div class="container mt-3" style="max-width: 560px;">

      <form method="post" action="./userRegisterAction.jsp">

        <div class="form-group">

          <label>���̵�</label>

          <input type="text" name="userID" class="form-control">

        </div>

        <div class="form-group">

          <label>��й�ȣ</label>

          <input type="password" name="userPassword" class="form-control">

        </div>

        <div class="form-group">

          <label>�̸���</label>

          <input type="email" name="userEmail" class="form-control">

        </div>

        <button type="submit" class="btn btn-primary">ȸ������</button>

      </form>

    </div>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">

      Copyright �� 2018 ������ All Rights Reserved.

    </footer>

    <!-- �������� �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="evaluation/js/jquery.min.js"></script>

    <!-- Popper �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="evaluation/js/popper.min.js"></script>

    <!-- ��Ʈ��Ʈ�� �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="evaluation/js/bootstrap.min.js"></script>

  </body>

</html>
