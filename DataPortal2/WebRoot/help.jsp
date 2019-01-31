<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
  final String pageTitle = "Help";
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
								<h2>How do I...</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>
						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->

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
