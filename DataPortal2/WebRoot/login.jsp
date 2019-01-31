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

<div class="row-fluid ">
	<div>
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="span12">
							<div class="recent_title">
								<h2>Login</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>
						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->

				<p class="nis-warn"><%=message%></p>

					<form id="login" name="loginform" method="post" action="./login"
						target="_top">
						<div class="display-table">
								<div class="table-row">
									<div class="table-cell">
									  <label class="labelBold text-align-right">User Name:</label>
									</div>
									<div class="table-cell">
									   <input type="text" name="uid" size="25px" required="required" autocomplete="on" autofocus />
									</div>
								</div>
								<div class="table-row">
									<div class="table-cell">
									  <label class="labelBold text-align-right">Password:</label>
									</div>
									<div class="table-cell">
									  <input type="password" name="password" size="25px" required="required" />
									</div>
							  </div>
								<div class="table-row">
									<div class="table-cell">
									</div>
									<div class="table-cell">
										<input class="btn btn-info btn-default" name="login" type="submit" value="Login" />
										<input class="btn btn-info btn-default" name="reset" type="reset" value="Clear" />
									</div>
							  </div>
						</div>
					</form>

								<!-- /Content -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<div class="footer-container pt-5">
	<jsp:include page="asu-footer.jsp" />
</div>

</div>
<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
