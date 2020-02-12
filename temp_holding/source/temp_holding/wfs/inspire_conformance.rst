INSPIRE Conformance
===================

In the previous section we have set up, in INSPIRE terminology, both a 'Web Feature Service and Filter Encoding Implementation of Pre-defined Dataset Download Service' and a 'Web Feature Service and Filter Encoding implementation of Direct Access Download Service'. The former needs to conform to the requirements set out in chapter 6 and the latter to the requirements set out in chapter 7 of the `Technical Guidance for the implementation of INSPIRE Download Services <http://inspire.jrc.ec.europa.eu/documents/Network_Services/Technical_Guidance_Download_Services_v3.1.pdf>`_. We briefly illustrate how the example service conforms to each requirement below.

We emphasise that for OneGeology purposes only you do not need to conform to INSPIRE Technical Guidance (TG) Requirements however as most of them are just standard capabilities of competent and useful WFS 2.0 services we include them in this cookbook and point out that INSPIRE requirements 46, 47, 48, 49, 52, 54, 55, 62, 63, 64, 65, 66, 67 and 68 below are what one might expect from a good WFS 2.0 for general use and the GeoServer software described here can provide these capabilities.

Pre-defined Dataset Download
----------------------------

TG Requirement 46
`````````````````

Implementations shall conform to ISO 19142 Conformance Class 'Simple WFS'

The GetCapabilities response from the service includes the declaration

.. code-block:: xml

 <ows:Constraint name="ImplementsBasicWFS">
  <ows:NoValues/>
  <ows:DefaultValue>TRUE</ows:DefaultValue>
 </ows:Constraint>

and the WFS 2.0.0 standard states that conforming to the Basic WFS class means also implementing the Simple WFS conformance class. It is difficult to guarantee that an implementation is compliant under all circumstances and configurations. Running the OGC CITE tests that check for conformance to the standards is part of the GeoServer build process but the versions of tests run are not always the latest and sometimes test failures can be errors in the tests themselves. Of particular importance for the complex feature services covered here is that many tests may only be run against simple feature examples and the app-schema extension used for complex features has the potential to introduce errors not present in the core. Some known conformance errors are noted below, an up-to-date list of known problems can be founded by searching the project `issue tracker <https://osgeo-org.atlassian.net/browse/GEOS>`_.


Apart from the queries getting information about what the service holds like GetCapabilities, DescribeFeatureType, ListStoredQueries and DescribeStoredQueries, this conformance class requires that the server at least implements a GetFeature request with the WFS 2.0.0 standard query to get a feature using its id as shown by the example request below:

    `http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetFeature& storedquery_id=urn:ogc:def:query:OGC-WFS::GetFeatureById&id=mf.1& <http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetFeature&storedquery_id=urn:ogc:def:query:OGC-WFS::GetFeatureById&id=mf.1&>`_

.. note:: At the time of writing (March 2013) there seems to be a bug so that the above query doesn't actually work. See bug report `GEOS-6233 <https://osgeo-org.atlassian.net/browse/GEOS-6233>`_

TG Requirement 47
`````````````````

Implementations shall conform to ISO 19143 Conformance Class 'Query'

We can send a query using the wfs:Query element such as the below

.. code-block:: xml

 <?xml version="1.0" encoding="UTF-8"?>
 <wfs:GetFeature xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation=
   "http://www.opengis.net/wfs/2.0
    http://schemas.opengis.net/wfs/2.0/wfs.xsd
  http://www.opengis.net/gml/3.2
   http://schemas.opengis.net/gml/3.2.1/gml.xsd"
  xmlns:gsmlb="http://www.opengis.net/gsml/4.1/GeoSciML-Basic"
  xmlns:fes="http://www.opengis.net/fes/2.0"
  xmlns:wfs="http://www.opengis.net/wfs/2.0"
  xmlns:gml="http://www.opengis.net/gml/3.2"
  service="WFS"
  version="2.0.0"
  outputFormat="application/gml+xml; version=3.2"
  count="10">
  <wfs:Query typeNames="gsmlb:MappedFeature">
  </wfs:Query>
 </wfs:GetFeature>


TG Requirement 48
`````````````````

