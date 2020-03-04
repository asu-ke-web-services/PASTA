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
	<div class="container-fluid asu-menu d-lg-none">
			<div id="mobile-nav-header" class="navbar-header">
				<a class="navbar-brand asu-menu" href="https://data.sustainability.asu.edu/dataportal/home.jsp">GIOS Data Portal</a>
			</div>
	</div>
	<div class="container-fluid asu-menu">
		<div class="container">
			<nav class="navbar d-none d-lg-block navbar-expand-lg navbar-dark asu-menu" id="gios-nav">
				<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav mr-auto">
						<li class="nav-item home-icon">
							<a class="nav-link" href="https://sustainability.asu.edu/"><span class="fas fa-home"></span></a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/people/">People</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/programs/">Programs</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/research/">Research</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/education/">Education</a>
						</li>
						<li class="nav-item active">
							<a class="nav-link" href="https://data.sustainability.asu.edu/dataportal/home.jsp">Data</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/partnerships/">Partnerships</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/news/">News</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/events/">Events</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="https://sustainability.asu.edu/about/">About</a>
						</li>
				</div>
			</nav>
		</div>
	</div>
</header>
<div class="pt-5"> <!-- generic wrapper with Bootstrap padding class to push all content down from the main menu --->