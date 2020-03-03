<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
  final String pageTitle = "Metadata Previewer";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<%@ include file="context-reader.jsp" %>

<!DOCTYPE html>

<html lang="en">

<head>
    <!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>

</head>

<body>

<jsp:include page="asu-header.jsp">
    <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
    <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
    <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
    <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
</jsp:include>
<jsp:include page="<%= menuInclude %>" flush="true" />

<div class="row-fluid ">
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="row-fluid">
							<div class="span12">
							  <div class="recent_title">
								  <h2>Metadata Previewer</h2>
							  </div>
							<span class="row-fluid separator_border"></span>
						</div>
						<div class="row-fluid">
							<div class="span12">
		            <div class="content">

        <p>Preview a rendered version of EML in HTML format by browsing to your
           EML file and then selecting <b>Preview</b>.</p>

        <div class="section">
          <form id="metadataPreviewer" name="metadataPreviewer" method="post"
            action="./metadataPreviewer" enctype="multipart/form-data"
          >
            <label  class="labelBold">EML File:</label>
            <input type="file" name="emlfile" accept="application/xml" required="required" />
            <div>
            <input class="btn btn-info btn-default" type="submit" name="upload" value="Preview" />
            <input  class="btn btn-info btn-default"type="reset" name="reset" value="Clear" />
            </div>
          </form>
        </div>

             </div>

		       </div>
		<!-- end of content -->

						  </div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="footer mt-5">
		<jsp:include page="<%= bigFooterInclude %>" />
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

</body>

</html>
