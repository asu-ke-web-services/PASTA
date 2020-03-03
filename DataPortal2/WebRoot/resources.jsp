<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
	final String pageTitle = "LTER Resources";
	final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<%@ include file="context-reader.jsp" %>

<!DOCTYPE html>
<html lang="en">
	<head>
		<!-- common <head> tag elements -->
		<%@ include file="common-head.jsp" %>
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
				<div class="column">
					<!-- Content -->
					<h1>Resources</h1>
					<p>The <%= siteName %> Data Portal is based on technology created and used by the Environmental Data Initiative and the LTER Network. If you're interested in finding out more about EDI, or the LTER network, you can use the resources listed below.</p>
					<h3>EDI Resources</h3>
					<ul>
						<li><a class="searchsubcat" href="http://environmentaldatainitiative.org/">Environmental Data Initiative</a></li>
						<li><a class="searchsubcat" href="https://dashboard.edirepository.org/dashboard/">EDI Dashboard</a></li>
					</ul>

					<h3>LTER Resources</h3>
					<ul>
						<li><a class="searchsubcat" href="http://www.lternet.edu">LTER Network</a></li>
						<li><a class="searchsubcat" href="http://vocab.lternet.edu/vocab/vocab/index.php">LTER Network Controlled Vocabulary</a></li>
						<li><a class="searchsubcat" href="http://unit.lternet.edu/unitregistry/">LTER Network Unit Registry</a></li>
						<!-- <li><a class="searchsubcat" href="https://lter.dev.gios.asu.edu/lter/html/index.php">LTER Network Information System Reporting Tool</a></li>-->
					</ul>
					<!-- /Content -->
				</div>
			</div>
		</div>

		<div class="footer">
            <jsp:include page="<%= bigFooterInclude %>" />
            <jsp:include page="asu-footer.jsp" />
        </div>

		</div>
		<%@ include file="bootstrap-javascript.jsp" %>
	</body>
</html>
