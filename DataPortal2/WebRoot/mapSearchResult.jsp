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

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- common <head> tag elements -->
	<%@ include file="common-head.jsp" %>


<script>

var map;
var markerclusterer;

function initialize() {
     var iniLat = 0.00;
     var iniLon = -105.00;
     var iniZoom = 2;
     var USLatLng = new google.maps.LatLng(iniLat, iniLon);
     var mapOptions = {
         zoom: iniZoom, center: USLatLng, mapTypeId: google.maps.MapTypeId.SATELLITE, panControl: false,
         zoomControl: true, scaleControl: true, streetViewControl: false, overviewMapControl: false
     };
     map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);

     var oms = new OverlappingMarkerSpiderfier(map, {keepSpiderfied: true});

     var infoWindow = new google.maps.InfoWindow();

     oms.addListener('click', function(marker, event) {
        infoWindow.setContent('<div style="width: 300px; height: 100px; border:2px solid; padding: 2px;"><span style="font-family: Trebuchet MS; font-size:10pt; color: maroon">' + marker.objInfo + '</span></div>');
        infoWindow.open(map, marker);
     });
     oms.addListener('spiderfy', function(markers) {
        infoWindow.close();
     });

     var markers = createMarkers(oms);
     var mcOptions = {gridSize: 10, maxZoom: 15};
     markerclusterer = new MarkerClusterer(map, markers, mcOptions);

	// Enable, and adjust, the following lines to change gridSize according to zoom level
     google.maps.event.addListener(map, 'zoom_changed', function() {
                                                        var gridSize = 10;
                                                        if (map.getZoom() > 4) gridSize = 20;
                                                        if (map.getZoom() > 6) gridSize = 40;
                                                        if (map.getZoom() > 8) gridSize = 60;
                                                        if (map.getZoom() > 10) gridSize = 80;
                                                        markerclusterer.setGridSize(gridSize);
                                                });
 }


function createMarkers(oms) {
    data = [];
    var i;
      for (i = 0; i < documents.length; i++) {
         var position = new google.maps.LatLng(documents[i].location.latitude, documents[i].location.longitude);

         var info = '<b>' + documents[i].packageId + '</b>';

         info += ', ' + documents[i].titleLink;

         if (documents[i].pubDate) {
          	info += ', (' + documents[i].pubDate + ')';
         }

         var marker = new google.maps.Marker(
         {
            title:    documents[i].title,
            position: position,
            objInfo:  info
         });

         /*google.maps.event.addListener(marker, 'click', function() {
          													showInfoWindow(this);
          													});*/
         data.push(marker);
         oms.addMarker(marker);
      }

      return data;
}

var currentWindow;
function showInfoWindow(m) {
       var info = new google.maps.InfoWindow(
       	{
       		content: '<div style="width: 300px; height: 100px; border:2px solid; padding: 2px;"><span style="font-family: Trebuchet MS; font-size:10pt; color: maroon">' + m.objInfo + '</span></div>'
       	});

       if (currentWindow != null) {currentWindow.close();}

       info.open(map, m);
       currentWindow=info;
}

var documents = <%=mapSearchResults%>

 </script>
</head>

<body onload="initialize();">
<jsp:include page="asu-header.jsp" />
<jsp:include page="header.jsp" />

  <div class="row-fluid ">
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="span12">
							<div class="recent_title">
								<h2>Search Results</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>

						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->
								<%= termsListHTML %>
   								<div>
         							<div id="map_canvas" style="height: 600px; width: 940px;"></div>
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
