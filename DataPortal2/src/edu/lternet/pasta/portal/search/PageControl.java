package edu.lternet.pasta.portal.search;


public class PageControl {
	
	/*
	 * Class variables
	 */
	
	
	/*
	 * Instance variables
	 */
	
	int currentPage = 1;
	int numFound;	
	int rowsPerPage;
	int start;
	int pageRange = 5; // View +/- pages from the current page
	
	/*
	 * Constructor
	 */
	
	public PageControl(int numFound, int start, int rowsPerPage) {
		this.numFound = numFound;
		this.rowsPerPage = rowsPerPage;
		setStart(start);
	}
	
	
	/*
	 * Class methods
	 */
	
	
	public static void main(String[] args) {
		int numberFound = new Integer(args[0]);
		int rowsPerPage = new Integer(args[1]);
		int start = new Integer(args[2]);
		
		PageControl pageControl = new PageControl(numberFound, start, rowsPerPage);
		String html = pageControl.composePageBody();
		System.out.println(html);
	}
	
	
	/*
	 * Intance methods
	 */
	
	private String composeStartTag(int linkStart) {
		String href = String.format("simpleSearch?start=%d&rows=%d", linkStart, rowsPerPage);
		String aStartTag = String.format("<a class='searchsubcat' href='%s'>", href);
		return aStartTag;		
	}
	
	
	public String composePageHeader() {
		String html = "";

		if (numFound > 0) {
			String plural = numFound > 1 ? "s" : "";
			int lo = ((currentPage - 1) * rowsPerPage) + 1;
			int hi = lo + rowsPerPage - 1;
			if (hi > numFound)
				hi = numFound;
			StringBuilder sb = new StringBuilder("<p>");
			sb.append(String.format(
					"Displaying %d-%d of %d matching data package%s", lo, hi,
					numFound, plural));
			sb.append("</p>");

		html = sb.toString();
		}
		
		return html;
	}
	
	
	public String composePageBody() {
		String html = "";
		int max = highestPage();
		
		if (max > 1) {
		StringBuilder sb = new StringBuilder("<p align='center'>");
		
		if (currentPage > 1) {
			int linkStart = 0;
			String aStartTag = composeStartTag(linkStart);
			sb.append(aStartTag);
		}
		sb.append("&lt;&lt;  ");
		if (currentPage > 1) {
			sb.append("</a>");
		}
		
		if (currentPage > 1) {
			int linkStart = (currentPage - 2) * rowsPerPage;
			String aStartTag = composeStartTag(linkStart);
			sb.append(aStartTag);
		}
		sb.append("&lt;  ");
		if (currentPage > 1) {
			sb.append("</a>");
		}
		
		for (int i = 1; i <= max; i++) {
			if (isWithinPageRange(i)) {
			String aStartTag = null;
			String aEndTag = null;
			if (i == currentPage) {
				aStartTag = "";
				aEndTag = "";
			}
			else {
				int linkStart = (i - 1) * rowsPerPage;
				aStartTag = composeStartTag(linkStart);
				aEndTag = "</a>";
			}
			sb.append(String.format("%s%d%s ", aStartTag, i, aEndTag));
			}
		}
		
		if (currentPage < max) {
			int linkStart = currentPage * rowsPerPage;
			String aStartTag = composeStartTag(linkStart);
			sb.append(aStartTag);
		}
		sb.append(" &gt;  ");
		if (currentPage < max) {
			sb.append("</a>");
		}
		
		if (currentPage < max) {
			int linkStart = (max - 1) * rowsPerPage;
			String aStartTag = composeStartTag(linkStart);
			sb.append(aStartTag);
		}
		sb.append("  &gt;&gt;  ");
		if (currentPage < max) {
			sb.append("</a>");
		}
		
		sb.append("</p>");
		html = sb.toString();
		}
		
		return html;
	}

	
	public int getNumFound() {
		return numFound;
	}

	
	public int getRecordsPerPage() {
		return rowsPerPage;
	}

	
	public int getCurrentPage() {
		return currentPage;
	}
	
	
	public int getStartRow() {
		int startRow = 0;
		
		startRow = (currentPage - 1) * rowsPerPage;
		
		return startRow;
	}
	
	
	public int highestPage() {
		int highestPage = 0;
		
		highestPage = numFound / rowsPerPage;
		if (numFound % rowsPerPage > 0) highestPage++;
		
		return highestPage;
	}
	
	
	/*
	 * Does the current page fall within the display range?
	 */
	private boolean isWithinPageRange(int pageNumber) {
		boolean withinRange = false;
		int pageFulcrum = currentPage;  // center page display around the page fulcrum
		int max = highestPage();
		
		if (currentPage < (pageRange + 1)) {
			pageFulcrum = (pageRange + 1);
		}
		else if ((currentPage + pageRange) > max) {
			pageFulcrum = max - pageRange;
		}
		
		
		if (Math.abs(pageNumber - pageFulcrum) <= pageRange) {
			withinRange = true;
		}
		
		return withinRange;
	}

	
	public void setNumFound(int recordsFound) {
		this.numFound = recordsFound;
	}

	
	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}

	
	public int setCurrentPage(int newPage) {
		int returnValue = -1;
		
		if ((newPage > 0) && (newPage <= highestPage())) {
			this.currentPage = newPage;
			returnValue = newPage;
		}
		
		return returnValue;
	}
	
	
	public void setStart(int start) {
		this.start = start;
		int newPage = (start / rowsPerPage) + 1;
		setCurrentPage(newPage);
	}

}
