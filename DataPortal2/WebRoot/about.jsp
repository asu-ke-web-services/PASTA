<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
  final String pageTitle = "About";
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
	<div class="row mb-5">
		<div class="col">
			<h1>GIOS Data Portal</h1>
			<p>The GIOS Data Portal is the main user interface for upload and discovery of GIOS data products. It is a modified version of <a href="https://portal.edirepository.org/nis/home.jsp" target="_blank">the EDI Data Portal</a>. The GIOS Data Portal is powered by the same <a href="#" data-toggle="tooltip" class="bs-tooltip-top" title="Provenance Aware Synthesis Tracking Architecture">PASTA</a> technology as the EDI Portal, and searches the same EDI database, but is restricted to datasets that originate from GIOS.</p>
		</div>
	</div>
</div>

<div class="footer-container pt-5">
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
