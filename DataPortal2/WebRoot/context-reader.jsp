<%
/* Get values from our context file */
	ServletContext sc = getServletContext();
    final String siteName = sc.getInitParameter("siteName");
    final String siteID = sc.getInitParameter("siteID");
    final String sitePrefix = sc.getInitParameter("sitePrefix");
    final String siteAsuTitle = sc.getInitParameter("siteAsuTitle");
    final String siteAsuTitleLink = sc.getInitParameter("siteAsuTitleLink");
    final String siteAsuSubtitle = sc.getInitParameter("siteAsuSubtitle");
    final String siteAsuSubtitleLink = sc.getInitParameter("siteAsuSubtitleLink");

    /* construct strings for includes. We are expecting inlcudes in a folder with the same
    name as our sitePrefix, and the filename to also start withe file filePrefix. If we are
    loading a header, for example, we might construct a string like: "caplter/caplterHeader.jsp" */

    final String menuInclude = String.format("%s/%s%s", sitePrefix, sitePrefix, "Header.jsp");
    final String bigFooterInclude = String.format("%s/%s%s", sitePrefix, sitePrefix, "BigFooter.jsp");
    final String contentInclude = String.format("%s/%s%s", sitePrefix, sitePrefix, "Content.jsp");
%>