<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
	final String pageTitle = "LTER Resources";
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
			<div class="row">
				<div class="column">
					<!-- Content -->
					<h1>Resources</h1>
					<p>The GIOS Data Portal is based on technology created and used by the Environmental Data Initiative and the LTER Network. If you're interested in finding out more about EDI, or the LTER network, you can use the resources listed below.</p>
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

		<div class="footer-container pt-5">
			<jsp:include page="asu-footer.jsp" />
		</div>

		</div>
		<%@ include file="bootstrap-javascript.jsp" %>
	</body>
</html>
