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
<div class="container">
	<div class="row">
		<div class="col">
			<!-- Content -->
			<h1>Contact Us</h1>
			<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sed felis sed libero blandit venenatis. Duis sit amet libero sit amet elit dictum posuere. Praesent tristique pretium massa a commodo. Sed nec magna ut enim gravida ultrices. In elementum laoreet cursus. Cras hendrerit dui at facilisis elementum. Sed et justo tristique, sodales orci a, pellentesque diam. Phasellus sed dolor vitae sapien varius blandit. Donec felis ligula, tempor sed leo id, faucibus sodales nisl.</p>

			<p><a href="mailto:lorem.ipsum@asu.edu">Lorem.Ipsum@asu.edu</a></p>
		</div>
	</div>
</div>

<jsp:include page="asu-footer.jsp" />
	<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
