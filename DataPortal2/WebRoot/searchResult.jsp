<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERTerms" %>

<%
  final String pageTitle = "Search Results";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName()
      + ":" + request.getServerPort() + path + "/";

  String termsListHTML = (String) session.getAttribute("termsListHTML");
  if (termsListHTML == null)
    termsListHTML = "";

  String queryText = (String) session.getAttribute("queryText");
  String queryURL = "";
  int textBoxSize = 100;
  String textBoxSizeStr = "100";
  if (!queryText.isEmpty()) {
    queryURL = String.format("%ssimpleSearch?%s", basePath, queryText);
    textBoxSize = Math.min(textBoxSize, queryURL.length());
    textBoxSizeStr = String.format("%d", textBoxSize);
  }

  String mapButtonHTML = (String) request.getAttribute("mapButtonHTML");
  if (mapButtonHTML == null)
    mapButtonHTML = "";

  String relevanceHTML = (String) request.getAttribute("relevanceHTML");
  if (relevanceHTML == null)
    relevanceHTML = "";

  String searchResult = (String) request.getAttribute("searchresult");

  if (searchResult == null)
    searchResult = "";

  //String jqueryString = LTERTerms.getJQueryString(); // for auto-complete using JQuery
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

    <script>
    var clipboard = new Clipboard('.btn');

    clipboard.on('success', function(e) {
        console.log(e);
    });

    clipboard.on('error', function(e) {
        console.log(e);
    });
    </script>

  <div class="row-fluid ">
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="span12">
							<div class="recent_title">
								<h2>Search Results (searchResult.jsp)</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>

						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->
	<table>
   		<tr>
			<td>
				<%=mapButtonHTML%>
			</td>
			<td>
				<%=relevanceHTML%>
			</td>
  		</tr>
	</table>
    <table>
        <tr>
            <td>
              <table>
                <tr>
                  <td><button class="btn btn-info btn-default" data-clipboard-action="copy" data-clipboard-target="#queryURL">Copy Query URL</button></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                </tr>
              </table>
            </td>
            <td>&nbsp;</td>
            <td>
              <input id="queryURL" type="url" value="<%=queryURL%>" size="<%=textBoxSizeStr%>">
            </td>
        </tr>
    </table>


                <%=termsListHTML%>
				<%=searchResult%>

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
