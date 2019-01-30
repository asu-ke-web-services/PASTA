<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERTerms" %>
<%@ page import="edu.lternet.pasta.portal.search.BrowseSearch" %>
<%@ page import="edu.lternet.pasta.portal.search.BrowseGroup" %>

<%
  final String pageTitle = "Browse Data Packages";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  String attributeName = "browseKeywordHTML";
  String browseHTML = (String) application.getAttribute(attributeName);
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- common <head> tag elements -->
	<%@ include file="common-head.jsp" %>

	<script type="text/javascript">
        $(document).ready(function () {
            // Create jqxTree
            $('#jqxTree').jqxTree(
            { height: '600px',
              theme: 'energyblue',
              toggleMode: 'click'
            });

            $('#jqxTree').bind('select', function (event) {
                var htmlElement = event.args.element;
                var item = $('#jqxTree').jqxTree('getItem', htmlElement);
             });
        });
    </script>
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
								<h2>Browse Data by Keyword or LTER Site</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>
						<div class="row-fluid">
							<div class="content span12 box_layout">
								<p>
									Browse data packages by keyword or LTER site using the links
									below. The number of matching data packages is shown in
									parentheses.<sup>*</sup> <sup>**</sup>
								</p>

								<div id='jqxTree'>
									<%=browseHTML%>
								</div>
								<p>
									<sup>*</sup>
									<small><em>Only public documents are accessible from this page.</em></small>
								</p>
								<p>
									<sup>**</sup>
									<small><em>Search results are refreshed nightly.</em></small>
								</p>
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
