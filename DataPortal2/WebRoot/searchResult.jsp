<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERTerms" %>

<%@ include file="context-reader.jsp" %>

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
  int textBoxSize = 80;
  String textBoxSizeStr = "80";
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
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>
    <script src="js/clipboard.min.js"></script>
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
    <script>
      var clipboard = new Clipboard('.btn');

      clipboard.on('success', function(e) {
          console.log(e);
      });

      clipboard.on('error', function(e) {
          console.log(e);
      });
    </script>
    <div class="container main-content">
      <div class="row align-items-center">
        <div class="col">
            <h1>Search Results</h1>
        </div>
        <div class="col-2">
            <button class="btn btn-secondary" href="#search-details" data-toggle="collapse"><span class="fas fa-link"></span> Search URL</button>
        </div>
        <div class="col-2">
            <form id="mapsearch" class="form-inline" action="./mapSearchServlet" method="post" name="mapsearch">
              <button type="submit" class="btn btn-secondary"><span class="fas fa-map-marker-alt"></span> View as Map</button>
            </form>
        </div>
        <div class="col">
          <form class="form-inline" action="./simpleSearch" method="post" _lpchecked="1">
            <div class="input-group">
              <input class="form-control" type="search" name="terms" id="navBarTerms" placeholder="Search The Portal" aria-label="Search">
              <div class="input-group-append">
                <button class="btn btn-primary" type="submit">Search</button>
              </div>
            </div>
          </form>
          <!-- <span><a href="advancedSearch.jsp">Advanced Search</a></span> -->
       </div>
      </div>
      <div class="row">
        <div class="col-8">
          <%=termsListHTML%>
        </div>
        <div class="col">
          <a href="advancedSearch.jsp">Advanced Search</a>
        </div>
      </div>
      <div class="row">
        <div class="col">
            <div class="collapse" id="search-details">
                <div class="card mb-5 bg-light">
                  <h5 class="card-header">Search URL</h5>
                  <div class="card-body">
                    <div class="row">
                      <div class="col">
                        <p>You can use the URL shown below to run this search again:</p>
                        <div class="input-group">
                          <input id="queryURL" type="text" value="<%=queryURL%>" class="form-control" placeholder="query-URL" aria-label="query-URL" aria-describedby="basic-addon1">
                          <div class="input-group-append">
                            <a href="#" data-clipboard-target="#queryURL" class="btn btn-secondary">Copy URL</a>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
            </div>
        </div>
      </div>

      <div class="row">
        <div class="col">
          <%=searchResult%>
        </div>
      </div>
    </div>
    <div class="footer mt-5">
        <jsp:include page="<%= bigFooterInclude %>" />
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