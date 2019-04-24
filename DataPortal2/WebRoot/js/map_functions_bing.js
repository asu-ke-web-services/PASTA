/*
 * Version of the initialize() method from the Google Maps version. Creates a map for
 * use on the advanced search page.
 */
function initialize_bing() {
    var navBarMode = Microsoft.Maps.NavigationBarMode;
    var map = new Microsoft.Maps.Map('#map-canvas', {
        credentials: 'AjwqJVkzsDrU3TZUB17VEtgEb89N0eVSm13q0OMqf_brvE3FKaacsVxDA4UcsuXO',
        center: new Microsoft.Maps.Location(0.0, 0.0),
        zoom: 2,
        showMapTypeSelector: false,
        showLocateMeButton: false,
		navigationBarMode: navBarMode.compact,
		disableScrollWheelZoom: true
    });

    // binding our events
    Microsoft.Maps.Events.addHandler(map, 'viewchange', function () {
        var myRect = map.getBounds();
        document.advancedSearchForm.northBound.value = Number.parseFloat( myRect.getNorth() ).toFixed(3);
        document.advancedSearchForm.westBound.value = Number.parseFloat( myRect.getWest() ).toFixed(3);
        document.advancedSearchForm.southBound.value = Number.parseFloat( myRect.getSouth() ).toFixed(3);
        document.advancedSearchForm.eastBound.value = Number.parseFloat( myRect.getEast() ).toFixed(3);
    });
}


/*
 * Version of initialize_summary_map() above, but for Bing maps - as we are unable
 * to use Google maps, due to their requirement for having a payment method (credit
 * card) on file.
 */
function initialize_summary_map_bing(coordinatesArray, north, south, east, west) {
	var lat = (north + south)  / 2.0;
	var lng = (west + east) / 2.0;

    var navBarMode = Microsoft.Maps.NavigationBarMode;
    var map = new Microsoft.Maps.Map('#map-canvas-summary', {
		credentials: 'AjwqJVkzsDrU3TZUB17VEtgEb89N0eVSm13q0OMqf_brvE3FKaacsVxDA4UcsuXO',
		center: new Microsoft.Maps.Location(lat, lng),
		zoom: 9,
		showMapTypeSelector: false,
		showLocateMeButton: false,
		navigationBarMode: navBarMode.compact,
		disableScrollWheelZoom: true
	});

	var maxNorth = -999;
	var minSouth = 999;
	var maxEast = -999;
	var minWest = 999;
	var dataBounds = [];

	for (var i = 0; i < coordinatesArray.length; i++) {
		var coord = coordinatesArray[i];

		var north = Number(coord.north);
		maxNorth = Math.max(maxNorth, north);

		var south = Number(coord.south);
		minSouth = Math.min(minSouth, south);

		var east = Number(coord.east);
		maxEast = Math.max(maxEast, east);

		var west = Number(coord.west);
		minWest = Math.min(minWest, west);

		var nwLatLng = new Microsoft.Maps.Location(north, west);
		var seLatLng = new Microsoft.Maps.Location(south, east);

		// push both these points on our data points array
		dataBounds.push(nwLatLng);
		dataBounds.push(seLatLng);

	    if ((north == south) && (east == west)) {
			var pin = new Microsoft.Maps.Pushpin(nwLatLng, {color: "red"});
			map.entities.push(pin);
			map.setView({
				center: nwLatLng,
				zoom: 10
			})
	    }
	    else {
	    	var rect = new Microsoft.Maps.Polygon([
				new Microsoft.Maps.Location(north, west),
				new Microsoft.Maps.Location(south, west),
				new Microsoft.Maps.Location(south, east),
				new Microsoft.Maps.Location(north, east),
				new Microsoft.Maps.Location(north, west)
			]);
			map.entities.push(rect);
	    }
	}

	if ((maxNorth != minSouth) || (maxEast != minWest)) {
	// 	// first, build a rectangle from the outer bounds of all those data points we gathered
		var mapBounds = Microsoft.Maps.LocationRect.fromLocations(dataBounds);

	// then, set the map to those bounds
		map.setView( {
			bounds: mapBounds,
			padding: 20
		})
	}
}

function initialize_map_results() {
	var clusterLayer;
	var allPins = [];
	var allPoints = []
	var navBarMode = Microsoft.Maps.NavigationBarMode;

	// make a map
	var map = new Microsoft.Maps.Map('#map-canvas', {
		credentials: 'AjwqJVkzsDrU3TZUB17VEtgEb89N0eVSm13q0OMqf_brvE3FKaacsVxDA4UcsuXO',
		mapTypeId: Microsoft.Maps.MapTypeId.grayscale,
        center: new Microsoft.Maps.Location(0.0, 0.0),
		zoom: 2,
		minZoom: 2,
		showLocateMeButton: false,
		disableScrollWheelZoom: true,
        navigationBarMode: navBarMode.compact
	});

	// loop through the projects and make a pushpin for each, pushing them into an array
	// (not on the map itself, as the cluster layer will be responsible for that)
	locations.forEach(element => {
		var pinLocation = new Microsoft.Maps.Location(element.location.latitude, element.location.longitude);
		allPoints.push(pinLocation);
		var pin = new Microsoft.Maps.Pushpin(pinLocation, {color: "red"});
		pin.metadata = {
			title: "",
			description: element.titleLink
		}
		allPins.push(pin);

		Microsoft.Maps.Events.addHandler(pin, 'click', function (args) {
			infobox.setOptions({
				location: args.target.getLocation(),
				title: args.target.metadata.title,
				description: args.target.metadata.description,
				visible: true
			});
		});
	});

	// set up a reusable info box for showing info
	var infobox = new Microsoft.Maps.Infobox(allPins[0].getLocation(), {
		visible: false,
		autoAlignment: true,
	});
	infobox.setMap(map);

	//Load the clustering module
	Microsoft.Maps.loadModule("Microsoft.Maps.Clustering", function () {
		//Create a ClusterLayer and add it to the map.
		clusterLayer = new Microsoft.Maps.ClusterLayer(allPins, {
			clusteredPinCallback: customizeClusteredPin
		});
		map.layers.insert(clusterLayer);
	});

	function customizeClusteredPin(cluster) {
		//Add click event to clustered pushpin
		Microsoft.Maps.Events.addHandler(cluster, 'click', clusterClicked);
	}

	function clusterClicked(e) {
		if (e.target.containedPushpins) {
			var locs = [];
			for (var i = 0, len = e.target.containedPushpins.length; i < len; i++) {
				//Get the location of each pushpin.
				locs.push(e.target.containedPushpins[i].getLocation());
			}

			//Create a bounding box for the pushpins.
			var bounds = Microsoft.Maps.LocationRect.fromLocations(locs);

			//Zoom into the bounding box of the cluster.
			//Add a padding to compensate for the pixel area of the pushpins.
			map.setView({ bounds: bounds, padding: 100 });
		}
	}

	function resetMap() {
		map.setView({
		center: new Microsoft.Maps.Location(0.0, 0.0),
		zoom: 2
		});
	};

}
