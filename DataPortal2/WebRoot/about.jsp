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

<div class="container">
	<div class="row">
		<div class="col">
			<h1>GIOS Data Portal</h1>
			<p>The GIOS Data Portal is the main user interface for upload and discovery of GIOS data products. The GIOS Data Portal is powered by <a href="#" data-toggle="tooltip" data-placement="bottom" title="Provenance Aware Synthesis Tracking Architecture">PASTA</a> technology.</p>


			<div class="accordion" id="accordionExample">
  <div class="card">
    <div class="card-header" id="headingOne">
      <h2 class="mb-0">
        <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			For Scientists, Researchers, Students, and the General Public
        </button>
      </h2>
    </div>

    <div id="collapseOne" class="collapse show" aria-labelledby="headingOne" data-parent="#accordionExample">
      <div class="card-body">
		<p>EDI is able to support high-level analysis and synthesis of complex ecosystem data across the science-policy-management continuum, which in turn helps advance ecosystem research. By providing the means to share data sets and develop collaborations as part of our data sharing processes, EDI seeks to improve:</p>

		<ul>
			<li>the availability and quality of data from the varied contributing research sites,</li>
			<li>the timeliness and quantity of derived data products, and</li>
			<li>the knowledge gained from the synthesis of research data.</li>
		</ul>

		<p><i>The EDI Data Portal uses a rolling-update approach to continuously release improved versions as they are ready for the community.</i></p>
      </div>
    </div>
  </div>
  <div class="card">
    <div class="card-header" id="headingTwo">
      <h2 class="mb-0">
        <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
        	For Data Managers, Software Developers, and Other Interested Parties
        </button>
      </h2>
    </div>
    <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionExample">
		<div class="card-body">
    	<p>The PASTA framework is comprised of the Gatekeeper identity authentication service* and the following application programming interfaces (APIs) exposed by the PASTA Web Services:</p>
		<ul>
			<li>The Audit Service API</li>
			<li>The Event Manager API</li>
			<li>The Data Package Manager API, includes:
				<ul>
					<li>Data Manager</li>
					<li>Metadata Manager</li>
					<li>Provenance Factory</li>
				</ul>
			</li>
		</ul>

		<p>The Gatekeeper is a reverse-proxy service that performs user identity verification and service forwarding; it does not perform any direct PASTA function and does not have a web services API.</p>

		<p>The Audit Manager collects information about operations that are executed within the PASTA environment and provides an API for searching and viewing recorded events.</p>

		<p>The Event Manager is an extended feature of PASTA and allows users to subscribe their own workflows to PASTA data package upload (insert or update) events.</p>

		<p>The Data Package Manager is the component responsible for processing data package uploads into PASTA and for running queries to search for data packages that reside in PASTA based on a user's search criteria.</p>

		<p>Like the EDI Data Portal, all of PASTA's services use a rolling-update approach to adding bug fixes, improvements, and new features to each of the services.</p>

		<p><i>*User authentication is required for all data input to the PASTA system.</i></p>
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

<%@ include file="bootstrap-javascript.jsp" %>
<script>
	$(function () {
		$('[data-toggle="tooltip"]').tooltip()
	})
</script>
</body>

</html>
