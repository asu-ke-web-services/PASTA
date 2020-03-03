<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page isErrorPage="true"%>

<%@ include file="context-reader.jsp" %>

<%
  final String pageTitle = "Error Handler";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>
</head>
<body>

<jsp:include page="asu-header.jsp">
    <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
    <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
    <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
    <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
</jsp:include>
<jsp:include page="<%= menuInclude %>" flush="true" />

<div class="container main-content">
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
<div class="footer pt-5">
	<div class="footer pt-5">
    <jsp:include page="<%= bigFooterInclude %>" />
	<jsp:include page="asu-footer.jsp" />
</div>

</div>
<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
