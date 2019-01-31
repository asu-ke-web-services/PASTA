<!--
  ~ Copyright 2011-2014 the University of New Mexico.
  ~
  ~ This work was supported by National Science Foundation Cooperative
  ~ Agreements #DEB-0832652 and #DEB-0936498.
  ~
  ~ Licensed under the Apache License, Version 2.0 (the "License");
  ~ you may not use this file except in compliance with the License.
  ~ You may obtain a copy of the License at
  ~ http://www.apache.org/licenses/LICENSE-2.0.
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
  ~ either express or implied. See the License for the specific
  ~ language governing permissions and limitations under the License.
  -->

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.common.CalendarUtility" %>
<%@ page import="edu.lternet.pasta.portal.ConfigurationListener" %>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>
<%@ page import="edu.lternet.pasta.portal.PastaStatistics"%>
<%@ page import="edu.lternet.pasta.portal.search.LTERTerms"%>
<%@ page import="edu.lternet.pasta.portal.statistics.GrowthStats"%>

<%
	final String pageTitle = "Home";
	final String titleText = DataPortalServlet.getTitleText(pageTitle);
	session.setAttribute("menuid", "home");

	String uid = (String) session.getAttribute("uid");
	if (uid == null || uid.isEmpty()) {
		uid = "public";
	}

    final String downtime = (String) ConfigurationListener.getOptions().getProperty("dataportal.downtime.dayOfWeek");
    HttpSession httpSession = request.getSession();
    String downtimeHTML = "";

    if (downtime != null && !downtime.isEmpty()) {
        String today = CalendarUtility.todaysDayOfWeek();
        if (today != null && today.equalsIgnoreCase(downtime)) {
            StringBuilder sb = new StringBuilder();
            sb.append(String.format("The Data Portal and PASTA+ services will be unavailable on %s evening from 7-9 pm Mountain Time for scheduled weekly maintenance.",
                                    downtime));
            downtimeHTML = String.format("<div class=\"alert alert-warning mt-4\" role=\"alert\"<em>Please Note: </em>%s</div>",
                                         sb.toString());
        }
    }
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

<div class="container">
	<div class="row mt-3">
		<div class="col-sm">

			<%= downtimeHTML %>
			<h2>Welcome to the GIOS Data Portal</h2>

			<p>Data are one of the most valuable products of the
			Long Term Ecological Research (LTER) Network. Data and
			metadata derived from publicly funded research in the
			U.S. LTER Network are made available online with as
			few restrictions as possible, on a non-discriminatory
			basis. In return, the LTER Network expects data users
			to <em>act ethically</em> by contacting the
			investigator prior to the use of data for publication.
			</p>

			<p>The LTER Network Information System Data Portal contains
			ecological data packages contributed by past and present
			LTER sites. Please review the
			<a class="searchsubcat" href="https://lternet.edu/data-access-policy/" target="_blank">
			LTER Network Data Access Policy</a> before downloading any data product.
			We request that you cite data sources in your published
			and unpublished works whenever possible. Digital object
			identifiers (DOI) are provided for each dataset to facilitate
			citation. </p>
			<!--
			<p>Voluntary registration on this site will allow us
			to notify you of updates to data and metadata of interest
			and of corrections made to data. In addition, your validated
			login will gain you access to even more data where contributors
			have asked for additional information on use.
			<span name="New user registration for non-LTER members coming soon!"
			class="tooltip">Register now</span>!
			</p>
			-->
			<p>LTER Network scientists make every effort to release
			data in a timely fashion and with attention to accurate,
			well-designed and well-documented data. To understand
			data fully, please read the associated metadata and
			contact data providers if you have any questions. The
			LTER Network is not responsible for misinterpretation
			of data resulting from failure to consult metadata or
			data providers.</p>
		</div>
	</div>

	<div class="jumbotron">
		<h1 class="display-4">Search GIOS Data</h1>
		<p class="lead">Search through our vast reserve of high-quality, royalty-free data!</p>
		<hr />
		<form class="form-inline" id="searchform" action="./simpleSearch" method="post">
			<label class="sr-only" for="lterterms">Search For: </label>
			<input type="text" name="terms" class="form-control mb-2 mr-sm-2" id="lterterms" placeholder="Search Term(s)">
			<button type="submit" class="btn btn-primary mb-2">Submit</button>
		</form>
		<hr />
		<p>Looking for something more specific? Try the <a href="advancedSearch.jsp">Advanced Search</a></p>
	</div>

</div>

<div class="footer-container pt-5">
	<jsp:include page="asu-footer.jsp" />
</div>


</div>
<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
