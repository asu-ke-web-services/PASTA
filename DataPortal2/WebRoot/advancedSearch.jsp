<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.ConfigurationListener"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.Tooltip" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERSite" %>
<%@ page import="edu.lternet.pasta.portal.search.AuthorSearch" %>

<%
  final String pageTitle = "Advanced Search";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  final String googleMapsKey = (String) ConfigurationListener.getOptions().getProperty("maps.google.key");

  final String indent = "              ";
  boolean includeNIN = true;      // include North Inlet in the options list
  String siteOptions = LTERSite.composeHTMLOptions(indent, includeNIN, null);

  AuthorSearch.updateAuthorsAndOrganizations();
  String creatorOptions = AuthorSearch.composeAuthorNameOptions();
  String organizationOptions = AuthorSearch.composeAuthorOrganizationOptions();
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- common <head> tag elements -->
	<%@ include file="common-head.jsp" %>
  <script type="text/javascript" src="./js/utilities.js"></script>
  <script type="text/javascript" src="./js/validation.js"></script>
  <script type="text/javascript" src="./js/map_functions_bing.js"></script>
  <script type="text/javascript">

      var boundsChangedCount = 0;

      function boundsChanged() {
          boundsChangedCount++;
          document.advancedSearchForm.boundsChangedCount.value = boundsChangedCount;
      }

      function submitRequest(form) {
        var canSearch = true;

        if (trim(form.subjectValue.value) == "" &&
            trim(form.creatorName.value) == "" &&
            trim(form.creatorOrganization.value) == "" &&
            boundsChangedCount <= 2 &&
            trim(form.locationName.value) == "" &&
            trim(form.taxon.value) == "" &&
            trim(form.identifier.value) == "" &&
            howManySelected(form.siteValues) == 0 &&
            trim(form.startDate.value) == "" &&
            trim(form.endDate.value) == "" &&
            trim(form.namedTimescale.value) ==""
           )
        {
          alert("Please enter a value to search.");
          canSearch = false;
        }

        if (canSearch) {
          return(validateAdvancedSearchForm(form));
        }
        else {
          return false;
        }
      }
  </script>
  <script type='text/javascript' src='https://www.bing.com/api/maps/mapcontrol?callback=initialize_bing' async defer></script>
</head>

