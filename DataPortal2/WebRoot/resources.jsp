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

<div class="row-fluid ">
	<div>
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="span12">
							<div class="recent_title">
								<h2>Additional Resources</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>
						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->
								<h3 align="left">EDI Resources</h3>
								<ul>
									<li><a class="searchsubcat" href="http://environmentaldatainitiative.org/">Environmental Data Initiative</a></li>
                                    <li><a class="searchsubcat" href="https://dashboard.edirepository.org/dashboard/">EDI Dashboard</a></li>
								</ul>
								<h3 align="left">LTER Resources</h3>
								<ul>
                                    <li><a class="searchsubcat" href="http://www.lternet.edu">LTER Network</a></li>
									<li><a class="searchsubcat" href="http://vocab.lternet.edu/vocab/vocab/index.php">LTER Network Controlled Vocabulary</a></li>
									<li><a class="searchsubcat" href="http://unit.lternet.edu/unitregistry/">LTER Network Unit Registry</a></li>
									<!-- <li><a class="searchsubcat" href="https://lter.dev.gios.asu.edu/lter/html/index.php">LTER Network Information System Reporting Tool</a> -->
								  </li>
								</ul>
								<!-- /Content -->
							</div>
						</div>
					</div>
				</div>
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