Implementations shall conform to ISO 19142 Conformance Class 'HTTP Get'

This is illustrated by an example KVP encoded request like the following:

    `http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetFeature& typenames=gsmlb:MappedFeature&count=20& <http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetFeature&typenames=gsmlb:MappedFeature&count=20&>`_

.. note:: At the time of writing (March 2013) there seems to be a bug so that, if you explicitly define the namespaces you are using in a GetFeature query like the above in the way required by the WFS 2.0.0 standard, you will get an error. See bug report `GEOS-6885 <https://osgeo-org.atlassian.net/browse/GEOS-6885>`_

TG Requirement 49
`````````````````

Pre-defined Stored Queries shall be provided to make pre-defined datasets available.

The stored query with the name specified in the technical guidance can be invoked with the following query. (Note you must have used the CreateStoredQuery request in the previous chapter to create the stored query first.)

    `http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetFeature& storedquery_id=http://inspire.ec.europa.eu/operation/download/GetSpatialDataSet& DataSetIdCode=13603180&DataSetIdNamespace=http://data.bgs.ac.uk/id/dataHolding/& CRS=urn:ogc:def:crs:EPSG::4326&Language=eng&count=20& <http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetFeature&storedquery_id=http://inspire.ec.europa.eu/operation/download/GetSpatialDataSet&DataSetIdCode=13603180&DataSetIdNamespace=http://data.bgs.ac.uk/id/dataHolding/&CRS=urn:ogc:def:crs:EPSG::4326&Language=eng&count=20&>`_


TG Requirement 50
`````````````````

Any possible (i.e. available) combinations of CRS/DataSetIdCode/DataSetIdNamespace/language shall be made available through pre-defined stored queries.

In the example service there is only one combination of CRS/DataSetIDCode/DataSetIdNamespace/language available and that is illustrated under requirement 49 above.

TG Recommendation 13
````````````````````

The following identifier should be used to identify the Stored Query for serving pre-defined Spatial Data Sets: http://inspire.ec.europa.eu/operation/download/GetSpatialDataSet

This has been implemented as illustrated by the query under requirement 49 above.

TG Requirement 51
`````````````````

Pre-defined Stored Queries shall use the parameter names "CRS", "DataSetIdCode", "DataSetIdNamespace" and "Language" to identify the CRS, dataset ID code, dataset ID namespace and language components of a query.

The query shown under requirement 49 above shows the use of these parameters.

TG Requirement 52
`````````````````

A separate WFS endpoint shall be provided for each INSPIRE dataset thus providing one dataset per GetCapabilities response.

Currently there is only one dataset in the example service so this is satisfied trivially.

TG Requirement 53
`````````````````

INSPIRE Metadata for the Download Service shall EITHER be linked to via an <inspire_common:MetadataURL> in an extended capabilities section, OR the extended capabilities section shall contain all the INSPIRE Metadata for the Download Service in accordance with Table 4 and the inspire_dls:ExtendedCapabilities schema.

The example service uses the inspire_common:MetadataURL element as shown below. This has a dummy URL as the example isn't a real service and so it isn't registered in a metadata catalogue. The INSPIRE plugin GUI described in the previous chapter only allows setting a MetadataURL.

.. code-block:: xml

 <inspire_common:MetadataUrl xsi:type="inspire_common:resourceLocatorType">
  <inspire_common:URL>
   http://metadata.bgs.ac.uk/geonetwork/srv/en/csw?SERVICE=CSW&amp;
    REQUEST=GetRecordById&amp;ID=_id_of_service_to_be_entered_here_&amp;
    elementSetName=full&amp;OutputSchema=http://www.isotc211.org/2005/gmd&amp;
  </inspire_common:URL>
  <inspire_common:MediaType>
   application/vnd.ogc.csw.GetRecordByIdResponse_xml
  </inspire_common:MediaType>
 </inspire_common:MetadataUrl>