<body>
  <jsp:include page="asu-header.jsp" />
  <jsp:include page="header.jsp" />
	<div class="container">
		<div class="row">
      <div class="col">
        <ul class="nav nav-tabs" id="advancedTabs" role="tablist">
					<li class="nav-item">
						<a class="nav-link active" id="home-tab" data-toggle="tab" href="#spatial" role="tab" aria-controls="home" aria-selected="true">Spatial / Place Name</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="profile-tab" data-toggle="tab" href="#lter-sites" role="tab" aria-controls="profile" aria-selected="false">LTER Sites</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="contact-tab" data-toggle="tab" href="#subject" role="tab" aria-controls="contact" aria-selected="false">Subject</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="contact-tab" data-toggle="tab" href="#creator-org" role="tab" aria-controls="contact" aria-selected="false">Creator/Organization</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="contact-tab" data-toggle="tab" href="#temporal" role="tab" aria-controls="contact" aria-selected="false">Temporal</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="contact-tab" data-toggle="tab" href="#taxonomics" role="tab" aria-controls="contact" aria-selected="false">Taxonomics</a>
					</li>
					<li class="nav-item">
						<a class="nav-link" id="contact-tab" data-toggle="tab" href="#identifier" role="tab" aria-controls="contact" aria-selected="false">Identifier</a>
					</li>
				</ul>
        <form id="advancedSearchForm" action="./advancedSearch" method="post" name="advancedSearchForm" onsubmit="return submitRequest(this)">
          <div class="tab-content" id="advanced-search-content" style="border: 1px solid #eee; border-top: none; padding: 1em;">
            <div class="tab-pane show active" id="spatial" role="tabpanel" aria-labelledby="spatial-tab">
            <div class="row">
              <div class="col-sm-5">
                <h5 class='display-5'>Zoom/Pan the Map</h5>
                <p>Adjust the map below to limit your search results to data packages contained within the boundaries of the map.</p>
                <div id="map-canvas" style="height: 300px;"></div>
              </div>
              <div class="col-sm-2 "><h5 class="display-5">Or...</h5></div>
              <div class="col-sm-5">

                <h5 class="display-5">Manually Enter Coordinates</h5>
                <p>Enter latitude and longitude values to filter your search results</p>
                <div class="row">
                <div class="col"></div>
                <div class="col text-center">
                  <div class="form-group align-content-end">
                    <input name="northBound" onchange="boundsChanged()" size="8" type="text" value="90.0" />
                    <small class="form-text text-muted">N</small>
                  </div>
                </div>
                <div class="col"></div>
              </div>
              <div class="row align-items-center">
                <div class="col text-right">
                  <div class="form-group form-inline justify-content-end">
                    <input name="westBound" onchange="boundsChanged()" size="8" type="text" value="-180.0" />
                    <small class="form-text text-muted">&nbsp;W</small>
                  </div>
                </div>
                <div class="p-3 align-content-center"><span class="fas fa-compass fa-2x"></span></div>
                <div class="col">
                  <div class="form-group form-inline">
                    <small class="form-text text-muted">E&nbsp;</small>
                    <input name="eastBound" onchange="boundsChanged()" size="8" type="text" value="180.0" />
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col"></div>
                <div class="col text-center">
                  <div class="form-group">
                    <small class="form-text text-muted">S</small>
                    <input name="southBound" onchange="boundsChanged()" size="8" type="text" value="-90.0" />
                  </div>
                </div>
                <div class="col">
                </div>
              </div>
              <input name="boundsChangedCount" type="hidden" value="0" />
                <br />
                <div class="form-check">
                  <input name="boundaryContained" id="boundaryContained" class="form-check-input" type="checkbox" value="value1">
                  <label for="boundaryContained" class="form-check-label">Show Only Datasets Within Boundaries</label>
                </div>
                <br />
                <div class="form-group">
                  <label for="locationName">Geographic Place Name:</label>
                  <input name="locationName" id="locationName" class="form-control" type="text" />
                </div>
              </div>
            </div>



                <hr />
                <button class="btn btn-danger" name="reset" type="reset" value="Clear All">Clear All</button>
                <button class="btn btn-primary" name="submit" type="submit" value="Submit">Submit</button>
            </div>
            <div class="tab-pane" id="lter-sites" role="tabpanel" aria-labelledby="lter-sites-tab">
              <div class="row my-3">
                <div class="col">
                  <select class="select-width-auto form-control" name="siteValues" multiple="multiple" size="10">
                    <%= siteOptions %>
                  </select>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <hr />
                  <button class="btn btn-large btn-danger" name="reset" type="reset" value="Clear All">Clear All</button>
                  <input class="btn btn-large btn-primary" name="submit" type="submit" value="Submit" />
                </div>
              </div>
            </div>
            <div class="tab-pane" id="subject" role="tabpanel" aria-labelledby="subject-tab">
                  <div class="form-group row">
                    <label for="subjectValue" class="col-form-label col-sm-2" for="subjectValue">Search For:</label>
                    <div class="col-sm-10">
                      <input name="subjectValue" id="subjectValue" type="text" class="form-control" placeholder="enter search term(s)" />
                      <small id="emailHelp" class="form-text text-muted">Tip: enclose multi-word terms in quotes, e.g. 'Puerto Rico'</small>
                    </div>
                  </div>
                  <div class="form-group row">
                    <label class="col-form-label col-sm-2">Search In:</label>
                    <div class="col-sm-10">
                      <div class="form-check">
                        <input checked="checked" name="subjectField" id="subjectField1" class="form-check-input" type="radio" value="ALL" />
                        <label class="form-check-label" for="subjectField1">Subject</label>
                      </div>
                      <div class="form-check">
                        <input name="subjectField" id="subjectField2" class="form-check-input" type="radio" value="TITLE" />
                        <label class="form-check-label" for="subjectField2">Title only</label>
                      </div>
                      <div class="form-check">
                        <input name="subjectField" id="subjectField3" class="form-check-input" type="radio" value="ABSTRACT" />
                        <label class="form-check-label" for="subjectField3">Abstract only</label>
                      </div>
                      <div class="form-check">
                        <input name="subjectField" id="subjectField4" class="form-check-input" type="radio" value="KEYWORDS" />
                        <label class="form-check-label" for="subjectField4">Keywords only</label>
                      </div>
                    </div>
                  </div>

                  <div class="form-group row">
                    <label class="col-for-label col-sm-2">Automatically Add:</label>
                    <div class="col-sm-10">
                      <div class="form-check">
                        <input name="specific" id="specific-terms" type="checkbox" class="form-check-input" value="value1">
                        <label for="specific-terms" class="form-check-label">More Specific Terms</label>
                      </div>
                      <div class="form-check">
                        <input name="related" id="related-terms" type="checkbox" class="form-check-input" value="value1">
                        <label for="related-terms" class="form-check-label">Related Terms</label>
                      </div>
                    </div>
                  </div>
              <!--
              <div class="form-check form-check-inline">
                <input name="relatedSpecific" id="relatedSpecific" type="checkbox" class="for-check-input" value="value1">
                <label for="related-specific" class="form-check-label">Related/More Specific Terms</label>
              </div>
              -->
                  <div class="form-group row">
                  <label class="col-for-label col-sm-2">Also Search:</label>
                    <div class="col-sm-10">
                      <div class="form-check">
                        <input name="ecotrends" id="ecotrends" type="checkbox" class="form-check-input" value="value1">
                        <label for="ecotrends" class="form-check-label">EcoTrends Data Packages</label>
                      </div>
                      <div class="form-check">
                        <input name="landsat5" id="landsat5" type="checkbox" class="form-check-input" value="value1">
                        <label for="landsat5" class="form-check-label">Landsat5 Data Packages</label>
                      </div>
                    </div>
                  </div>

                  <hr />
                  <button class="btn btn-danger" name="reset" type="reset" value="Clear All">Clear All</button>
                  <button class="btn btn-primary" name="submit" type="submit" value="Submit">Submit</button>
            </div>
            <div class="tab-pane" id="creator-org" role="tabpanel" aria-labelledby="creator-org-tab">
              <div class="form-group">
                <label for="creatorName">Creator's Name</lable>
                <select class="form-control" name="creatorName" id="creatorName"><%= creatorOptions %></select>
              </div>
              <div class="form-group">
                <label for="creatorOrganization">Creator's Organization</label>
                <select class="form-control" name="creatorOrganization"><%= organizationOptions %></select>
              </div>
              <hr />
              <input class="btn btn-danger" name="reset" type="reset" value="Clear All" />
              <input class="btn btn-primary" name="submit" type="submit" value="Submit" />
            </div>
            <div class="tab-pane" id="temporal" role="tabpanel" aria-labelledby="temporal-tab">
              <div class="form-group row">
                <label class="col-form-label col-sm-2">Label Here:</label>
                <div class="col-sm-10">
                  <div class="form-check">
                    <input checked="checked" name="dateField" id="collection" class="form-check-input" type="radio" value="COLLECTION" />
                    <label for="collection" class="form-check-label">Collection Date</label>
                  </div>
                  <div class="form-check">
                    <input name="dateField" id="publication" type="radio" class="form-check-input" value="PUBLICATION"/>
                    <label for="publication" class="form-check-label">Publication Date</label>
                  </div>
                  <div class="form-check">
                    <input name="dateField" id="either" class="form-check-input" type="radio" value="ALL" />
                    <label for="either" class="form-check-label">Either</label>
                  </div>
                </div>
              </div>
              <div class="form-group row">
                <label class="col-for-label col-sm-2">Start Date:</label>
                <div class="col-sm-10">
                  <input name="startDate" id="startDate" class="form-control" placeholder="YYYY-MM-DD" type="date" />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-for-label col-sm-2">End Date:</label>
                <div class="col-sm-10">
                  <input name="endDate" id="endDate" class="form-control" placeholder="YYYY-MM-DD" type="date" />
                </div>
              </div>
              <div class="form-group row">
                <label class="col-for-label col-sm-2">Named Time Scale:</label>
                <div class="col-sm-10">
                  <input name="namedTimescale" id="namedTimedScale" class="form-control" type="text" >
                </div>
              </div>
              <hr />
              <input class="btn btn-danger" name="reset" type="reset" value="Clear All" />
              <input class="btn btn-primary" name="submit" type="submit" value="Submit" />
            </div>
            <div class="tab-pane" id="taxonomics" role="tabpanel" aria-labelledby="taxonomics-tab">
              <div class="form-group">
                <label for="taxon" class="col-for-label">Taxon:</label>
                <input name="taxon" id="taxon" class="form-input" type="text" />
              </div>
              <hr />
              <input class="btn btn-danger" name="reset" type="reset" value="Clear All" />
              <input class="btn btn-primary" name="submit" type="submit" value="Submit" />
            </div>
            <div class="tab-pane" id="identifier" role="tabpanel" aria-labelledby="identifier-tab">
              <p>Enter a data package identifier excluding its revision number.</p>
              <p>Examples:
              <ul>
                <li><strong>edi.1</strong></li>
                <li><strong>knb-lter-and.2719</strong></li>
                <li><strong>knb-lter-jrn.210001001</strong></li>
              </ul>
              </p>
              <!--
              <ul>
              <li>Digital Object Identifier (DOI), e.g., <strong>doi:10.6073/pasta/397e0bba0f8aeac013d01fc982a74ea8</strong></li>
              <li>Package Identifier, e.g., <strong>knb-lter-and.2719.6</strong></li>
              <li>Package Identifier, excluding its revision value, e.g., <strong>knb-lter-and.2719</strong></li>
              <li>PASTA Identifier, e.g., <strong>https://pasta.lternet.edu/package/eml/knb-lter-and/2719/6</strong></li>
              </ul>
              -->
              <br/>
              <div class="form-group">
                <label class="labelBold" for="identifier">Identifier:</label>
                <input name="identifier" id="identifier" class="form-input" type="text" />
                <small class="form-text text-muted">Please note: Only the most current revision of the data package
              will appear in the search results.</small>
                <hr />
                <input class="btn btn-danger" name="reset" type="reset" value="Clear All" />
                <input class="btn btn-primary" name="submit" type="submit" value="Submit" />
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>

  <script type="text/javascript">

    <!-- // JavaScript input validation checking code for advanced search form
    var bCancel = false;

    function validateAdvancedSearchForm(form) {
        if (bCancel)
            return true;
        else
            var formValidationResult;
            formValidationResult = validateFloat(form) &&
                                   validateFloatRange(form) &&
                                   validateDate(form);
            return (formValidationResult == 1);
    }

    function advancedSearchForm_FloatValidations () {
      this.a0 = new Array("westBound", "West Boundary must be a number.", new Function ("varName", "this.min='-180.0'; this.max='180.0';  return this[varName];"));
      this.a1 = new Array("eastBound", "East Boundary must be a number.", new Function ("varName", "this.min='-180.0'; this.max='180.0';  return this[varName];"));
      this.a2 = new Array("northBound", "North Boundary must be a number.", new Function ("varName", "this.min='-90.0'; this.max='90.0';  return this[varName];"));
      this.a3 = new Array("southBound", "South Boundary must be a number.", new Function ("varName", "this.min='-90.0'; this.max='90.0';  return this[varName];"));
    }

    function advancedSearchForm_DateValidations () {
      this.a0 = new Array("startDate", "Start Date must be a date (YYYY-MM-DD).", new Function ("varName", "this.datePattern='yyyy-MM-dd';  return this[varName];"));
      this.a1 = new Array("endDate", "End Date must be a date (YYYY-MM-DD).", new Function ("varName", "this.datePattern='yyyy-MM-dd';  return this[varName];"));
    }

    function advancedSearchForm_floatRange () {
      this.a0 = new Array("westBound", "West Boundary must be in the range -180.0 through 180.0.", new Function ("varName", "this.min='-180.0'; this.max='180.0';  return this[varName];"));
      this.a1 = new Array("eastBound", "East Boundary must be in the range -180.0 through 180.0.", new Function ("varName", "this.min='-180.0'; this.max='180.0';  return this[varName];"));
      this.a2 = new Array("northBound", "North Boundary must be in the range -90.0 through 90.0.", new Function ("varName", "this.min='-90.0'; this.max='90.0';  return this[varName];"));
      this.a3 = new Array("southBound", "South Boundary must be in the range -90.0 through 90.0.", new Function ("varName", "this.min='-90.0'; this.max='90.0';  return this[varName];"));
    }
  </script>
  <!-- End  JavaScript input validation checking code. -->
<%@ include file="bootstrap-javascript.jsp" %>
<div class="footer-container pt-5">
	<jsp:include page="asu-footer.jsp" />
</div>

</body>

</html>
