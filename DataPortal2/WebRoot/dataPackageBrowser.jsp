<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
  final String pageTitle = "Data Package Browser";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName()
      + ":" + request.getServerPort() + path + "/";

  HttpSession httpSession = request.getSession();

  String browseMessage = (String) request.getAttribute("browsemessage");
  String html = (String) request.getAttribute("html");
  String cnt = (String) request.getAttribute("count");

  if (html == null) {
    html = "";
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
<div class="container main-content">
	<div class="row">
		<div class="col">
			<h2>Browse Data by Package Identifier</h2>
			<p><%=browseMessage%></p>
			<%=html%>
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
