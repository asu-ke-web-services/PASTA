<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
	final String pageTitle = "Contact Us";
	final String titleText = DataPortalServlet.getTitleText(pageTitle);
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<title><%= titleText %></title>
	<!-- common <head> tag elements -->
	<%@ include file="common-head.jsp" %>
</head>

<body>

<jsp:include page="asu-header.jsp" />
<jsp:include page="header.jsp" />

<div class="row-fluid ">
	<div>
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="span12">
							<div class="recent_title">
								<h2>Contact Us</h2>
							</div>
						</div>
					</div>
						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->
								<h3>People</h3>
								<ul>
									<li><a class="searchsubcat" href="https://environmentaldatainitiative.org/team/corinna-gries/">Corinna Gries</a>,
										Principal Investigator, University of Wisconsin
									</li>
									<li><a class="searchsubcat" href="https://environmentaldatainitiative.org/team/mark-servilla-pi/">Mark Servilla</a>,
										Principal Investigator, University of New Mexico
									</li>
								</ul>
								<h3>E-Mail Address</h3>
								<ul class="no-list-style">
									<li><a href="mailto:support@environmentaldatainitiative.org">support@environmentaldatainitiative.org</a></li>
								</ul>
								<h3>Mailing Address</h3>
								<ul class="no-list-style">
									<li>Environmental Data Initiative<br />
									Center for Limnology<br />
									University of Wisconsin<br />
									Madison, WI 53706</li>
								</ul>
								<!-- /Content --></div>
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
