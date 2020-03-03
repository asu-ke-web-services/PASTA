<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.ConfigurationListener"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.Tooltip" %>
<%@ page import="edu.lternet.pasta.portal.search.LTERSite" %>
<%@ page import="edu.lternet.pasta.portal.search.AuthorSearch" %>

<%@ include file="context-reader.jsp" %>

<%
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
        <jsp:include page="common-head.jsp">
            <jsp:param name="siteName" value="<%= siteName %>" />
        </jsp:include>

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
    <jsp:include page="asu-header.jsp">
        <jsp:param name="siteAsuTitle" value="<%= siteAsuTitle %>" />
        <jsp:param name="siteAsuSubtitle" value="<%= siteAsuSubtitle %>" />
        <jsp:param name="siteAsuTitleLink" value="<%= siteAsuTitleLink %>" />
        <jsp:param name="siteAsuSubtitleLink" value="<%= siteAsuSubtitleLink %>" />
    </jsp:include>
  <jsp:include page="<%= menuInclude %>" flush="true" />
	<div class="container main-content">
    <h3>Advanced Search</h3>
    <hr class="mb-3" />
    <form id="advancedSearchForm" action="./advancedSearch" method="post" name="advancedSearchForm" onsubmit="return submitRequest(this)">

      <div class="row">
          <div class="col-3" style="border-right: 1px solid #eee;">
            <h4>Subject</h4>
            <p class="mt-3"><small class="text-muted">A <strong>full search</strong> will look for your keyword(s) in the title, abstract, keywords, and author fields. You can optionally restrict your search to any single field.</small></p>

            <p class="mt-3"><small class="text-muted"><span class="fas fa-info-circle"></span> You can expand your search by automatically including more specific, or related, terms from the <a href="http://vocab.lternet.edu/vocab/vocab/index.php" target="_blank">LTER Controlled Vocabulary</a>.</small></p>
          </div>
          <div class="col">
            <div class="form-group row">
              <label for="subjectValue" class="col-form-label col-sm-3" for="subjectValue">Search For:</label>
              <div class="col-sm-9">
                <input name="subjectValue" id="subjectValue" type="text" class="form-control" placeholder="enter search term(s)" />
                <small id="emailHelp" class="form-text text-muted">Tip: enclose multi-word terms in quotes, e.g. 'Puerto Rico'</small>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-form-label col-sm-3">Search In:</label>
              <div class="col-sm-9">
                <div class="form-check">
                  <input checked="checked" name="subjectField" id="subjectField1" class="form-check-input" type="radio" value="ALL" />
                  <label class="form-check-label" for="subjectField1">Full Search</label>
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
                <div class="form-check">
                  <input name="subjectField" id="subjectField5" class="form-check-input" type="radio" value="CREATOR" />
                  <label class="form-check-label" for="subjectField5">Author only</label>
                </div>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-for-label col-sm-3">Also Include:</label>
              <div class="col-sm-9">
                <div class="form-check">
                  <input name="specific" id="specific-terms" type="checkbox" class="form-check-input" value="value1">
                  <label for="specific-terms" class="form-check-label">More Specific Terms </label>
                </div>
                <div class="form-check">
                  <input name="related" id="related-terms" type="checkbox" class="form-check-input" value="value1">
                  <label for="related-terms" class="form-check-label">Related Terms </label>
                </div>
                <div class="form-check"  style="margin-left: 2em;">
                  <input name="relatedSpecific" id="relatedSpecific" type="checkbox" class="form-check-input" value="value1">
                  <label for="related-specific" class="form-check-label"><small class="text-muted">Also Include More Specific Versions of Related Terms </small></label>
                </div>
              </div>
            </div>
            <div class="form-group row">
              <label class="col-for-label col-sm-3">Also Search:</label>
              <div class="col-sm-9">
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
          </div>
      </div>

      <hr />

      <!--
      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Sites</h4>
        </div>
        <div class="col">
          <select class="select-width-auto form-control" name="siteValues" multiple="multiple" size="10">
            <%= siteOptions %>
          </select>
        </div>
      </div>
      <hr />
      -->
      <!--
      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Creator</h4>
        </div>
        <div class="col">
          <div class="form-group">
            <label for="creatorName">Creator's Name</lable>
            <select class="form-control" name="creatorName" id="creatorName"><%= creatorOptions %></select>
          </div>
          <div class="form-group">
            <label for="creatorOrganization">Creator's Organization</label>
            <select class="form-control" name="creatorOrganization"><%= organizationOptions %></select>
          </div>
        </div>
      </div>
      <hr />
      -->

      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Temporal</h4>
        </div>
        <div class="col">
          <div class="form-group row">
            <label class="col-form-label col-sm-3">Search:</label>
            <div class="col-sm-9">
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
            <label class="col-for-label col-sm-3">Start Date:</label>
            <div class="col-sm-9">
              <input name="startDate" id="startDate" class="form-control" placeholder="YYYY-MM-DD" type="date" />
            </div>
          </div>
          <div class="form-group row">
            <label class="col-for-label col-sm-3">End Date:</label>
            <div class="col-sm-9">
              <input name="endDate" id="endDate" class="form-control" placeholder="YYYY-MM-DD" type="date" />
            </div>
          </div>
          <div class="form-group row">
            <label class="col-for-label col-sm-3">Named Time Scale:</label>
            <div class="col-sm-9">
              <input name="namedTimescale" id="namedTimedScale" class="form-control" type="text" >
            </div>
          </div>
        </div>
      </div>

      <hr />

      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Taxonomic</h4>
        </div>
        <div class="col">
          <div class="form-group">
            <label for="taxon" class="col-for-label">Taxon:</label>
            <input name="taxon" id="taxon" class="form-control" type="text" />
          </div>
        </div>
      </div>

      <hr />

      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Identifier</h4>
          <p><small class="text-muted">Enter a data package identifier <b>excluding its revision number</b>. Examples:</p>
            <ul>
              <li>edi.1</li>
              <li>knb-lter-and.2719</li>
              <li>knb-lter-jrn.210001001</li>
            </ul>
          </small></p>
        </div>
        <div class="col">
          <div class="row">
            <div class="col">
              <div class="form-group">
                <label class="labelBold" for="identifier">Identifier:</label>
                <input name="identifier" id="identifier" class="form-control" type="text" />
                <small class="form-text text-muted">Please note: Only the most current revision of the data package
              will appear in the search results.</small>
              </div>
            </div>
            <div class="col">
            </div>
          </div>
          <!--
          <ul>
          <li>Digital Object Identifier (DOI), e.g., <strong>doi:10.6073/pasta/397e0bba0f8aeac013d01fc982a74ea8</strong></li>
          <li>Package Identifier, e.g., <strong>knb-lter-and.2719.6</strong></li>
          <li>Package Identifier, excluding its revision value, e.g., <strong>knb-lter-and.2719</strong></li>
          <li>PASTA Identifier, e.g., <strong>https://pasta.lternet.edu/package/eml/knb-lter-and/2719/6</strong></li>
          </ul>
          -->
        </div>
      </div>

      <hr />

      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Geographic</h4>
          <p><small class="text-muted">Use the map, or the input fields, to set a geographical boundary for your search.</small></p>
        </div>
        <div class="col">
          <!-- map grid top row -->
          <div class="row">
            <div class="col"><!--upper left --></div>
            <div class="col text-center">
              <div class="form-group align-content-end">
                <input name="northBound" onchange="boundsChanged()" size="8" type="text" value="90.0" />
                <!-- <small class="form-text text-muted">N</small> -->
              </div>
            </div>
            <div class="col"><!-- upper-right --></div>
          </div>
          <!-- map grid center row -->
          <div class="row align-items-center">
              <div class="col-2 mr-3">
                <div class="row justify-content-end">
                  <div class="form-group form-inline">
                    <input name="westBound" onchange="boundsChanged()" size="8" type="text" value="-180.0" />
                  <!-- <small class="form-text text-muted">&nbsp;W</small> -->
                </div>
              </div>
            </div>
            <div class="col mb-3" id="map-canvas" style="height: 300px;"><!-- map here --></div>
            <div class="col-2">
              <div class="form-group form-inline">
                <!-- <small class="form-text text-muted">E&nbsp;</small> -->
                <input name="eastBound" onchange="boundsChanged()" size="8" type="text" value="180.0" />
              </div>
            </div>
          </div>
          <!-- map grid bottom row -->
          <div class="row">
            <div class="col"><!-- lower-left --></div>
            <div class="col text-center">
              <div class="form-group">
                <!-- <small class="form-text text-muted">S</small> -->
                <input name="southBound" onchange="boundsChanged()" size="8" type="text" value="-90.0" />
              </div>
            </div>
            <div class="col"><!-- lower-right --></div>
          </div>

          <div class="row">
            <div class="col-2"></div>
            <div class="col">
              <div class="form-group text-center">
                <input name="boundsChangedCount" type="hidden" value="0" />
                <div class="form-check">
                  <input name="boundaryContained" id="boundaryContained" class="form-check-input" type="checkbox" value="value1">
                  <label for="boundaryContained" class="form-check-label">Show Only Datasets Within These Boundaries</label>
                </div>
              </div>
            </div>
            <div class="col-2"></div>
          </div>
        </div>
      </div>

      <hr />

      <div class="row">
        <div class="col-3" style="border-right: 1px solid #eee;">
          <h4>Place Name</h4>
        </div>
        <div class="col">
          <div class="form-group">
            <label for="locationName">Geographic Place Name:</label>
            <input name="locationName" id="locationName" class="form-control" type="text" />
          </div>
        </div>
      </div>

      <hr />


      <!-- submit/clear buttons -->
      <div class="row">
        <div class="col-3"></div>
        <div class="col">
          <input class="btn btn-secondary" name="reset" type="reset" value="Clear All" />
          <input class="btn btn-primary" name="submit" type="submit" value="Submit" />
        </div>
      </div>
    </form>

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
<script>
  $('#relatedSpecific').change( function() {
    if($(this).prop('checked')) {
      $('#related-terms').prop('checked', true);
      $('#specific-terms').prop('checked', true);
    }
  });

  $('#related-terms').change( function()  {
    if(!$(this).prop('checked')) {
      $('#relatedSpecific').prop('checked', false);
    }
  });
</script>
<div class="footer mt-5">
  <jsp:include page="<%= bigFooterInclude %>" />
	<jsp:include page="asu-footer.jsp" />
</div>

</body>

</html>
