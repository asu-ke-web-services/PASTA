<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
  final String pageTitle = "Provenance Generator";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName()
      + ":" + request.getServerPort() + path + "/";

/*
  String uid = (String) session.getAttribute("uid");

  if (uid == null || uid.isEmpty()) {
    request.setAttribute("from", "./provenanceGenerator.jsp");
    String loginWarning = DataPortalServlet.getLoginWarning();
    request.setAttribute("message", loginWarning);
    RequestDispatcher requestDispatcher = request
        .getRequestDispatcher("./login.jsp");
    requestDispatcher.forward(request, response);
  }
*/

  String provenanceXML = (String) request.getAttribute("provenanceXML");
  String provenanceHTML = (String) request.getAttribute("provenanceHTML");
  String packageid = (String) request.getAttribute("packageid");
  boolean showProvenance = ((provenanceXML != null) && (packageid != null));
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
				<h2>Provenance Generator</h2>
				<p>Provenance metadata should be included in a derived data package to
				document its sources. This can be accomplished by adding a separate
				<strong>&lt;methodStep&gt;</strong> element in the derived data package
				for each of the source data packages from which it is derived.</p>

				<c:set var="showProv" value="<%= showProvenance %>"/>
				<c:choose>
					<c:when test="${showProv}">
						<p>A data package derived from <strong><%= packageid %></strong> as one of its
						source data packages should include the <strong>&lt;methodStep&gt;</strong>
						element shown below as a sub-element within its
						<strong>&lt;methods&gt;</strong> element.</p>

                        <div id="metadata-tabs">
                            <ul class="nav nav-tabs">
                                <li class="nav-item">
                                    <a class="nav-link active" href="#htmlTab" data-toggle="tab" aria-controls="Provenance Metadata HTML" aria-selected="true">Provenance Metadata HTML</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#xmlTab" data-toggle="tab" aria-controls="Provenance Metadata XML" aria-selected="false">Provenance Metadata XML</a>
                                </li>
                            </ul>
                        </div>

						<div class="tab-content" style="border: 1px solid #eee; border-top: 0; padding: 1em;">
							<div id="htmlTab" class="tab-pane active">
								<%= provenanceHTML %>
							</div>

							<div id="xmlTab"class="tab-pane">
								<pre><%= provenanceXML %></pre>
							</div>
						</div>
					</c:when>
				<c:otherwise>
					<p>Enter the package identifier of the source data package whose provenance metadata you wish to embed in your derived data package:</p>
					<div class="section">
						<form id="provenanceGenerator" action="provenanceGenerator" method="post" name="provenanceGenerator">
							<div class="display-table">
								<div class="table-row">
									<div class="table-cell">
										<label class="labelBold" for="packageid">Package Id:</label>
									</div>
								</div>
								<div class="table-row">
									<div class="table-cell">
										<input name="packageid" required="required" autofocus size="20" type="text" placeholder="e.g., knb-lter-nin.1.3" />
									</div>
								</div>
								<div class="table-row">
									<div class="table-cell">
										<input class="btn btn-info btn-default" name="view" type="submit" value="Generate Metadata" />
										<input class="btn btn-info btn-default" name="reset" type="reset" value="Clear" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>

	<div class="footer pt-5">
		<jsp:include page="<%= bigFooterInclude %>" />
		<jsp:include page="asu-footer.jsp" />
	</div>
	<%@ include file="bootstrap-javascript.jsp" %>
</body>

</body>

</html>
