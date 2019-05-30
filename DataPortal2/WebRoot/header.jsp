<%@ page import="edu.lternet.pasta.portal.Tooltip" %>
<%@ page import="edu.lternet.pasta.client.DataPackageManagerClient" %>

<!-- Header -->
<%
	HttpSession httpSession = request.getSession();
	String uid = (String) httpSession.getAttribute("uid");
	String identity = null;
	String uname = null;
	String welcomeBack = null;

	if ((uid == null) || (uid.equals(""))) {
		identity = "<a href='./login.jsp'>Login</a>";
		uname = "";
		welcomeBack = "";
		uid = "public";
	}
	else {
        identity = "<a id=\"login\" href=\"./logout\">Log Out</a>";
		uname = uid;
		welcomeBack = "Welcome Back";
	}

	DataPackageManagerClient dpmc = new DataPackageManagerClient(uid);
	String pastaHost = dpmc.getPastaHost();
	String tierHTML = "";
	if (pastaHost.startsWith("pasta-d") ||
	  pastaHost.startsWith("localhost")
	) {
	  tierHTML = "<font color='darkorange'>Development Environment</font>";
	}
	else if (pastaHost.startsWith("pasta-s")) {
	  tierHTML = "<font color='darkorange'>Staging Environment</font>";
	}

  final String currentClass = " class='current-menu-item current_page_item'";
  String dataClass = "";
  String helpClass = "";
  String homeClass = "";
  String loginClass = "";
  String toolsClass = "";
  String requestURI = request.getRequestURI();
  String pageName = requestURI.substring(requestURI.lastIndexOf("/") + 1,
                                        requestURI.lastIndexOf(".")
                                      );
  if (pageName.equals("browse") ||
          pageName.equals("packageIdentifier") ||
          pageName.equals("advancedSearch") ||
          pageName.equals("savedData")
          ) {
    dataClass = currentClass;
  }
  else if (pageName.equals("help") ||
          	pageName.equals("resources")
          ) {
    helpClass = currentClass;
  }
  else if (pageName.equals("home")) {
    homeClass = currentClass;
  }
  else if (
					pageName.equals("previewMetadata") ||
					pageName.equals("dataPackageEvaluate") ||
					pageName.equals("harvester") ||
					pageName.equals("harvestReport") ||
					//pageName.equals("dataPackageDelete") ||
					pageName.equals("eventSubscribe") ||
					pageName.equals("provenanceGenerator") ||
					pageName.equals("dataPackageAudit") ||
					pageName.equals("auditReport")
          ) {
    toolsClass = currentClass;
  }
  else if (pageName.equals("login")) {
    loginClass = currentClass;
  }
%>
<header role="banner">
	<!-- Bootstrap NavBar -->
	<div class="container-fluid bg-dark">
		<div class="container">
			<nav class="navbar navbar-expand-lg navbar-dark bg-dark" id="gios-nav">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item home-icon">
							<a class="nav-link" href="home.jsp"><span class="fas fa-home"></span></a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="advancedSearch.jsp">Advanced Search</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="about.jsp">About</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="resources.jsp">Resources</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="contact.jsp">Contact</a>
						</li>
				</div>
			</nav>
		</div>
	</div>

	<div class="container-fluid"  style="background-color: #eee;">
		<div class="container">
			<nav class="navbar navbar-expand-lg navbar-light sticky-top" id="portal-menu">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse justify-content-end" id="navbarSupportedContent">
					<form class="form-inline my-2 my-lg-0" action="./simpleSearch" method="post" _lpchecked="1">
						<input class="form-control mr-sm-2" type="search" name="terms" id="navBarTerms" placeholder="Search GIOS Data" aria-label="Search">
						<button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
					</form>
				</div>
			</nav>
		</div>
	</div>
	<!-- end Bootstrap NavBar -->
</header>
<div class="pt-5"> <!-- generic wrapper with Bootstrap padding class to push all content down from the main menu --->