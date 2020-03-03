<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%@ include file="context-reader.jsp" %>

<%
	final String pageTitle = "Help";
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
    <!-- incude main ASU Header-->
    <jsp:include page="asu-header.jsp">
        <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
        <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
        <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
        <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
    </jsp:include>
    <jsp:include page="<%= menuInclude %>" flush="true" />
		<div class="container main-content">
			<div class="row">
				<div class="col">
					<h1>How Do I...</h1>
					<dl>
						<dt>Search for LTER data?</dt>
						<dd><a href="https://nis.lternet.edu:8443/x/IoBH" class="searchsubcat">Searching for data</a></dd>

						<dt>Find out more about the LTER Network Information System (<abbr title="Network Information System">NIS</abbr>) and its mission?</dt>
						<dd><a href="https://nis.lternet.edu:8443/x/agBP" class="searchsubcat">LTER Network Information System Community Website</a></dd>

						<dt>Use the <abbr title="Network Information System">NIS</abbr> Data Portal to create synthetic data?</dt>
						<dd><a href="https://nis.lternet.edu:8443/x/NQFZ" class="searchsubcat">How does the <abbr title="Network Information System">NIS</abbr> enable Network Synthesis?</a></dd>

						<dt>Find out who has been downloading my data?</dt>
						<dd><a href="https://nis.lternet.edu:8443/x/OwFZ" class="searchsubcat">Who is using my data?</a></dd>

						<dt>Learn about the <abbr title="Provenance Aware Synthesis Tracking Architecture">PASTA</abbr> Software Developer's Application Programming Interface (API)?</dt>
						<dd><a href="https://nis.lternet.edu:8443/x/BAAF" class="searchsubcat"><abbr title="Network Information System">NIS</abbr> Software Developer's Guide</a></dd>
					</dl>

					<p>
						Have more questions? Go to the
						<a href="https://nis.lternet.edu:8443/x/swFZ" class="searchsubcat">Frequently Asked Questions</a> page,
						enter your question as a comment in either the <cite><abbr title="Network Information System">NIS</abbr> User's Guide</cite> or the
						<cite><abbr title="Network Information System">NIS</abbr> Software Developer's Guide</cite>, or you can always email
						<a href="mailto:tech-support@lternet.edu" class="searchsubcat">tech-support@lternet.edu</a>.
					</p>
				</div>
			</div>
		</div>
		<div class="footer pt-5">
            <jsp:include page="<%= bigFooterInclude %>" />
			<jsp:include page="asu-footer.jsp" />
		</div>
		<%@ include file="bootstrap-javascript.jsp" %>
	</body>
</html>
