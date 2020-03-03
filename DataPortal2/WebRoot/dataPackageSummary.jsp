<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.ConfigurationListener"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.client.DataPackageManagerClient" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="context-reader.jsp" %>

<%
  final String googleMapsKey = (String) ConfigurationListener.getOptions().getProperty("maps.google.key");
  final String pageTitle = "Data Package Summary";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);

  String wasDeletedHTML = (String) request.getAttribute("wasDeletedHTML");
  String titleHTML = (String) request.getAttribute("dataPackageTitleHTML");
  String viewFullMetadataHTML = (String) request.getAttribute("viewFullMetadataHTML");
  String creatorsHTML = (String) request.getAttribute("dataPackageCreatorsHTML");
  String abstractHTML = (String) request.getAttribute("abstractHTML");
  String intellectualRightsHTML = (String) request.getAttribute("intellectualRightsHTML");
  String publicationDateHTML = (String) request.getAttribute("dataPackagePublicationDateHTML");
  String packageIdHTML = (String) request.getAttribute("dataPackageIdHTML");
  String resourcesHTML = (String) request.getAttribute("dataPackageResourcesHTML");
  String citationHTML = (String) request.getAttribute("citationHTML");
  String citationLinkHTML = (String) request.getAttribute("citationLinkHTML");
  String digitalObjectIdentifier = (String) request.getAttribute("digitalObjectIdentifier");
  String pastaDataObjectIdentifier = (String) request.getAttribute("pastaDataObjectIdentifier");
  String provenanceHTML = (String) request.getAttribute("provenanceHTML");
  String codeGenerationHTML = (String) request.getAttribute("codeGenerationHTML");
  String spatialCoverageHTML = (String) request.getAttribute("spatialCoverageHTML");
  String googleMapHTML = (String) request.getAttribute("googleMapHTML");
  String savedDataHTML = (String) request.getAttribute("savedDataHTML");
  String jsonCoordinates = (String) request.getAttribute("jsonCoordinates");
  Boolean expandCoordinates = (Boolean) request.getAttribute("expandCoordinates");
  Double northCoord = (Double) request.getAttribute("northCoord");
  Double southCoord = (Double) request.getAttribute("southCoord");
  Double eastCoord = (Double) request.getAttribute("eastCoord");
  Double westCoord = (Double) request.getAttribute("westCoord");

  String uid = (String) session.getAttribute("uid");
  boolean showAbstract = !(abstractHTML == null || abstractHTML.isEmpty());
  boolean showIntellectualRights = !(intellectualRightsHTML == null || intellectualRightsHTML.isEmpty());
  boolean showPubDate = !(publicationDateHTML == null || publicationDateHTML.isEmpty());
  boolean showSpatial = !(spatialCoverageHTML == null || spatialCoverageHTML.isEmpty());
  boolean showCodeGeneration = !(codeGenerationHTML == null || codeGenerationHTML.isEmpty());
  boolean showSavedData = !(savedDataHTML == null || savedDataHTML.isEmpty());
  String showCoordinates = "true";
  if ((expandCoordinates != null) && !expandCoordinates) {
  	showCoordinates = "false";
  }
  String showWasDeleted = "true";
  if ((wasDeletedHTML == null) || (wasDeletedHTML.equals(""))) {
    showWasDeleted = "false";
  }

    HttpSession httpSession = request.getSession();
    if ((uid == null) || (uid.equals(""))) {
        uid = "public";
    }
    String tier = null;
    String testHTML = "";
    String watermarkClass = "";
    String watermarkId = "";
    String watermarkText = "";
    String showTestHTML = "false";
    DataPackageManagerClient dpmc = new DataPackageManagerClient(uid);
    String pastaHost = dpmc.getPastaHost();

    if (pastaHost.startsWith("pasta-d") ||
        pastaHost.startsWith("localhost")
       ) {
       tier = "development";
    }
    else if (pastaHost.startsWith("pasta-s")) {
       tier = "staging";
    }

    if (tier != null) {
        showTestHTML = "true";
        watermarkClass = "watermarked";
        watermarkId = "watermarked-background-text";
        watermarkText = "Test Data Package";
        String fontColor = "darkorange";
        testHTML = String.format("<font color='%s'>This test data package was submitted to a %s environment. It is not considered production ready.</font>", fontColor, tier);
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>
	<script type="text/javascript" src="./js/map_functions_bing.js"></script>
	<script type='text/javascript' src='https://www.bing.com/api/maps/mapcontrol?callback=GetMap' async defer></script>

<c:set var="showSpatial" value="<%= showSpatial %>"/>
<c:choose>
	<c:when test="${showSpatial}">
		<script type="text/javascript">
			window.onload = function () {
				var coordinatesArray = <%= jsonCoordinates %>;
				var north = <%= northCoord %>;
				var south = <%= southCoord %>;
				var east = <%= eastCoord %>;
				var west = <%= westCoord %>;
				initialize_summary_map_bing(coordinatesArray, north, south, east, west);
			};
		</script>
	</c:when>
</c:choose>
<style>
	.no-list-style {
		list-style-type: none;
		padding: 0;
	}
	/* Styles to support "Show more" and "Show less" in combination with jQuery code */
	.morecontent span {
			display: none;
	}

	.morelink {
    /* display: block; */
	}
</style>
</head>

<body>

<jsp:include page="asu-header.jsp">
    <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
    <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
    <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
    <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
</jsp:include>
<jsp:include page="<%= menuInclude %>" flush="true" />

<div id="<%= watermarkId %>" class="<%= watermarkClass %>"><%= watermarkText %></div>

<div class="container main-content">
	<div class="row">
		<div class="col">
			<c:set var="showTestHTML" value="<%= showTestHTML %>"/>
			<c:choose>
				<c:when test="${showTestHTML}">
					<p class="alert alert-warning my-4"><%= testHTML %></p>
				</c:when>
			</c:choose>
			<c:set var="showWasDeleted" value="<%= showWasDeleted %>"/>
			<c:choose>
				<c:when test="${showWasDeleted}">
					<span class="nis-banner-msg">&nbsp;&nbsp;<%= wasDeletedHTML %>&nbsp;&nbsp;</span>
					<span class="row-fluid separator_border"></span>
				</c:when>
			</c:choose>
			<!--
			<div class="recent_title">
				<h2>Data Package Summary&nbsp;&nbsp;&nbsp;<small><small><%= viewFullMetadataHTML %></small></small></h2>
			</div>
			-->
		</div>
	</div>
	<!--
	<dl class="row">
		<dt class="col-sm-2 text-right">
			Title:
		</dt>
		<dd class="col">
			<%= titleHTML %>
		</dd>
	</dl>
	-->
	<div class="row">
		<div class="col">
			<p class="text-muted">Data Package Summary</p>
		</div>
	</div>

	<div class="row">
		<div class="col">
			<h3><%=titleHTML%></h3>
		</div>
	</div>
	<!-- Potential Menu Idea
	<hr />
	<div class="row">
		<div class="col">
			<ul class="nav nav-pills nav-fill">
				<li class="nav-item">
					<div class="dropdown">
						<a class="dropdown-toggle" href="#" id="metadataMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Metadata</a>
						<div class="dropdown-menu" aria-labelledby="metadataMenuLink">
							<a class="dropdown-item" href="#">Full Metadata</a>
							<a class="dropdown-item" href="#">Provenance Metadata</a>
						</div>
					</div>
				</li>
				<li class="nav-item">
					<div class="dropdown">
						<a class="dropdown-toggle" href="#" id="codeMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Revisions
						</a>
						<div class="dropdown-menu" aria-labelledby="codeMenuLink">
							<a class="dropdown-item" href="#">Previous Revision</a>
							<a class="dropdown-item" href="#">All Revisions</a>
						</div>
					</div>
				</li>
				<li class="nav-item">
					<div class="dropdown">
						<a class="dropdown-toggle" href="#" id="codeMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							Generate Code
						</a>
						<div class="dropdown-menu" aria-labelledby="codeMenuLink">
							<a class="dropdown-item" href="#">MatLab</a>
							<a class="dropdown-item" href="#">R</a>
							<a class="dropdown-item" href="#">SAS</a>
							<a class="dropdown-item" href="#">SPSS</a>
							<a class="dropdown-item" href="#">tidyr</a>
						</div>
					</div>
				</li>
				<li class="nav-item">
					<a class="" href="#">Data Package Report</a>
				</li>
				<li class="nav-item">
					<a class="" href="#"><span class="fas fa-download">&nbsp;Download</span></a>
				</li>
			</ul>
		</div>
	</div>
	<hr />
	end menu idea-->

	<dl class="row">
		<dt class="col-sm-2 text-right">Creators:</dt>
		<dd class="col">
			<%= creatorsHTML %>
		</dd>
	</dl>

	<c:set var="showDate" value="<%= showPubDate %>"/>
	<c:choose>
		<c:when test="${showDate}">
			<dl class="row">
				<dt class="col-sm-2 text-right">Publication Date:</dt>
				<dd class="col">
					<%= publicationDateHTML %>
				</dd>
			</dl>
		</c:when>
	</c:choose>

	<dl class="row">
		<dt class="col-sm-2 text-right">Citation:</dt>
		<dd class="col">
			<%= citationHTML %>
		</dd>
	</dl>

	<c:set var="showAbstract" value="<%= showAbstract %>"/>
	<c:choose>
		<c:when test="${showAbstract}">
			<dl class="row">
				<dt class="col-sm-2 text-right">Abstract:</dt>
				<dd class="col">
					<div class="more"><%= abstractHTML %></div>
				</dd>
			</dl>
		</c:when>
	</c:choose>

		<c:choose>
			<c:when test="${showSpatial}">
				<dl class="row">
					<dt class="col-sm-2 text-right">Spatial Coverage:</dt>
					<dd class="col-8">
						<div id="map-canvas-summary" style="width: 100%; height: 400px;"></div>
						<%-- googleMapHTML --%>
						<div class="card">
							<div class="card-header">
								<a href="#spatialCoverage" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="spatialCoverage">Show/Hide Coordinates</a>
							</div>
							<div class="collapse" id="spatialCoverage">
								<div class="card-body">
									<%= spatialCoverageHTML %>
								</div>
							</div>
						</div>
					</dd>
				</dl>
			</c:when>
		</c:choose>
		<dl class="row">
			<dt class="col-sm-2 text-right">Package ID:</dt>
			<dd class="col">
				<%= packageIdHTML %>
				<c:set var="showSavedData" value="<%= showSavedData %>"/>
				<c:if test="${showSavedData}">
					<%= savedDataHTML %>
				</c:if>
			</dd>
		</dl>
		<dl class="row">
			<dt class="col-sm-2 text-right">Resources:</dt>
			<dd class="row">
				<div class="resources" style="padding-left: 40px;">
					<%= resourcesHTML %>
				</div>
			</dd>
		</dl>

		<c:set var="showIntellectualRights" value="<%= showIntellectualRights %>"/>
		<c:choose>
			<c:when test="${showIntellectualRights}">
				<dl class="row">
					<dt class="col-sm-2 text-right">Intellectual Rights:</dt>
					<dd class="col">
						<%= intellectualRightsHTML %>
					</dd>
				</dl>
			</c:when>
		</c:choose>

		<dl class="row">
			<dt class="col-sm-2 text-right">Digital Object Identifier:</dt>
			<dd class="col">
				<%= digitalObjectIdentifier %>
			</dd>
		</dl>

		<dl class="row">
			<dt class="col-sm-2 text-right">PASTA Identifier:</dt>
			<dd class="col">
				<%= pastaDataObjectIdentifier %>
			</dd>
		</dl>

<!--
<div class="table-row">
<div class="table-cell text-align-right">
<label class="labelBold">Citation:</label>
</div>
<div class="table-cell">
<ul class="no-list-style">
<li><%= citationLinkHTML %></li>
</ul>
</div>
</div>
-->

		<dl class="row">
			<dt class="col-sm-2 text-right">Provenance:</dt>
			<dd class="col">
				<%= provenanceHTML %>
			</dd>
		</dl>

		<c:set var="showCodeGeneration" value="<%= showCodeGeneration %>"/>
		<c:if test="${showCodeGeneration}">
			<dl class="row">
				<dt class="col-sm-2 text-right">Code Generation:</dt>
				<dd class="col">
					<%= codeGenerationHTML %>
				</dd>
			</dl>
		</c:if>

		</div>
	</div>
</div>

<div class="footer pt-5">
    <jsp:include page="<%= bigFooterInclude %>" />
	<jsp:include page="asu-footer.jsp" />
</div>


  </div>
<%@ include file="bootstrap-javascript.jsp" %>
<script type="text/javascript" src="./js/more_less.js"></script>

<!-- End jqWidgets JavaScript for jqxTree widget -->
</body>

</html>
