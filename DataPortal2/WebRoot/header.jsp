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
	<div class="container-fluid bg-dark mb-4">
	<div class="container">
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="home.jsp"><span class="fas fa-home"></span></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item">
					<a class="nav-link" href="advancedSearch.jsp">Advanced Search</a>
				</li>
				<!--
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						Browse
					</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="browse.jsp">Keyword or LTER Site</a>
						<a class="dropdown-item" href="scopebrowse">Package Identifier</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="savedDataServlet">Your Data Shelf</a>
					</div>
				</li>
				-->
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						Help
					</a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<a class="dropdown-item" href="contact.jsp">Contact Us</a>
						<a class="dropdown-item" href="resources.jsp">Resources</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="about.jsp">About Us</a>
					</div>
				</li>
			</ul>
			<form class="form-inline my-2 my-lg-0" action="./simpleSearch" method="post" _lpchecked="1">
				<input class="form-control mr-sm-2" type="search" name="terms" id="navBarTerms" placeholder="Search GIOS Data" aria-label="Search">
				<button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
			</form>

		</div>
		</div>
		</div>
	</nav>
	<!-- end Bootstrap NavBar -->
</header>
