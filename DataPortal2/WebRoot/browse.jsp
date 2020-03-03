<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERTerms" %>
<%@ page import="edu.lternet.pasta.portal.search.BrowseSearch" %>
<%@ page import="edu.lternet.pasta.portal.search.BrowseGroup" %>

<%@ include file="context-reader.jsp" %>

<%
	final String pageTitle = "Browse Data Packages";
	final String titleText = DataPortalServlet.getTitleText(pageTitle);
	String attributeName = "browseKeywordHTML";
	String messageAttribute = "myMessage";
	String browseHTML = (String) application.getAttribute(attributeName);
	String myMessage = (String) application.getAttribute(messageAttribute);
%>

<!DOCTYPE html>
<html lang="en">
	<head>
	    <!-- common <head> tag elements -->
        <jsp:include page="common-head.jsp">
            <jsp:param name="siteName" value="<%= siteName %>" />
        </jsp:include>
    </head>

    <!-- incude main ASU Header-->
    <jsp:include page="asu-header.jsp">
        <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
        <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
        <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
        <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
    </jsp:include>
    <jsp:include page="<%= menuInclude %>" flush="true" />
	<body>
		<div class="container main-content">
			<div class="row">
				<div class="col">
					<h2>Browse Data by Keyword or LTER Site</h2>

					<p>Browse data packages by keyword or LTER site using the links
					below. The number of matching data packages is shown in
					parentheses.<sup>*</sup> <sup>**</sup></p>

					<p class="alert alert-danger"><%= myMessage %></p>

					<div class="jumbotron">
						<div id='jqxTree'>
							<%=browseHTML%>
						</div>
					</div>

					<p><sup>*</sup><small><em>Only public documents are accessible from this page.</em></small></p>
					<p><sup>**</sup><small><em>Search results are refreshed nightly.</em></small></p>

					<%@ include file="bootstrap-javascript.jsp" %>
					<script type="text/javascript" src="./js/jqwidgets-ver3.2.1/jqxcore.js"></script>
					<script type="text/javascript" src="./js/jqwidgets-ver3.2.1/jqxbuttons.js"></script>
					<script type="text/javascript" src="./js/jqwidgets-ver3.2.1/jqxscrollbar.js"></script>
					<script type="text/javascript" src="./js/jqwidgets-ver3.2.1/jqxpanel.js"></script>
					<script type="text/javascript" src="./js/jqwidgets-ver3.2.1/jqxtree.js"></script>
				</div>
			</div>
		</div>

		<div class="footer mt-5">
            <jsp:include page="<%= bigFooterInclude %>" />
            <jsp:include page="asu-footer.jsp" />
		</div>

		<script type="text/javascript">
			$(document).ready(function () {
				// Create jqxTree
				$('#jqxTree').jqxTree(
				{
					height: '600px',
					theme: 'energyblue',
					toggleMode: 'click'
				});

				$('#jqxTree').bind('select', function (event) {
					var htmlElement = event.args.element;
					var item = $('#jqxTree').jqxTree('getItem', htmlElement);
				});
			});
		</script>
	</body>
</html>