TG Requirement 54
`````````````````

A network service [Download Service] metadata response shall contain a list of the natural languages supported by the service. This list shall contain one or more languages that are supported.

This is included in the extended capabilities section of the GetCapabilities response as shown below

.. code-block:: xml

 <inspire_common:SupportedLanguages
  xsi:type="inspire_common:supportedLanguagesType">
  <inspire_common:DefaultLanguage>
   <inspire_common:Language>eng</inspire_common:Language>
  </inspire_common:DefaultLanguage>
 </inspire_common:SupportedLanguages>
 <inspire_common:ResponseLanguage>
  <inspire_common:Language>eng</inspire_common:Language>
 </inspire_common:ResponseLanguage>

TG Requirement 55
`````````````````

A client may specify a specific language in a request. If the requested language is contained in the list of supported languages, the natural language fields of the service response shall be in the requested language. It the requested language is not supported by the service, then this parameter shall be ignored.

This is trivially supported by the example service as there is only one language supported and all responses are in that language.

TG Requirement 56
`````````````````

The GetCapabilities operation is extended by an additional parameter that indicates the client's preferred language.

The name of this parameter shall be "LANGUAGE". The parameter values are based on ISO 639-2/B alpha 3 codes as used in [INS MDTG].

For the example service the parameter value is 'eng' which is the ISO 639-2/B alpha 3 code for English.

TG Requirement 57
`````````````````

If a client request specifies an unsupported language, or the parameter is absent in the request, the above fields [Title, Abstract] shall be provided in the service default language.

The response to the following request specifying the unsupported Finnish language is in English:

    `http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0& request=GetCapabilities&language=fin& <http://localhost:8080/geoserver/ows?service=WFS&version=2.0.0&request=GetCapabilities&language=fin&>`_

TG Requirement 58
`````````````````

The Extended Capabilities shall indicate the response language used for the GetCapabilities-Response: Depending on the requested language the value of the <inspire_common:ResponseLanguage> corresponds to the current used language. If a supported language was requested, <inspire_common:ResponseLanguage> shall correspond to that requested language. If an unsupported language was requested or if no specific language was requested <inspire_common:ResponseLanguage> shall correspond to the service default language <inspire_common:DefaultLanguage>

This is illustrated by the fragment shown under requirement 54.

TG Requirement 59
`````````````````

The Extended Capabilities shall contain the list of supported languages indicated in <inspire_common:SupportedLanguages>. This list of supported languages shall consist of 1. exactly one element <inspire_common:DefaultLanguage> indicating the service default language, and 2. zero or more elements <inspire_common:SupportedLanguage> to indicate all additional supported languages. Regardless of the response language, the list of supported languages is invariant for each GetCapabilities-Response.

This is illustrated by the fragment shown under requirement 54.

TG Requirement 60
`````````````````

The Extended Capabilities shall use the XML Schema as defined in the INSPIRE online schema repository.

The example service declares the above schema in the schemaLocation attribute of the GetCapabilities response as shown below and the response document validates according to the Schema.

.. code-block:: xml

 xsi:schemaLocation=
 "http://www.opengis.net/wfs/2.0 http://schemas.opengis.net/wfs/2.0/wfs.xsd
  http://inspire.ec.europa.eu/schemas/common/1.0
  http://inspire.ec.europa.eu/schemas/common/1.0/common.xsd
  http://inspire.ec.europa.eu/schemas/inspire_dls/1.0
  http://inspire.ec.europa.eu/schemas/inspire_dls/1.0/inspire_dls.xsd"


TG Recommendation 14
````````````````````

For further language support for other operations it is recommended to replace the operation-online-resources in each language specific GetCapabilities-Response by a specific operation-online-resource for that language. To support the additional operation-online-resources the service shall listen at the language specific operation end-points to distinguish for the requested languages.

The example service does not implement this recommendation as it doesn't support more than one language anyway.

TG Recommendation 15
````````````````````

The support of IETF RFC 4646 is recommended wherever the support of ISO/639 B alpha3 for languages infringes the conformity with the standard used for implementing the [INS NS].

I think this doesn't apply to any INSPIRE service as yet as there is no language support defined in current OGC standards applying to WFS.

Direct Access Download
----------------------

TG Requirement 61
`````````````````

