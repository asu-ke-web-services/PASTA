<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	       trimDirectiveWhitespaces="true"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%@ include file="context-reader.jsp" %>

<%
  final String pageTitle = "Metadata Viewer";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  String metadataHtml = (String) request.getAttribute("metadataHtml");
  String packageId = (String) request.getAttribute("packageId");

  if (packageId == null || packageId.isEmpty()) {
    packageId = "unknown";
  }

%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>
	<style>
		pre {
			white-space: pre-wrap;
			word-break: keep-all
		}
	</style>
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
			<!-- Content -->
			<%= metadataHtml %>
			<!-- /Content -->
		</div>
	</div>
</div>

<div class="footer pt-5">
	<jsp:include page="<%= bigFooterInclude %>" />
	<jsp:include page="asu-footer.jsp" />
</div>
</div>

<%@ include file="bootstrap-javascript.jsp" %>
<script>
	// handles the toggling of collapsed sub-tables (such as in the
	// data entities area of the page). Uses a combination of jQuery
	// the the collapse() method provided by Bootstrap 4.
	//
	// Whenever the user clicks on a link with the class of 'non-numeric-toggle',
	// the nearest item with the '.collapse' class is toggled.
	$('.non-numeric-toggle').click( function(e) {
		$(this).siblings('.collapse').collapse('toggle');
		return false;
	});

	// we are using Bootstrap's 'collapse' feature to toggle metadata boxes
	// open and closed, but this doesn't work as well when you're trying to open/close
	// of of them at once, because the collapse code will toggle them by default. This
	// means that if you have already opened one or more boxes, and then use 'show all'
	// to try to show them all, the ones you've opened will toggle closed, while the others
	// will toggle open.

	// here we are being more specific, so that our show/hide all buttons do what they say.

	$("#hideAll").click( function(e) {
		// find any open card bodies, and close them
		$(".card-body.collapse.show").collapse('hide');
	});

	$("#showAll").click( function() {
		// find any card bodies set to be collapsible, and open them up
		$(".card-body.collapse").collapse('show');
	});
</script>
</body>

</html>
