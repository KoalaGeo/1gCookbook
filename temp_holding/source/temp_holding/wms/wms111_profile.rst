.. contents::

*********************************
OneGeology Profile for WMS v1.1.1
*********************************
Service level metadata
======================

Service Title
-------------

.. todo::

   We need to consider whether we need to keep specifying service title, especially as more people will be setting up services which aren't just for OneGeology. The service title doesn't appear in the Portal anywhere. It does appear in the catalogue and is somewhat helpful in browsing. We should check that keywords enable useful browsing in the catalogue. Service provider and Data provider are in metadata keywords. Should be possible to add these to services even when they are serving non-OneGeology layers/features/coverages. Language should also be covered by MD_LANG, do we want a separate DS_LANG as well? Anyway, no need to reproduce this metadata in service title. The theme part is fairly superfluous as well. Could suggest the existing naming conventions if a service fits neatly into that category but drop as a requirement. Also not a requirement for WCS as v1.0.0 doesn't even have a title element.

* /WMT_MS_Capabilities/Service/Title (1.1.1)
* /WMS_Capabilities/Service/Title (1.3.0)

Service Abstract
----------------

Information about the service and general information about the map data served in the layers. You may also use this to field to describe the data owner organization, and its goals within OneGeology etc. You can also include in this section information about the scale layering of your service, and any other information that is not automatically extracted / viewable by the OneGeology Portal (or indeed any other client software). We can't enforce definite rules on the content but this is important for users of your data.

* /WMT_MS_Capabilities/Service/Abstract (1.1.1)
* /WMS_Capabilities/Service/Abstract (1.3.0)

Access Constraints
------------------

Information about who is allowed to use the data served by the WMS, and for what purpose they can use it for. Remember your WMS is available to any application that is able to access the Internet, not just through the OneGeology Portal.

For clarity to any potential users, it is recommended (within the OGC specifications) that you explicitly state when there are no access constraints on the using the service using the word "none".

Note too that there is no "AccessConstraints" metadata applicable at the layer level. If you need to define different access constraints for different layers in your service you will need to define these differences in the service level metadata. It may be more convenient to have separate services where different access constraints apply.

* /WMT_MS_Capabilities/Service/AccessConstraints (1.1.1)
* /WMS_Capabilities/Service/AccessConstraints (1.3.0)

Nothing for fees?

Keywords
--------

.. todo::

   Does OneGeology keyword in service level do anything, presumably any service URL that is given to be registered is registered so this is only for searching over many catalogues? If we have services that have many non-OneGeology layers do we really have any good reason for making this a requirement?

A list of keywords or short phrases that users of the OneGeology Portal and other catalogue services could use to search/discover your services. You must include the keyword OneGeology.

We would like you to also supply two special @ style ‘Metadata keywords’ (MD_DATE\@value and MD_LANG\@value) that will be used to populate the OneGeology catalogue of services, and which help make the GetCapabilities response ISO19115 core compliant.

MD_DATE@ is used to add a date for when the information in the GetCapabilites file for the service was last updated, (for MapServer services this would be the same as a change to the .map configuration file). For example the exemplar BGS_Bedrock_and_Superficial_Geology service has a MD_DATE@ keyword of MD_DATE\@2011-06-15

MD_LANG@ is used to add the langauge (using the ISO 639-3 three letter codes) that the GetCapabilites file is populated with. This may be different from the language that the service returns its data in. For example the exemplar BGS_Bedrock_and_Superficial_Geology service has a MD_LANG@ keyword of MD_LANG\@ENG

* /WMT_MS_Capabilities/Service/KeywordList/Keyword (1.1.1)
* /WMS_Capabilities/Service/KeywordList/Keyword (1.3.0)

Data provider
-------------

The full name of the data owner organization not service provider, where these are different, such as in buddied services. In the case of services that also supply non-OneGeology data, the contact should be able to put an enquirer in touch with whoever is responsible for the OneGeology data.

* /WMT_MS_Capabilities/Service/ContactInformation/ContactPersonPrimary/ContactOrganization (1.1.1)
* /WMS_Capabilities/Service/ContactInformation/ContactPersonPrimary/ContactOrganization (1.3.0)

.. todo::

   This is harvested together with other Contact Person names from WMS into contact information metadata in 1g catalogue and displayed under Contact: information in layer information in portal. The WFS information is harvested into metadata in catalogue I think but not displayed anywhere in portal. For WCS contact information is harvested into catalogue record and displayed in portal layer details.

   No need mentioning the image format element; part of normal software functioning.

