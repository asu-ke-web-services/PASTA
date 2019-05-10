<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
	final String pageTitle = "Contact Us";
	final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title><%= titleText %></title>
	<!-- common <head> tag elements -->
	<%@ include file="common-head.jsp" %>
</head>

<body>

<jsp:include page="asu-header.jsp" />
<jsp:include page="header.jsp" />
<div class="container main-content">
	<div class="row">
		<div class="col">
			<!-- Content -->
			<h1>Contact Us</h1>
			<p>The GIOS Data Portal is maintained by the <a href="https://sustainability.asu.edu/support-services/web-development/" target="_blank">GIOS Web and Informatics</a> team. You can contact us via email at <a href="mailto:giosweb@asu.edu">giosweb@asu.edu</a>.</p>
		</div>
	</div>
</div>

<jsp:include page="asu-footer.jsp" />
	<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
