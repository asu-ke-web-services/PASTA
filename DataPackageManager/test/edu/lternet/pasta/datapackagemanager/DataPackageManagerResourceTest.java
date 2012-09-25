/**
 *
 * $Date$
 * $Author: dcosta $
 * $Revision$
 *
 * Copyright 2011 the University of New Mexico.
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

package edu.lternet.pasta.datapackagemanager;

import static org.junit.Assert.*;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

import edu.lternet.pasta.common.FileUtility;
import edu.ucsb.nceas.utilities.IOUtil;
import edu.ucsb.nceas.utilities.Options;

/**
 * @author dcosta
 * 
 * Tests the operations of the DataPackageManager class.
 *
 */
public class DataPackageManagerResourceTest {

  /*
   * Class fields
   */
  
  private static ConfigurationListener configurationListener = null;
  private static DataPackageManagerResource dataPackageManagerResource;
  private static DataPackageManager dataPackageManager;
  private static final String dirPath = "WebRoot/WEB-INF/conf";
  private static final String testUser = "uid=ucarroll,o=LTER,dc=ecoinformatics,dc=org";
  private static Options options = null;
  private static File testEmlFile = null;
  private static String testEmlFileName = null;
  private static File testEmlFileLevelOne = null;
  private static File testEmlFileNoEntities = null;
  private static final String testEmlFileNameLevelOne = "Level-1-EML.xml";
  private static final String testEmlFileNameNoEntities = "NoEntities.xml";
  private static String testPath = null;
  private static String testScope = null;
  private static String testScopeBogus = null;
  private static Integer testIdentifier = null;
  private static String testIdentifierStr = null;
  private static Integer testRevision = null;
  private static String testRevisionStr = null;
  private static Integer testUpdateRevision = null;
  private static String testEntityId = null;
  private static String testEntityFirstToken = null;

  
  /*
   * Instance fields
   */
  
  
  /*
   * Constructors
   */
  
  
  /*
   * Class methods
   */
  
  public static void modifyTestEmlFile(File testEmlFile, String newPackageId) {
    String xmlString = FileUtility.fileToString(testEmlFile);
    Pattern pattern = Pattern.compile("knb-lter-xyz\\.\\d+\\.\\d+");
    Matcher matcher = pattern.matcher(xmlString);  
    // Replace packageId value with new packageId value
    String modifiedXmlString = matcher.replaceAll(newPackageId);          
    FileWriter fileWriter;

    try {
      fileWriter = new FileWriter(testEmlFile);
      StringBuffer stringBuffer = new StringBuffer(modifiedXmlString);
      IOUtil.writeToWriter(stringBuffer, fileWriter, true);
    }
    catch (IOException e) {
      fail("IOException modifying packageId in test EML file: " + e.getMessage());
    }
  }
  

  /**
   * Initialize objects before any tests are run.
   */
  @BeforeClass
  public static void setUpClass() {
    configurationListener = new ConfigurationListener();
    configurationListener.initialize(dirPath);
    options = ConfigurationListener.getOptions();
    
    if (options == null) {
      fail("Failed to load DataPackageManager properties file");
    }
    else {
      testScope = options.getOption("datapackagemanager.test.scope");
      if (testScope == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.scope'");
      }
      testScopeBogus = options.getOption("datapackagemanager.test.scope.bogus");
      if (testScopeBogus == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.scope.bogus'");
      }
      testIdentifierStr = options.getOption("datapackagemanager.test.identifier");
      if (testIdentifierStr == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.identifier'");
      }
      testRevisionStr = options.getOption("datapackagemanager.test.revision");
      if (testRevisionStr == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.revision'");
      }
      testEntityId = options.getOption("datapackagemanager.test.entity.id");
      if (testEntityId == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.entity.id'");
      }
      testEntityFirstToken = options.getOption("datapackagemanager.test.entity.firstToken");
      if (testEntityFirstToken == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.entity.firstToken'");
      }
      testPath = options.getOption("datapackagemanager.test.path");
      if (testPath == null) {
        fail("No value found for DataPackageManager property 'datapackagemanager.test.path'");
      }
      else {
        testEmlFileName = options.getOption("datapackagemanager.test.emlFileName");
        if (testEmlFileName == null) {
          fail("No value found for DataPackageManager property 'datapackagemanager.test.emlFileName'");
        }
        else {
          testEmlFile = new File(testPath, testEmlFileName);
        }
      }
      
      testEmlFileLevelOne = new File(testPath, testEmlFileNameLevelOne);   
      testEmlFileNoEntities = new File(testPath, testEmlFileNameNoEntities);   
      testIdentifier = new Integer(testIdentifierStr);
      testRevision = new Integer(testRevisionStr);
      testUpdateRevision = testRevision + 1;

      dataPackageManagerResource = new DataPackageManagerResource();
      try {
        dataPackageManager = new DataPackageManager();
      }
      catch (Exception e) {
        fail("Error encountered while constructing DataPackageManager object prior to running JUnit test.");
      }
      
      try {
        Integer newestRevision = dataPackageManager.getNewestRevision(testScope, testIdentifier);
        while (newestRevision != null) {
          testIdentifier += 1;
          newestRevision = dataPackageManager.getNewestRevision(testScope, testIdentifier);
        }
        String testPackageId = testScope + "." + testIdentifier + "." + testRevision;
        System.err.println("testPackageId: " + testPackageId);
        modifyTestEmlFile(testEmlFile, testPackageId);
      }
      catch (Exception e) {
        fail("Error encountered while initializing identifier value prior to running JUnit test.");
      }
      
    }
  }
  
  
  /*
   * Instance methods
   */
  