Online Resource
---------------

.. todo::

   Remove the comment that could put service URL in if no other resource? Check what required by WMS specification means. This isn't displayed anywhere in Portal. Harvested in catalogue. In QGIS value doesn't get shown in layer properties (because in attribute?)

A link to the data owner organization web site, or web site with information about the data owner organization. Note this online resource is intended to provide additional information on the provider of the data and is NOT intended to be the same as the online resource attribute referenced in the Capability section of the response. i.e. NOT the same as the resource cited in, for example the below location in a 1.3.0 response, though this may be used if no other resource is available:
/WMS_Capabilities/Capability/Request/GetCapabilities/DCPType/HTTP/Get/OnlineResource

* /WMT_MS_Capabilities/Service/OnlineResource (1.1.1)
* /WMS_Capabilities/Service/OnlineResource (1.3.0)

OGC Service Recommended Metadata
--------------------------------

Contact Information
-------------------

In addition to the required organisation name we recommend that you add additional contact information that will enable a user to get in touch with a named person who can act as a contact for any enquiries by post, email or phone. The different service types and versions provide slightly different structured fields for including this information under fairly self-explanatory element names. The below XPATHs give the parent elements within which you can find different elements for email, phone etc. Don't forget these are for an international audience, e.g. include country code in telephone numbers.

* /WMT_MS_Capabilities/Service/ContactInformation (1.1.1)
* /WMS_Capabilities/Service/ContactInformation

Fees
----

Any fees required to use the WMS services and data contained within. Again if there are no fees you are recommended to explicitly state this using the word "none".

* /WMT_MS_Capabilities/Service/Fees (1.1.1)
* /WMS_Capabilities/Service/Fees (1.3.0)

Layer / Coverage / Feature metadata
===================================

Depending on which service type you are serving the actual data sets that you are supplying will be delivered as a number of layers (WMS), coverages (WCS) or features (WFS). Each of these can have their own specific metadata. The OneGeology portal allows the selection of WMS layers and WCS coverages to view and presents selected aspects of the layer/coverage metadata in its layer list. These metadata are also used to arrange layers/coverages under geographical areas and under themes and enable searching for layers/coverages including searching on some aspects of their functionality. 


WMS Layer and WCS Coverage Naming
---------------------------------

Both WMS and WCS have the concept names which are used in the protocol to select which layers/coverages are returned and human readable names which are used for presenting in a client interface. The former do not need to be human readable and some server software may not allow much control over their format. The latter are the way layers and coverages are presented to a user for selection so it is important that they are understandable and informative. Thus OneGeology has a naming convention which we require for the human readable names. It can also be friendly to make the machine readable names understandable for testing or writing custom clients so, although we don't make it a requirement, we do recommend that you follow the conventions below for the machine readable names as well if you can.


**[Geographical extent]** of the data in the layer, then **[Data owner organization]** (not service provider), then **[Language code]** (if non-default as per service naming conventions), then **[Scale]**, then **[Theme]**.

INSPIRE layer naming considerations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your service falls under the INSPIRE naming conventions, then both the layer name and the layer title are fixed according to the legislation. For example the `D2.8.II.4 Data Specification on Geology–Technical Guidelines <http://inspire.ec.europa.eu/documents/Data_Specifications/INSPIRE_DataSpecification_GE_v3.0.pdf>`_ tell us (section 11.1 ~ Layers to be provided by INSPIRE view services) that any layer to do with lithology or age must have the name *GE.GeologicUnit* and title *Geologic Units*.  See the `layer-naming <https://themes.jrc.ec.europa.eu/discussion/view/13952/layer-naming>`_ discussion on the INSPIRE Thematic Clusters Geology forum for fuller details.

To have a multiple layer geology service that adheres to the INSPIRE naming rules we believe the only option is for you to configure group layering.  In such a situation, the layer name and title rules set out in this and the following sections relate to the grouped (or sub layers).  Whereas the INSPIRE name and title relate to the group (or parent) layer.

