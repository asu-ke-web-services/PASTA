<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%@ include file="context-reader.jsp" %>

<%
  final String pageTitle = "About";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<!DOCTYPE html>
<html lang="en">
<head>
<!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include></head>
<body>

<jsp:include page="asu-header.jsp">
    <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
    <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
    <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
    <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
</jsp:include>
<jsp:include page="<%= menuInclude %>" flush="true" />

<div class="container main-content">
	<div class="row mb-5">
		<div class="col">
			<h1><%= siteName %> Data Portal</h1>
			<p>The <%= siteName %> Data Portal is the main user interface for upload and discovery of GIOS data products. It is a modified version of <a href="https://portal.edirepository.org/nis/home.jsp" target="_blank">the EDI Data Portal</a>. The <%= siteName %> Data Portal is powered by the same <a href="#" data-toggle="tooltip" class="bs-tooltip-top" title="Provenance Aware Synthesis Tracking Architecture">PASTA</a> technology as the EDI Portal, and searches the same EDI database, but is restricted to datasets that originate from <%= siteName %>.</p>
		</div>
	</div>
</div>

<div class="footer mt-5">
	<jsp:include page="<%= bigFooterInclude %>" />
	<jsp:include page="asu-footer.jsp" />
</div>

<%@ include file="bootstrap-javascript.jsp" %>
<script>
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})
</script>
</body>

</html>
