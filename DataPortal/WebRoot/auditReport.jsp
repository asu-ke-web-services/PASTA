<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="edu.lternet.pasta.portal.DataPortalServlet"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName()
	    + ":" + request.getServerPort() + path + "/";

	HttpSession httpSession = request.getSession();

	String uid = (String) httpSession.getAttribute("uid");

	if (uid == null || uid.isEmpty()) {
		request.setAttribute("from", "./auditReport.jsp");
		String loginWarning = DataPortalServlet.getLoginWarning();
		request.setAttribute("message", loginWarning);
		RequestDispatcher requestDispatcher = request
		    .getRequestDispatcher("./login.jsp");
		requestDispatcher.forward(request, response);
	}

	String reportMessage = (String) request.getAttribute("reportMessage");
	String type = (String) request.getAttribute("type");

	if (type == null) {
		type = "";
	} else {
		type = "class=\"" + type + "\"";
	}
%>

<!doctype html>
<html>
<head>
<base href="<%=basePath%>">

<title>NIS Data Portal - Audit Report Viewer</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">

<link rel="stylesheet" type="text/css" href="./css/lter-nis.css">

<jsp:include page="/WEB-INF/jsp/javascript.jsp" />

</head>

<body>

	<div class="wrapper">

		<jsp:include page="/WEB-INF/jsp/head.jsp" />
		<jsp:include page="/WEB-INF/jsp/menuTopLevel.jsp" />

		<div class="content">

			<h2 align="center">Audit Report Viewer</h2>


			<fieldset>
				<legend>Filtered Audit Report</legend>

				<p>Review a PASTA audit report by selecting the appropriate
				   filters or see all entries by leaving the defaults, then
				   select "submit".</p>

				<form id="auditReport" name="auditReport" method="post"
					action="./auditReport">
					<div class="section">
						<table align="left" cellpadding="4em">
							<tbody>
								<tr>
									<td align="right">Date-Time Range:</td>
									<td>
									   <label for="begin">Begin </label>
									   <input type="text" name="begin" size="25px" placeholder="YYYY-MM-DDTHH:MM:SS" />
									</td>
									<td>
									   <label for="end">End </label>
									   <input type="text" name="end" size="25px" placeholder="YYYY-MM-DDTHH:MM:SS" />
									</td>
								</tr>
								<tr>
									<td align="left">Category Status:</td>
									<td colspan="2">
									   <label for="debug">Debug</label>
									   <input type="checkbox" name="debug" value="debug" />
									   <label for="info">Info</label>
									   <input type="checkbox" name="info" value="info" />
									   <label for="warn">Warn</label>
									   <input type="checkbox" name="warn" value="warn" />
									   <label for="error">Error</label>
									   <input type="checkbox" name="error" value="error" />
									</td>
									<td></td>
								</tr>
								<tr>
									<td align="right">HTTP Code:</td>
									<td>
									   <input type="text" name="code" size="10px" />
									</td>
									<td></td>
								</tr>
								<tr>
									<td align="right">User Name:</td>
									<td>
									   <input type="text" name="userId"	size="25px" />
									</td>
									<td></td>
								</tr>
								<tr>
									<td align="right">Group:</td>
									<td>
									   <input type="text" name="group" size="25px" />
								    </td>
								    <td></td>
								</tr>
								<tr>
									<td></td>
									<td>
									   <input type="submit" name="submit" value="submit" />
        							   <input type="reset" name="reset" value="reset" />
									</td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- section -->
					<%
						if (reportMessage != null && type.equals("class=\"warning\"")) {
							out.println("<div class=\"section\">\n");
							out.println("<table align=\"left\" cellpadding=\"4em\">\n");
							out.println("<tbody>\n");
							out.println("<tr>\n");
							out.println("<td " + type + ">\n");
							out.println(reportMessage + "\n");
							out.println("</td>\n");
							out.println("</tr>\n");
							out.println("</tbody>\n");
							out.println("</table>\n");
						}
					%>

				</form>

			</fieldset>

			<%
				if (reportMessage != null && type.equals("class=\"info\"")) {
					out.println(reportMessage);
				}
			%>

		</div>
		<!-- end of content -->

		<jsp:include page="/WEB-INF/jsp/foot.jsp" />

	</div>
	<!-- end of wrapper -->

</body>
</html>
