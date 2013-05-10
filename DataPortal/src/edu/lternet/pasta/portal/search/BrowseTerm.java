/*
 *
 * $Date: 2012-06-22 12:23:25 -0700 (Fri, 22 June 2012) $
 * $Author: dcosta $
 * $Revision: 2145 $
 *
 * Copyright 2011,2012 the University of New Mexico.
 *
 * This work was supported by National Science Foundation Cooperative
 * Agreements #DEB-0832652 and #DEB-0936498.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0.
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific
 * language governing permissions and limitations under the License.
 *
 */

package edu.lternet.pasta.portal.search;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.commons.io.FileUtils;

import org.apache.log4j.Logger;

import edu.lternet.pasta.client.DataPackageManagerClient;
import edu.lternet.pasta.client.PastaAuthenticationException;
import edu.lternet.pasta.client.PastaConfigurationException;


/**
 * The BrowseTerm class models the data and methods for an individual
 * browse term.
 * 
 * @author dcosta
 *
 */
public class BrowseTerm {

  /*
   * Class fields
   */
  private static final Logger logger = Logger.getLogger(BrowseTerm.class);
  
  
  /*
   * Instance fields
   */
  private String browseTermPath = null;
  private int matchCount = 0;
  private String queryString = null;
  private TermsList termsList;
  private final String value;    // Text value of this browse term, e.g. "percent carbon"

  
  /*
   * Constructors
   */
 
  /**
   * Constructor. Initialize this browse term with its text value, e.g. "percent carbon"
   */
  public BrowseTerm(String value) {
    String fileSeparator = System.getProperty("file.separator");
    this.value = value;
    this.browseTermPath = BrowseSearch.browseCacheDir + fileSeparator + fileName() + ".term";
    this.queryString = composeQueryString();
    this.termsList = new TermsList();
    termsList.addTerm(value);
  }


  /*
   * Class methods
   */
  
  
  /*
   * Instance methods
   */
  
  /*
   * Passes through to use the SimpleSearch logic to compose the query string.
   */
  private String composeQueryString() {
    boolean isSiteQuery = isLTERSite();
    TermsList termsList = new TermsList();
    boolean tokenize = false;
    String searchValue = this.value;
    if (isSiteQuery) { searchValue = String.format("knb-lter-%s", this.value.toLowerCase()); }   
    String queryString = SimpleSearch.buildPathQueryXml(searchValue, termsList, tokenize, isSiteQuery);

    return queryString;
  }
  
  
  /**
   * Queries the Data Package Manager for data packages matching this browse term's value.
   */
  public void crawl() {
    String searchResults = runQuery(); 
    writeSearchResults(searchResults);
  }
  

  /**
   * Generates an XML string for storing this browse term in the browse cache
   * on disk as a <term> element.
   */
  String generateCacheString() {
    String cacheString = null;
    String searchResults = readSearchResults();
    StringBuffer stringBuffer = new StringBuffer("");
    int lastIndex = 0;
    final String findStr = "<document>";

    stringBuffer.append("      <term>\n");
    stringBuffer.append("        <value>" + value + "</value>\n");

    /* Count the number of matching documents */
    this.matchCount = 0;
    while (lastIndex != -1) {
      lastIndex = searchResults.indexOf(findStr, lastIndex);     
      if (lastIndex != -1) {
        lastIndex += findStr.length();
        this.matchCount++;
      }
    }

    stringBuffer.append("        <matchCount>" + this.matchCount + "</matchCount>\n");
    stringBuffer.append("      </term>\n");

    cacheString = stringBuffer.toString();
    return cacheString;
  }

  
  /**
   * Returns the match count for this browse term.
   * 
   * @return   matchCount, the number of datasets that matched this browse term
   */
  public int getMatchCount() {
    return matchCount;
  }
 
  
  /**
   * Returns this browse term's value.
   * 
   * @return   value, e.g. "bird"
   */
  public String getValue() {
    return value;
  }
  
  
  private boolean isLTERSite() {
    boolean isSite = false;
    
    LTERSite lterSite = new LTERSite(this.value);
    isSite = lterSite.isValidSite();
    
    return isSite;
  }
  
  
  /**
   * Runs the query for a browse search, simple search, or advanced
   * search. Stores the search results in a "resultSet" session attribute as a 
   * ResultSet object.
   * 
   * @return resultsetXML  XML search results from the Data Package Manager web service
   */
  private String runQuery() {
    String uid = "public";         // All browse-based searches are by public user
    String resultsetXML = null;
    
    try {  
      DataPackageManagerClient dpmClient = new DataPackageManagerClient(uid);
      resultsetXML = dpmClient.searchDataPackages(this.queryString);    
    } 
    catch (PastaAuthenticationException e) {
      logger.error(e.getMessage());
      e.printStackTrace();
    } 
    catch (PastaConfigurationException e) {
      logger.error(e.getMessage());
      e.printStackTrace();
    } 
    catch (Exception e) {
      logger.error(e.getMessage());
      e.printStackTrace();
    }

    return resultsetXML;
  }


  /**
   * Sets the matchCount instance field for this browse term. This is done when
   * the browse cache is read from file.
   * 
   * @param matchCount
   *          the number of datasets matched by this browse term
   */
  public void setMatchCount(int matchCount) {
    this.matchCount = matchCount;
  }

  
  /**
   * Create the HTML to display this browse term on the browse page.
   * If this browse term matches at least one document, then display it as a 
   * link; otherwise, just display it as a text value.
   * 
   * @return htmlString, the HTML string to be displayed on the browse page.
   */
  public String toHTML () {
    String htmlString;
    StringBuffer stringBuffer = new StringBuffer("");
    
    if (matchCount > 0) {
      String encodedValue = value;
      
      try {
        encodedValue = URLEncoder.encode(value, "UTF-8");
      }
      catch (UnsupportedEncodingException e) {
        e.printStackTrace();
      }
      
      stringBuffer.append(String.format("<a href=\'./browseServlet?searchValue=%s\'", encodedValue));
      stringBuffer.append(" class=\"searchsubcat\">");
      stringBuffer.append(value);
      stringBuffer.append(" (" + matchCount + ")");
      stringBuffer.append("</a>");
    }
    else {
      stringBuffer.append(value);
    }

    htmlString = stringBuffer.toString();
    return htmlString;
  }

  
  /**
   * Composes the filename for this browse term by replacing spaces with
   * underscores.
   * 
   * @return
   */
  private String fileName () {
    return value.replace(' ', '_');
  }
  
  
  /*
   * Accessor method for the termsList instance variable.
   * 
   * @return  termsList, a TermsList object
   */
  public TermsList getTermsList() {
    return termsList;
  }
  
  
  /**
   * Reads the search results from file.
   * 
   * @return  searchResults, an XML string
   */
  public String readSearchResults() {
    File browseCacheFile = new File(browseTermPath);
    String searchResults = null;
    
    try {
      searchResults = FileUtils.readFileToString(browseCacheFile);
    }
    catch (IOException e) {
      e.printStackTrace();
    }
    
    return searchResults;
  }
  
  
  /**
   * Writes the search results to file.
   * 
   * @param searchResults      an XML string holding the search results
   */
  private void writeSearchResults(String searchResults) {
    File browseCacheFile = new File(browseTermPath);
    StringBuffer stringBuffer = new StringBuffer("");
    
    stringBuffer.append(searchResults);
    
    try {
      FileUtils.writeStringToFile(browseCacheFile, stringBuffer.toString());
    }
    catch (IOException e) {
      logger.error("IOException:\n" + e.getMessage());
      e.printStackTrace();
    }
  }

}