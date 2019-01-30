<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page isErrorPage="true"%>

<%
  final String pageTitle = "Error Handler";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
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
	<div class="content">
		<div class="row-fluid">
			<div class="col-sm">
				<div class="alert alert-danger mt-3 mb-3">
					<h2>Error</h2>
					<hr />
					<p><strong>An <em>error</em> has occurred</strong> in the Data Portal:</p>
					<p class="nis-error">${pageContext.exception.message}</p>
					<p>For further assistance, please contact the
					<a href="mailto:support@environmentaldatainitiative.org?Subject=EDI%20Data%20Portal%20error" target="_top">
					Environmental Data Initiative</a>. Please copy the error message shown
					above into your email message, along with any other information
					that might help us to assist you more promptly.</p>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footer-container pt-5">
	<div class="footer-container pt-5">
	<jsp:include page="asu-footer.jsp" />
</div>

</div>
<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
