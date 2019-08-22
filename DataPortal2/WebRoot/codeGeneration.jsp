<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
  final String pageTitle = "Code Generation";
  final String titleText = DataPortalServlet.getTitleText(pageTitle);

  String filename = (String) request.getAttribute("filename");
  String statisticalFileType = (String) request.getAttribute("statisticalFileType");
  String statisticalPackageName = (String) request.getAttribute("statisticalPackageName");
  String packageId = (String) request.getAttribute("packageId");
  String mapBrowseURL = (String) request.getAttribute("mapBrowseURL");
  String instructions = (String) request.getAttribute("instructions");
  String programCode = (String) request.getAttribute("programCode");
  session.setAttribute("programCode", programCode);
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
		<div class="container main-content">
			<div class="row">
				<div class="col">
					<h2><%= statisticalPackageName %> Code</h2>
					<table class="table table-bordered">
						<tr>
							<th scope="row" width="30%">Package ID:</th>
							<td><a href="<%= mapBrowseURL %>"><%= packageId %></a></td>
						</tr>
						<tr>
							<th scope="row">File Download:</th>
							<td><a href="codegenerationdownload?filename=<%= filename %>"><span class="fa fa-download"></span> <%= filename %></a></td>
						</tr>
						<tr>
							<th scope="row">Instructions:</th>
							<td><%= instructions %></td>
						</tr>
						<tr>
							<th scope="row">
								Code:
							</th>

							<td>
								<textarea id="programCodeTextArea" name="programCodeTextArea" cols="90" rows="12">
									<%= programCode %>
								</textarea>
								<btn data-clipboard-target="#programCodeTextArea" class="btn btn-secondary"><span class="fas fa-copy"></span> Copy Code to Clipboard</btn>
								<span id="copy-confirm" class="collapse text-success"><span class="fa fa-check"></span> Copy Successful!</span>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="footer mt-5">
			<jsp:include page="asu-big-footer.jsp" />
			<jsp:include page="asu-footer.jsp" />
		</div>
		<%@ include file="bootstrap-javascript.jsp" %>

		<script>
			var clipboard = new Clipboard('.btn');

			clipboard.on('success', function(e) {
				$("#copy-confirm").collapse('show');
				window.setTimeout( function() {$("#copy-confirm").collapse('hide')}, 2000 );
			});

			clipboard.on('error', function(e) {
				console.log(e);
			});
    	</script>
	</body>
</html>