Implementations shall meet TG Requirement 48 (conformance to [ISO 19142] 'HTTP GET' conformance class) and TG Requirement 52 (one endpoint for each INSPIRE dataset).

This is covered under requirements 48 and 52 above.

TG Requirement 62
`````````````````

Implementations shall conform to ISO 19142 Conformance Class 'Basic WFS'.

The comments under requirement 46 in fact also apply to this requirement. A illustration of a query showing GetFeature with a Query element which is part of the Basic WFS conformance class but not the Simple WFS conformance class would be the BBOX query below

.. code-block:: xml

 <?xml version="1.0" encoding="UTF-8"?>
 <wfs:GetFeature xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation=
   "http://www.opengis.net/wfs/2.0
    http://schemas.opengis.net/wfs/2.0/wfs.xsd
   http://www.opengis.net/gml/3.2
    http://schemas.opengis.net/gml/3.2.1/gml.xsd"
  xmlns:gsmlb="http://www.opengis.net/gsml/4.1/GeoSciML-Basic"
  xmlns:fes="http://www.opengis.net/fes/2.0"
  xmlns:wfs="http://www.opengis.net/wfs/2.0"
  xmlns:gml="http://www.opengis.net/gml/3.2"
  service="WFS"
  version="2.0.0"
  outputFormat="application/gml+xml; version=3.2"
  count="10">
  <wfs:Query typeNames="gsmlb:MappedFeature">
   <fes:Filter>
    <fes:BBOX>
     <fes:ValueReference>gsmlb:shape</fes:ValueReference>
     <gml:Envelope>
      <gml:lowerCorner>-1.0 51.0</gml:lowerCorner>
      <gml:upperCorner>0.0 52.0</gml:upperCorner>
     </gml:Envelope>
    </fes:BBOX>
   </fes:Filter>
  </wfs:Query>
 </wfs:GetFeature>

TG Requirement 63
`````````````````

A Direct Access Download Service shall conform to ISO 19143 'Ad hoc Query' Conformance Class.

The age, lithology and BBOX queries described in the previous chapter show various examples of different queries in this class.


TG Requirement 64
`````````````````

A Direct Access Download Service shall conform to ISO 19143 'Resource Identification' Conformance Class.

This is illustrated by the query below

.. code-block:: xml

 <?xml version="1.0" encoding="UTF-8"?>
 <wfs:GetFeature xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation=
   "http://www.opengis.net/wfs/2.0
    http://schemas.opengis.net/wfs/2.0/wfs.xsd
   http://www.opengis.net/gml/3.2
    http://schemas.opengis.net/gml/3.2.1/gml.xsd"
  xmlns:gsmlb="http://www.opengis.net/gsml/4.1/GeoSciML-Basic"
  xmlns:fes="http://www.opengis.net/fes/2.0"
  xmlns:wfs="http://www.opengis.net/wfs/2.0"
  xmlns:gml="http://www.opengis.net/gml/3.2"
  service="WFS"
  version="2.0.0"
  outputFormat="application/gml+xml; version=3.2"
  count="10">
  <wfs:Query typeNames="gsmlb:MappedFeature">
   <fes:Filter>
    <fes:ResourceId rid="mf.1"/>
   </fes:Filter>
  </wfs:Query>
 </wfs:GetFeature>

TG Requirement 65
`````````````````

A Direct Access Download Service shall conform to ISO 19143 'Minimum Standard Filter' Conformance Class.

This is illustrated by the age and lithology queries in the previous chapter.


TG Requirement 66
`````````````````

A Direct Access Download Service shall conform to ISO 19143 'Minimum Spatial Filter' Conformance Class.

This is illustrated by the BBOX query in the previous chapter.

TG Requirement 67
`````````````````

A Direct Access Download Service shall conform to ISO 19143 'Minimum Temporal Filter' Conformance Class.

The GetCapabilities response states that this is supported as is the 'During' filter operation but the example data does not contain any temporal properties.

TG Requirement 68
`````````````````

A Direct Access Download Service shall conform to ISO 19143 'Minimum XPath' Conformance Class.

The age and lithology queries in the previous chapter show the use of XPath to refer to some nested property values.
