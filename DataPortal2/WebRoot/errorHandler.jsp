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

<div class="container main-content">
	<div class="content">
		<div class="row-fluid">
			<div class="col-sm">
				<div class="mt-3 mb-3">
					<h2>Error</h2>
					<hr />
					<p>Something seems to have gone wrong with the Data Portal. Try searching again from <a href="home.jsp">the home page</a>, or the <a href="advancedSearch.jsp">Advanced Search Page</a>. If you continue to encounter this message, contact us at <a href="mailto:giosweb@asu.edu">giosweb@asu.edu</a>.</p>
					<p class="nis-error">${pageContext.exception.message}</p>					
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footer pt-5">
	<div class="footer pt-5">
	<jsp:include page="asu-footer.jsp" />
</div>

</div>
<%@ include file="bootstrap-javascript.jsp" %>

</body>

</html>
