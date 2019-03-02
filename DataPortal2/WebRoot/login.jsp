<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
  final String pageTitle = "Login";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  HttpSession httpSession = request.getSession();

  String message = (String) request.getAttribute("message");
  String from = (String) request.getAttribute("from");

  if (from != null && !from.isEmpty()) {
    httpSession.setAttribute("from", from);
  }

  if (message == null) {
    message = "";
  }
%>

<!DOCTYPE html>
<html lang="en">

	<head>
		<!-- common <head> tag elements -->
		<%@ include file="common-head.jsp" %>
	</head>

	<body>
		<jsp:include page="asu-header.jsp" />
		<jsp:include page="header.jsp" />
		<div class="container">
			<div class="row">
				<div class="col">
					<h2>Login</h2>
					<!-- Content -->
					<p class="nis-warn"><%=message%></p>
					<form id="login" name="loginform" method="post" action="./login" target="_top">
						User Name:
						<input type="text" name="uid" size="25px" required="required" autocomplete="on" autofocus />
						Password:
						<input type="password" name="password" size="25px" required="required" />
						<input class="btn btn-info btn-default" name="login" type="submit" value="Login" />
						<input class="btn btn-info btn-warning" name="reset" type="reset" value="Clear" />
					</form>
					<!-- /Content -->
				</div>
			</div>
		</div>

		<div class="footer-container pt-5">
			<jsp:include page="asu-footer.jsp" />
		</div>

		<%@ include file="bootstrap-javascript.jsp" %>
	</body>
</html>