  /**
   * Initialize objects before each test is run.
   */
  @Before
  public void setUpTest() {
  }
  
  
  /**
   * Test the status and message body of the Create Data Package use case
   */
  @Test public void testCreateDataPackage() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test CREATE for OK status
    Response response = dataPackageManagerResource.createDataPackage(httpHeaders, testEmlFile);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityId));
    }
    
    // Test for Conflict state on a second CREATE
    response = dataPackageManagerResource.createDataPackage(httpHeaders, testEmlFile);
    statusCode = response.getStatus();
    assertEquals(409, statusCode);
  }
  

  /**
   * Test the status and message body of the Create Data Package use case when
   * attempting to create a data package that is already Level-1 (should fail)
   *
   * @TODO: For this test to work, need to re-implement EMLDataPackage.isLevelOne()
   *        Current implementation is based on the old criteria for a Level-1 data package.
  @Test public void testCreateDataPackageLevelOne() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    String testEntityIdLevelOne = "knb-lter-lno.11111.1";
    
    // Test CREATE for 400 status
    Response response = dataPackageManagerResource.createDataPackage(httpHeaders, testEmlFileLevelOne);
    int statusCode = response.getStatus();
    assertTrue(statusCode == 400);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityIdLevelOne));
    }
  }*/
  

  /**
   * Test the status and message body of the Create Data Package use case when
   * attempting to create a data package containing no entities (should fail)
   */
  @Test public void testCreateDataPackageNoEntities() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    String testEntityIdNoEntities = "knb-lter-lno.99999.1";
    
    // Test CREATE for 400 status
    Response response = dataPackageManagerResource.createDataPackage(httpHeaders, testEmlFileNoEntities);
    int statusCode = response.getStatus();
    assertTrue(statusCode == 400);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityIdNoEntities));
    }
  }
  

  /**
   * Test the status and message body of the Evaluate Data Package use case
   */
  @Test public void testEvaluateDataPackage() {
    DummyCookieHttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    List<MediaType> acceptHeaders = new ArrayList<MediaType>();
    MediaType xmlMediaType = new MediaType("application", "xml");
    MediaType htmlMediaType = new MediaType("text", "html");
    acceptHeaders.add(xmlMediaType);
    httpHeaders.setAcceptHeaders(acceptHeaders);
    
    // Test Evaluate for OK status
    Response response = dataPackageManagerResource.evaluateDataPackage(httpHeaders, testEmlFile);
    assertEquals(200, response.getStatus());
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains("<qr:qualityReport"));
      assertTrue(entityString.contains("<entityReport"));
      assertTrue(entityString.contains(testEntityId));
    } 

    // Get an HTML report. Test REPORT for OK status
    System.setProperty("javax.xml.transform.TransformerFactory", 
           "com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl");
    acceptHeaders.add(htmlMediaType);
    httpHeaders.setAcceptHeaders(acceptHeaders);
    response = dataPackageManagerResource.evaluateDataPackage(httpHeaders, testEmlFile);
    assertEquals(200, response.getStatus());
    
    // Check the message body
    entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains("<table"));
      assertTrue(entityString.contains(testEntityId));
    }  
  }
  

  /**
   * Test the status and message body of the Evaluate Data Package use case when
   * attempting to evaluate a data package containing no entities (should fail)
   */
  @Test public void testEvaluateDataPackageNoEntities() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    String testEntityIdNoEntities = "knb-lter-lno.99999.1";
    
    // Test CREATE for OK status
    Response response = dataPackageManagerResource.evaluateDataPackage(httpHeaders, testEmlFileNoEntities);
    int statusCode = response.getStatus();
    assertTrue(statusCode == 400);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityIdNoEntities));
    }
  }
  

  /**
   * Test the status and message body of the List Data Entities use case
   */
  @Test public void testListDataEntities() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.listDataEntities(httpHeaders, testScope, testIdentifier, testRevision.toString());
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityId));
    }
  }
    

  /**
   * Test the status and message body of the List Data Package Identifiers use case
   */
  @Test public void testListDataPackageIdentifiers() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.listDataPackageIdentifiers(httpHeaders, testScope);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testIdentifier.toString()));
    }
  }
    

  /**
   * Test the status and message body of the List Data Package Revisions use case
   */
  @Test public void testListDataPackageRevisions() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.listDataPackageRevisions(httpHeaders, testScope, testIdentifier.toString());
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testRevision.toString()));
    }
  }
    

  /**
   * Test the status and message body of the List Data Package Scopes use case
   */
  @Test public void testListDataPackageScopes() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.listDataPackageScopes(httpHeaders);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testScope));
    }
  }
    

  /**
   * Test the status and message body of the Read Data Package use case
   */
  @Test public void testReadDataPackage() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.readDataPackage(httpHeaders, testScope, testIdentifier, testRevision.toString());
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityId));
    }

    // Test for NOT FOUND status with a bogus package id
    response = dataPackageManagerResource.readDataPackage(httpHeaders, testScopeBogus, testIdentifier, testRevision.toString());
    assertEquals(404, response.getStatus());
  }
    

  /**
   * Test the status and message body of the Read Data Entity
   */
  @Test public void testReadDataEntity() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.readDataEntity(httpHeaders, testScope, testIdentifier, testRevision.toString(), testEntityId);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    byte[] dataEntity = (byte[]) response.getEntity();
    assertNotNull(dataEntity);
    int entitySize = dataEntity.length;
    assertTrue(entitySize > 880);

    // Test for NOT FOUND status with a bogus package id
    response = dataPackageManagerResource.readDataEntity(httpHeaders, testScopeBogus, testIdentifier, testRevision.toString(), testEntityId);
    assertEquals(404, response.getStatus());
  }
    

  /**
   * Test the status and message body of the Read Data Package Report use case
   */
  @Test public void testReadDataPackageReport() {
    DummyCookieHttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    List<MediaType> acceptHeaders = new ArrayList<MediaType>();
    MediaType xmlMediaType = new MediaType("application", "xml");
    MediaType htmlMediaType = new MediaType("text", "html");
    acceptHeaders.add(xmlMediaType);
    httpHeaders.setAcceptHeaders(acceptHeaders);
    
    // Get an XML report. Test REPORT for OK status
    Response response = dataPackageManagerResource.readDataPackageReport(httpHeaders, testScope, testIdentifier, testRevision.toString());
    assertEquals(200, response.getStatus());
    
    // Check the message body
    File entityFile = (File) response.getEntity();
    assertTrue(entityFile.exists());
    String entityString = FileUtility.fileToString(entityFile);
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains("<qr:qualityReport"));
      assertTrue(entityString.contains("<entityReport"));
      assertTrue(entityString.contains(testEntityId));
    } 

    // Get an HTML report. Test REPORT for OK status
    System.setProperty("javax.xml.transform.TransformerFactory", 
           "com.sun.org.apache.xalan.internal.xsltc.trax.TransformerFactoryImpl");
    acceptHeaders.add(htmlMediaType);
    httpHeaders.setAcceptHeaders(acceptHeaders);
    response = dataPackageManagerResource.readDataPackageReport(httpHeaders, testScope, testIdentifier, testRevision.toString());
    assertEquals(200, response.getStatus());
    
    // Check the message body
    entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains("<table"));
      assertTrue(entityString.contains(testEntityId));
    } 
    
    // Test for NOT FOUND status with a bogus package id
    response = dataPackageManagerResource.readDataPackageReport(httpHeaders, testScopeBogus, testIdentifier, testRevision.toString());
    assertEquals(404, response.getStatus());
  }
    

  /**
   * Test the status and message body of the Read Metadata use case
   */
  @Test public void testReadMetadata() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.readMetadata(httpHeaders, testScope, testIdentifier, testRevision.toString());
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityId));
    }

    // Test for NOT FOUND status with a bogus package id
    response = dataPackageManagerResource.readMetadata(httpHeaders, testScopeBogus, testIdentifier, testRevision.toString());
    assertEquals(404, response.getStatus());
  }
    

  /**
   * Test the status and message body of the Search Data Packages use case
   */
  @Test public void testSearchDataPackages() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    String pathqueryXML = 
      "<pathquery version=\"1.0\">\n" +
      "  <meta_file_id>unspecified</meta_file_id>\n" +
      "  <querytitle>unspecified</querytitle>\n" +
      "  <returnfield>dataset/title</returnfield>\n" +
      "  <returnfield>keyword</returnfield>\n" +
      "  <returnfield>originator/individualName/surName</returnfield>\n" +
      "  <returndoctype>eml://ecoinformatics.org/eml-2.0.0</returndoctype>\n" +
      "  <returndoctype>eml://ecoinformatics.org/eml-2.0.1</returndoctype>\n" +
      "  <returndoctype>eml://ecoinformatics.org/eml-2.1.0</returndoctype>\n" +
      "  <querygroup operator=\"UNION\">\n" +
      "    <queryterm casesensitive=\"false\" searchmode=\"contains\">\n" +
      "      <value>bug</value>\n" +
      "      <pathexpr>dataset/title</pathexpr>\n" +
      "    </queryterm>\n" +
      "    <queryterm casesensitive=\"false\" searchmode=\"contains\">\n" +
      "      <value>Carroll</value>\n" +
      "      <pathexpr>surName</pathexpr>\n" +
      "    </queryterm>\n" +
      "  </querygroup>\n" +
      "</pathquery>\n";
    
    // Test READ for OK status
    Response response = dataPackageManagerResource.searchDataPackages(httpHeaders, pathqueryXML);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testScope));
      assertTrue(entityString.contains(testIdentifier.toString()));
    }
  }
    

  /**
   * Test the status and message body of the Update Data Package use case
   */
  @Test public void testUpdateDataPackage() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test UPDATE for OK status
    String testPackageId = testScope + "." + testIdentifier + "." + testUpdateRevision;
    modifyTestEmlFile(testEmlFile, testPackageId);
    Response response = dataPackageManagerResource.updateDataPackage(httpHeaders, testScope, testIdentifier, testEmlFile);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityId));
    }
    
    // Test for Conflict status on a second UPDATE
    response = dataPackageManagerResource.updateDataPackage(httpHeaders, testScope, testIdentifier, testEmlFile);
    statusCode = response.getStatus();
    assertEquals(409, statusCode);

    // Test for Bad Request when the scope value in URI doesn't match scope value in the EML document
    response = dataPackageManagerResource.updateDataPackage(httpHeaders, testScopeBogus, testIdentifier, testEmlFile);
    statusCode = response.getStatus();
    assertEquals(400, statusCode);
  }

  
  /**
   * Test the status and message body of the Create Data Package use case when
   * attempting to create a data package containing no entities (should fail)
   */
  @Test public void testUpdateDataPackageNoEntities() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    String testEntityIdNoEntities = "knb-lter-lno.99999.1";
    String testScopeNoEntities = "knb-lter-lno";
    Integer testIdentifierNoEntities = new Integer(99999);
    
    // Test CREATE for OK status
    Response response = dataPackageManagerResource.updateDataPackage(
        httpHeaders, testScopeNoEntities, testIdentifierNoEntities, testEmlFileNoEntities);
    int statusCode = response.getStatus();
    assertTrue(statusCode == 400);
    
    // Check the message body
    String entityString = (String) response.getEntity();
    assertFalse(entityString == null);
    if (entityString != null) {
      assertFalse(entityString.isEmpty());
      assertTrue(entityString.contains(testEntityIdNoEntities));
    }
  }
  

  /**
   * Test the status and message body of the DELETE use case
   */
  @Test public void testDeleteDataPackage() {
    HttpHeaders httpHeaders = new DummyCookieHttpHeaders(testUser);
    
    // Test DELETE for OK status
    Response response = dataPackageManagerResource.deleteDataPackage(httpHeaders, testScope, testIdentifier);
    int statusCode = response.getStatus();
    assertEquals(200, statusCode);
    
    // Test for Conflict status on a second DELETE
    response = dataPackageManagerResource.deleteDataPackage(httpHeaders, testScope, testIdentifier);
    statusCode = response.getStatus();
    assertEquals(409, statusCode);

    // Test for NOT FOUND status with a bogus package id
    response = dataPackageManagerResource.deleteDataPackage(httpHeaders, testScopeBogus, testIdentifier);
    statusCode = response.getStatus();
    assertEquals(404, statusCode);
  }
  
  
  /**
   * Clean up and release any objects after each test is complete.
   */
  @After
  public void tearDownTest() {
  }
  
  
  /**
   * Release any objects after all tests are complete.
   */
  @AfterClass
  public static void tearDownClass() {
    dataPackageManagerResource = null;
    dataPackageManager = null;
    configurationListener = null;
    options = null;
    testScope = null;
    testScopeBogus = null;
    testIdentifierStr = null;
    testRevision = null;
    testEntityId = null;
    testPath = null;
    testEmlFileName = null;
    testEmlFile = null;
  }
  
}
