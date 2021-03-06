package edu.lternet.pasta.doi;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

/**
 * @author servilla
 * @since Nov 21, 2012
 * 
 *        Servlet as web-based interface to invoke DOI scanning of Data Package
 *        Manager resource registry.
 * 
 *        Servlet implementation class DOIServlet.
 */
public class DOIServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger
	    .getLogger(edu.lternet.pasta.doi.DOIServlet.class);

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DOIServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		logger.info("DOI processing started...");

		try {
			DOIScanner doiScanner = new DOIScanner();
			doiScanner.doScanToRegister();

			/*
			 * 
			 * Note: This logic is no longer valid as of Ticket #912:
			 * https://trac.lternet.edu/trac/NIS/ticket/912
			 *
			 * doiScanner.doScanToObsolete();
			 */

		}
		catch (Exception e) {
			logger.error(e.getMessage());
			e.printStackTrace();
			throw new ServletException(e.getMessage());
		}
		finally {
			logger.info("DOI processing finished.");
		}

	}

}