Machine readable name
^^^^^^^^^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/Name (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/Name (1.3.0)

Human readable name
^^^^^^^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/Title (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/Title (1.3.0)

Abstract
^^^^^^^^

You must provide a description of your layer/coverage data. You may wish to include other metadata, such as information about your organization and other data you make available. You may also wish to include a statement on access constraints. For features following a standard community Schema this may not be so relevant at the feature level in that a service will be providing data for a certain data set and the abstract description of the features will be just the general description of that feature type in the schema (? should think a bit about best thing here).

* /WMT_MS_Capabilities/Capability/Layer/Layer/Abstract (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/Abstract (1.3.0)

Keywords
^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/KeywordList/Keyword (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/KeywordList/Keyword (1.3.0)

MS Root Layer Name
-------------------

.. todo::

   I would just drop any OneGeology requirement on this but do a double check of how it appears in different clients to see if it might be helpful for some. Not used by Portal. Put this section in separate WMS bit

INSPIRE layer naming considerations
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If your INSPIRE service is only serving layers of one type, one way of applying group layering would be to use the root layer name and title (not service name and title) as the grouping layer, see `section 2.5 <2_5.html>`_ for further details.

Extent
^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/LatLonBoundingBox (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/EX_GeographicBoundingBox (1.3.0)

In WMS version 1.1.1 a list of (latitude-longitude decimal degree) coordinates defining an imaginary box that entirely encompasses the map data.  It is always specified as minimum-X, minimum-Y, maximum-X, and maximum-Y.  The purpose of these extent values is to facilitate geographic searches; values may be approximate.

In WMS version 1.3.0 four elements each describing a single bounding limit (always in the order: west, east, south, north)

Spatial/Coordinate Reference System
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/SRS (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/CRS (1.3.0)

A list of one or more horizontal ’ Spatial Reference Systems’ that the layer can handle (will accept requests in and return results based upon those SRS).  In WMS 1.1.1, the returned image is always projected using a pseudo-Plate Carrée projection that plots Longitude along the X-axis and Latitude along the Y-axis.

For example, the exemplar service lists the following Spatial Reference Systems: EPSG:4326, EPSG:3857, CRS:84, EPSG:27700, EPSG:4258

The portal now supports a number of projection systems, including two suitable for INSPIRE compliance; see `section 4.3.1.2 <4_3_1_2.html#projStarsTab>`_ for a list of projections currently supported by the portal.

BoundingBox
^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/BoundingBox (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/BoundingBox (1.3.0)

The BoundingBox attributes indicate the edges of the bounding box in units of the specified spatial reference system, for example, the exemplar service provides the following BoundingBox information for the GBR BGS 1:625k bedrock lithology layer:      
**Example WMS 1.1.1 response**

.. code-block:: xml

   <BoundingBox SRS="EPSG:4326" minx="-8.64846" miny="49.8638" maxx="1.76767" maxy="60.8612" />
   <BoundingBox SRS="EPSG:3857" minx="-962742" miny="6.42272e+006" maxx="196776" maxy="8.59402e+006" />
   <BoundingBox SRS="CRS:84" minx="-8.64846" miny="49.8638" maxx="1.76767" maxy="60.8612" />
   <BoundingBox SRS="EPSG:27700" minx="-77556.4" miny="-4051.91" maxx="670851" maxy="1.23813e+006" />
   <BoundingBox SRS="EPSG:4258" minx="-8.64846" miny="49.8638" maxx="1.76767" maxy="60.8612" />

**Example WMS 1.3.0 response**

.. code-block:: xml

   <BoundingBox CRS="EPSG:4326" minx="49.8638" miny="-8.64846" maxx="60.8612" maxy="1.76767" />
   <BoundingBox CRS="EPSG:3857" minx="-962742" miny="6.42272e+006" maxx="196776" maxy="8.59402e+006" />
   <BoundingBox CRS="CRS:84" minx="-8.64846" miny="49.8638" maxx="1.76767" maxy="60.8612" />
   <BoundingBox CRS="EPSG:27700" minx="-77556.4" miny="-4051.91" maxx="670851" maxy="1.23813e+006" />
   <BoundingBox CRS="EPSG:4258" minx="49.8638" miny="-8.64846" maxx="60.8612" maxy="1.76767" />

**Please note the swap in x,y axes order for the geographic coordinate systems EPSG:4258 and EPSG:4326 between WMS versions.  In WMS version 1.3.0 the x-axis is the first axis in the CRS definition, and the y-axis is the second.  EPSG geographic coordinate reference systems follow ISO 6709 and ALWAYS list latitude before longitude.**

DataURL (optional)
^^^^^^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/DataURL (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/DataURL (1.3.0)

MetadataURL
^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/MetadataURL (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/MetadataURL (1.3.0)

**Example WMS 1.1.1 response**

.. code-block:: xml

   <MetadataURL type="TC211">
   <Format>application/xml; charset=UTF-8</Format>
   <OnlineResource
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xlink:type="simple"
     xlink:href="http://metadata.bgs.ac.uk/geonetwork/srv/en/csw?
       service=CSW&
       version=2.0.2&
       request=GetRecordById&
       id=ac9f8250-3ae5-49e5-9818-d14264a4fda4&" />
   </MetadataURL>

**Example WMS 1.3.0 response**

.. code-block:: xml

   <MetadataURL type="ISO 19115:2003">
   <Format>application/xml; charset=UTF-8</Format>
   <OnlineResource
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xlink:type="simple"
     xlink:href="http://metadata.bgs.ac.uk/geonetwork/srv/en/csw?
       service=CSW&
       version=2.0.2&
       request=GetRecordById&
       id=ac9f8250-3ae5-49e5-9818-d14264a4fda4&" />
   </MetadataURL>

Please note: the defined attribute value to indicate ISO 19115:2003 metadata is “ISO 19115:2003” in WMS version 1.3.0 as opposed to “TC211” in version 1.1.1. In version 1.3.0, communities may **ALSO** define their own attributes. We **RECOMMEND** that if you can change this attribute for different WMS  version GetCapabilities responses you should use “ISO 19115:2003” for your WMS 1.3.0 response. If you can only configure one response type then you **MUST** use “TC211”.

Minimum Scale
^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/ScaleHint@min (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/MinScaleDenominator (1.3.0)

Maximum Scale
^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/ScaleHint@max (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/MaxScaleDenominator (1.3.0)

Is the layer *queryable*
^^^^^^^^^^^^^^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer@queryable (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/@queryable (1.3.0)

Legend url
^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/Style/LegendURL (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/Style/LegendURL (1.3.0)

Style name
^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/Style/Name (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/Style/Name (1.3.0)

Style title
^^^^^^^^^^^

* /WMT_MS_Capabilities/Capability/Layer/Layer/Style/Title (1.1.1)
* /WMS_Capabilities/Capability/Layer/Layer/Style/Title (1.3.0)

Layer styling information
=========================

The examples below show the styling portion of the GetCapabilities response.  The first two come from MapServer services, and show that the legend will be generated on-the-fly using an SLD GetLegendGraphic request.  The third example shows a simple request to a static image, generated in advance by the map service provider.

Example style information from a MapServer version 4.10.3 WMS version 1.1.1. GetCapabilities response.  The legend will be created automatically by MapServer and served using an SLD GetLegendGraphic operation.

.. code-block:: xml

   <Style>
   <Name>default</Name>
   <Title>default</Title>
   <LegendURL width="20" height="10">
   <Format>image/png</Format>
   <OnlineResource
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xlink:type="simple"
     xlink:href="http://ogc.bgs.ac.uk/cgi-bin/BGS_Bedrock_and_Superficial_Geology/wms?
       version=1.1.1&
       service=WMS&
       request=GetLegendGraphic&
       layer=UKCoShelf_BGS_1M_SBS&
       format=image/png&" />
   </LegendURL>
   </Style>
 
Example style information from a MapServer version 5.6.5 WMS version 1.3.0. GetCapabilities response.  The legend will be created automatically by MapServer and served using an SLD GetLegendGraphic operation.  Note the OnlineResource URL now includes an sld_version parameter.

.. code-block:: xml

   <Style>
   <Name>default</Name>
   <Title>default</Title>
   <LegendURL width="328" height="3013">
   <Format>image/png</Format>
   <OnlineResource
     xmlns:xlink="http://www.w3.org/1999/xlink"
     xlink:type="simple"
     xlink:href="http://ogc.bgs.ac.uk/cgi-bin/BGS_GSN_Bedrock_Geology/wms?
       version=1.3.0&
       service=WMS&
       request=GetLegendGraphic&
       sld_version=1.1.0&
       layer=NAM_GSN_1M_BLS&
       format=image/png&
       STYLE=default&"/>
   </LegendURL>
   </Style>

Example style information from an ArcGIS server WMS version 1.3.0. GetCapabilities response.  A detailed static legend is provided.

.. code-block:: xml

   <Style>
   <Name>default</Name>
   <Title>US-KY KGS 1:500K Kentucky Geologic Formations</Title>
   <LegendURL width="100" height="588">
   <Format>image/png</Format>
   <OnlineResource
     xlink:href="http://.../.../KGS_Geology_and_Faults_MapServer/wms/default2.png&"
     xlink:type="simple"
     xmlns:xlink="http://www.w3.org/1999/xlink" />
   </LegendURL>
   </Style>

