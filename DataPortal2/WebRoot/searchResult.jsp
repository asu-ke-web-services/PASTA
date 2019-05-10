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
    <%@ include file="common-head.jsp" %>
    <script src="js/clipboard.min.js"></script>
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
    <div class="container main-content">
      <div class="row">
        <div class="col-8">
          <h1>Search Results</h1>
          <%=termsListHTML%>
        </div>
        <div class="col-2">
            <form id="mapsearch" class="form-inline" action="./mapSearchServlet" method="post" name="mapsearch">
              <button type="submit" class="btn btn-secondary"><span class="fas fa-map-marker-alt"></span> View as Map</button>
            </form>
        </div>
        <div class="col-2">
            <button class="btn btn-secondary" href="#searchDetails" data-toggle="collapse"><span class="fas fa-link"></span>Search URL</button>
        </div>
        <!--
        <div class="col-2">
          <%=relevanceHTML%>
        </div>
        -->
      </div>
      <div class="collapse" id="searchDetails">
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
      <hr />
      <div class="row">
        <div class="col">
          <%=searchResult%>
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