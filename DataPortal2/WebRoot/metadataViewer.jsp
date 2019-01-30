<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	       trimDirectiveWhitespaces="true"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

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
	<%@ include file="common-head.jsp" %>
</head>

<body>

<jsp:include page="asu-header.jsp" />
<jsp:include page="header.jsp" />

<div class="row-fluid ">
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="row-fluid">
							<div class="span12">

								<!-- Content -->
                  <%= metadataHtml %>
							  <!-- /Content -->

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

<script type="text/javascript">
	jQuery("#showAll").click(function() {
		jQuery(".collapsible").show();
	});

	jQuery("#hideAll").click(function() {
		jQuery(".collapsible").hide();
	});

	jQuery(".toggleButton").click(function() {
		jQuery(this).next(".collapsible").slideToggle("fast");
	});

	jQuery(".collapsible").hide();

	jQuery("#toggleSummary").next(".collapsible").show();
</script>
<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
