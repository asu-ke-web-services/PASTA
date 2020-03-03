<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
	final String pageTitle = "Contact Us";
	final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<%@ include file="context-reader.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
	<title><%= titleText %></title>
	<!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>
</head>

<body>

<!-- incude main ASU Header-->
<jsp:include page="asu-header.jsp">
    <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
    <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
    <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
    <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
</jsp:include>
<jsp:include page="<%= menuInclude %>" flush="true" /><div class="container main-content">
	<div class="row">
		<div class="col">
			<!-- Content -->
			<h1>Contact Us</h1>
			<p>The <%= siteName %> Data Portal is maintained by the <a href="https://sustainability.asu.edu/support-services/web-development/" target="_blank">KE Web Services</a> team. You can contact us via email at <a href="mailto:giosweb@asu.edu">giosweb@asu.edu</a>.</p>
		</div>
	</div>
</div>

<div class="footer mt-5">
    <jsp:include page="<%= bigFooterInclude %>" />
    <jsp:include page="asu-footer.jsp" />
</div>

	<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
