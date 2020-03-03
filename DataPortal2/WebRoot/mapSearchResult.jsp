<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.ConfigurationListener"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERTerms" %>

<%
  final String pageTitle = "Search Results Map";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  final String googleMapsKey = (String) ConfigurationListener.getOptions().getProperty("maps.google.key");

  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName()
      + ":" + request.getServerPort() + path + "/";

  String termsListHTML = (String) session.getAttribute("termsListHTML");
  String mapSearchResults = (String) request.getAttribute("mapSearchResults");

  if (termsListHTML == null)
    termsListHTML = "";

  if (mapSearchResults == null)
    mapSearchResults = "";

%>
<%@ include file="context-reader.jsp" %>

<!DOCTYPE html>
<html lang="en">
  <head>
  <!-- common <head> tag elements -->
    <jsp:include page="common-head.jsp">
        <jsp:param name="siteName" value="<%= siteName %>" />
    </jsp:include>
    <script type="text/javascript" src="./js/map_functions_bing.js"></script>
    <script type='text/javascript' src='https://www.bing.com/api/maps/mapcontrol?callback=initialize_map_results' async defer></script>
    <script>
    var locations = <%=mapSearchResults%>;
    </script>
  </head>

  <body>
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
          <h2>Search Results</h2>
          <%= termsListHTML %>
          <div>
            <div id="map-canvas" style="width: 1024px; height: 512px;"></div>
          </div>
        </div>
      </div>
    </div>

    <div class="footer mt-5">
        <jsp:include page="<%= bigFooterInclude %>" />
        <jsp:include page="asu-footer.jsp" />
    </div>

    <%@ include file="bootstrap-javascript.jsp" %>
  </body>
</html>
