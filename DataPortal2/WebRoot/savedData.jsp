<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet" %>

<%
  final String pageTitle = "Your Data Shelf";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);
  String path = request.getContextPath();
  String basePath = request.getScheme() + "://" + request.getServerName()
      + ":" + request.getServerPort() + path + "/";

	String uid = (String) session.getAttribute("uid");

	if (uid == null || uid.isEmpty()) {
		request.setAttribute("from", "./savedData.jsp");
		String loginWarning = DataPortalServlet.getLoginWarning();
		request.setAttribute("message", loginWarning);
		RequestDispatcher requestDispatcher = request.getRequestDispatcher("./login.jsp");
		requestDispatcher.forward(request, response);
	}

  String searchResult = (String) request.getAttribute("searchresult");

  if (searchResult == null)
    searchResult = "";
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

  <div class="row-fluid ">
		<div class="container">
			<div class="row-fluid distance_1">
				<div class="box_shadow box_layout">
					<div class="row-fluid">
						<div class="span12">
							<div class="recent_title">
								<h2>Your Data Shelf</h2>
							</div>
							<span class="row-fluid separator_border"></span>
						</div>

						<div class="row-fluid">
							<div class="span12">
								<!-- Content -->
			          <%=searchResult%>
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
