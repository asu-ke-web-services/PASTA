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
            downtimeHTML = String.format("<div class=\"alert alert-warning mt-4\" role=\"alert\"<em>Please Note: </em>%s</div>", sb.toString());
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

<div id="main-wrapper">
	<div class="container main-content" style="margin-top: -3rem!important;">

		<div class="row pt-5">
			<div class="hero-text col-sm-12 col-md-8 col-lg-6">
				<h1>GIOS Data Portal</h1>
				<p>Search for datasets from research conducted across the globe by GIOS scientists and scholars.</p>
				<form class="form-inline my-2 my-lg-0 d-inline" action="./simpleSearch" method="post" _lpchecked="1">
					<input class="form-control mr-sm-2" type="search" name="terms" id="navBarTerms" placeholder="Search The Portal" aria-label="Search">
					<button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
					<span class="navbar-text pl-3"><a href="advancedSearch.jsp">Advanced Search</a></span>
				</form>
			</div>
		</div>

	</div>


</div>
<div class="container main-content" style="min-height: 700px;">

	<div class="row p-5">
		<div class="col" style="font-weight: 300; font-size: 18px;">
			<h1>About The GIOS Data Portal</h1>

			<img class="float-right ml-3" src="images/portal-graphic-01.svg" alt="placeholder" width="420" height="420">
			<p>The GIOS Data Portal is the main resource for the discovery and download of datasets created by GIOS scientists and scholars. With the GIOS Data Portal you can:</p>
				<ul>
					<li>Quickly search for datasets based on keywords or author names</li>
					<li>Create more granular searches using the <a href="advancedSearch.jsp">advanced search</a> features</li>
					<li>Easily find abstracts, proper citations, geographical information, and more</li>
					<li>Download datasets and associated metadata</li>
					<li>Generate code to use datasets in Python, R, and other languages</li>
				</ul>

			<p>The GIOS Data Portal is a modified version of <a href="https://portal.edirepository.org/nis/home.jsp" target="_blank">the EDI Data Portal</a> - it is powered by the same technology, and searches the same EDI database, but is filtered to only include datasets that originate from GIOS scientists and scholars.
		</div>
	</div>

</div>

</div>
<div class="footer">
	<jsp:include page="asu-big-footer.jsp" />
	<jsp:include page="asu-footer.jsp" />
</div>


</div>
	<%@ include file="bootstrap-javascript.jsp" %>
</body>

</html>
