<%@ page  contentType="text/html; charset=EUC-KR"%>
<!doctype html>

<html>

  <head>

    <title>������ �� ����Ʈ</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- ��Ʈ��Ʈ�� CSS �߰��ϱ� -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">

    <!-- Ŀ���� CSS �߰��ϱ� -->

    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>

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

              <a class="dropdown-item" href="userLogout.jsp">�α׾ƿ�</a>

            </div>

          </li>

        </ul>

        <form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">

          <input type="text" name="search" class="form-control mr-sm-2" placeholder="������ �Է��ϼ���.">

          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">�˻�</button>

        </form>

      </div>

    </nav>

	<div class="container">

	    <div class="alert alert-warning mt-4" role="alert">

		  �̸��� �ּ� ������ �ϼž� �̿� �����մϴ�. ���� ������ ���� ���ϼ̳���?

		</div>

		<a href="emailSendAction.jsp" class="btn btn-primary">���� ���� �ٽ� �ޱ�</a>

    </div>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">

      Copyright �� 2018 ������ All Rights Reserved.

    </footer>

    <!-- �������� �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="./js/jquery.min.js"></script>

    <!-- Popper �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="./js/popper.min.js"></script>

    <!-- ��Ʈ��Ʈ�� �ڹٽ�ũ��Ʈ �߰��ϱ� -->

    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>
