.. _service_provision_data_preparation_lite:

Lite Schemas
============

GeoSciML-Lite and EarthResourceML-Lite (ERML-Lite) are simplified schemas that take the form of a flat table of attributes (conformant to OGC Simple Features Level-0 profile). These were previously called GeoSciML-Portrayal and EarthResourceML-Portrayal.

.. _service_provision_data_preparation_lite_geosciml:

GeoSciML-Lite
-------------

The full specification for GeoSciML-Lite is in the `GeoSciML standard <http://docs.opengeospatial.org/is/16-008/16-008.html>`_. OneGeology itself does not currently make direct use of data using these schemas but the age and lithology URI columns in GeologicUnitView are those that an SLD enabled WMS needs to provide for the age and lithology highlighting functionality to work. These schemas do, however, provide a method to exchange simple interoperable data without supporting complex features that may be more easily achievable and that can help qualify for a 4 star accreditation.

There are seven GeoSciML-Lite views descibed in the 4.1 standard, these are:  GeologicUnitView, ShearDisplacmentStructureView, ContactView, BoreholeView, SiteObservationView, GeologicSpecimenView, GeomorphologicUnitView.  Below we lay out what is expected of the views for those features we think that many geological survey organizations will be able to support.

Generally across all GeoSciML-Lite views, missing values should be specified using OGC nil values *http://www.opengis.net/def/nil/ogc/0/* as below:

.. raw:: html

      <dl>
          <dt>above detection range (AboveDetectionRange)</dt>
          <dd>Value was above the detection range of the instrument used to estimate it.</dd>     
          <dt>below detection range (BelowDetectionRange)</dt>
          <dd>Value was below the detection range of the instrument used to estimate it.</dd>      
          <dt>inapplicable</dt>
          <dd>There is no value</dd>
          <dt>missing</dt>
          <dd>The correct value is not readily available to the sender of this data. Furthermore, a correct value may not exist</dd>
          <dt>template</dt>
          <dd>The value will be available later</dd>
          <dt>unknown</dt>
          <dd>The correct value is not known to, and not computable by, the sender of this data. However, a correct value probably exists</dd>
          <dt>withheld</dt>
          <dd>The value is not divulged</dd>
      </dl>

Alternatively you could use INSPIRE defined void reasons *http://inspire.ec.europa.eu/codelist/VoidReasonValue/*

In the below tables describing the features, **Bold property names indicate required properties.**, *whilst properties of type _uri are defined as xs:string in the GeoSciML-Lite 4.1 schema, to be conformant with GML SF-0, the intention is that these strings SHALL BE absolute URI's.*

.. _service_provision_data_preparation_lite_contactview:

ContactView features
^^^^^^^^^^^^^^^^^^^^

These features provide a simplified view of GeoSciML Contact Features. In GeoSciML terms this will be an instance of a MappedFeature with key property values from the associated ContactFeature summarized in text (data type xs:string) fields, and properties suffixed with ‘_uri’ that contain URIs referring to other resources, for example controlled concepts in published vocabularies.

**Elements in ContactView mapped feature scheme**


.. raw:: html

    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Implementation data type</th>
                <th>Notes</th>
            </tr>
        </thead>
        <tbody>
        <tr>
            <td class="rqd">identifier</td>
            <td>xs:string</td>
            <td>Globally unique identifier for the individual feature. Recommended practice is that this identifier be derived from the primary key for the spatial objects in the source data in case information needs to be transferred from the interchange format back to the source database. This identifier is analogous to the identifier for a GeoSciML MappedFeature.</td>
        </tr>
        <tr>
            <td>name</td>
            <td>xs:string</td>
            <td>Display name for the Contact. Examples: &#8216;<i>depositional contact</i>&#8217;, &#8216;<i>unconformity</i>&#8217;, &#8216;<i>Martin-Escabrosa contact</i>&#8217;</td>
        </tr>
        <tr>
            <td>description</td>
            <td>xs:string</td>
            <td>Text description of the contact, may be a generic description of a contact type taken from an entry on a geological map legend, or a more specific description of the particular contact.</td>
        </tr>
        <tr>
            <td>contactType</td>
            <td>xs:string</td>
            <td>Text label specifying the kind of surface separating two geologic units including primary boundaries such as depositional contacts, all kinds of unconformities, intrusive contacts, and gradational contacts, as well as faults that separate geologic units. Ideally this would be the preferred label for the concept identified by contactType_uri</td>
        </tr>
        <tr>
            <td>observationMethod</td>
            <td>xs:string</td>
            <td>Metadata snippet indicating how the spatial extent of the feature was determined. ObservationMethod is a convenience property that provides a quick and dirty approach to observation metadata.</td>
        </tr>
        <tr>
            <td>positionalAccuracy</td>
            <td>xs:string</td>
            <td>Preferred use is a quantitative value defining the radius of an uncertainty buffer around a MappedFeature, e.g. a positionAccuracy of 100 m for a line feature defines a buffer polygon of total width 200 m centered on the line. Some other text description that quantifies position accuracy may be provided, e.g. a term from a controlled vocabulary. Vocabulary used should be described in the dataset metadata.</td>
        </tr>
        <tr>
            <td>source</td>
            <td>xs:string</td>
            <td>Text describing feature specific details and citations to source materials, and if available providing URLs to reference material and publications describing the geologic feature. This could be a short text synopsis of key information that would also be in the metadata record referenced by metadata_uri.</td>
        </tr>
        <tr>
            <td class="rqd">contactType_uri</td>
            <td class="nbtype">xs:string</td>
            <td>URI referring to a controlled concept from a vocabulary defining the Contact types. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
        </tr>
        <tr>
            <td colspan="3" class="CGI">The current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/contacttype</td>
        </tr>
        <tr>
            <td colspan="3" class="INSPIRE">There is no INSPIRE specific controlled vocabulary for contact type.<br />OneGeology-Europe services applied one of the following CGI vocabulary terms:<br />impact_structure_boundary</a>, volcanic_subsicence_zone_boundary, glacial_stationary_line</td>
        </tr>
        <tr>
            <td>specification_uri</td>
            <td class="nbtype">xs:string</td>
            <td>URI referring to the GeoSciML Contact feature that describes the instance in detail. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
        </tr>
        <tr>
            <td>metadata_uri</td>
            <td class="nbtype">xs:string</td>
            <td>URI referring to a formal metadata record describing the provenance of data.</td>
        </tr>
        <tr>
            <td>genericSymbolizer</td>
            <td>xs:string</td>
            <td>Identifier for a symbol from standard (locally or community defined) symbolization scheme for portrayal. There should be an SLD file available defining the symbol associated with each genericSymbolizer value.</td>
        </tr>
        <tr>
            <td class="rqd">shape</td>
            <td>GM_Object</td>
            <td>Geometry defining the extent of the feature of interest. This is the only element with complex content, and must contain a GML geometry that is valid for the Geography Markup Language (GML) simple features profile (OGC 06-049r1.). The shape value will generally be provided by GIS software, and will need no user input.</td>
        </tr>
        <tr>
            <td colspan="2">Other attribute(s)</td>
            <td>A placeholder allowing any user-defined attributes to be delivered in addition to those specified above.</td>
        </tr>
        </tbody>
    </table>


.. _service_provision_data_preparation_lite_sheardisplacementstructureview:

ShearDisplacementStructureView features
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

These features represent faults and ductile shear zones. In GeoSciML terms they are instances of MappedFeature with key property values from the associated ShearDisplacementStructure feature summarized in text fields (data type xs:string) and fields containing identifiers (URI) for fault type, deformation style, movement type, geologic age, and a formally-encoded (ideally in GeoSciML) specification for interoperability. The latter are the properties suffixed with ‘_uri’ and will contain URIs referring to other resources, for example controlled concepts in published vocabularies.

The concept of ‘Shear displacement structure’ includes all brittle to ductile style faults or ductile shear zones along which displacement has occurred, from a simple, single ‘planar’ brittle or ductile surface to a fault system comprising multiple strands of both brittle and ductile nature. Because this feature class is constrained to have a linear geometry, it is limited to representing shear displacement structures that are considered single surfaces at the scale of portrayal.

**Elements in Shear Displacement Structure View feature**

.. raw:: html


    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Notes</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td class="rqd">identifier</td>
                <td>xs:string</td>
                <td>Globally unique identifier for the individual feature. Recommended practice is that this identifier be derived from the primary key for the spatial objects in the source data in case information needs to be transferred from the interchange format back to the source database. This identifier is analogous to the identifier for a GeoSciML MappedFeature.</td>
            </tr>
            <tr>
                <td>name</td>
                <td>xs:string</td>
                <td>Display name for the ShearDisplacementStructure. This may be a generic fault type, e.g. &#8216;<i>thrust fault</i>&#8217;, &#8216;strike-slip fault</i>&#8217;, or a particular fault name, e.g. &#8216;<i>Moine thrust</i>&#8217;, &#8216;san Andreas Fault</i>&#8217;.</td>
            </tr>
            <tr>
                <td>description</td>
                <td>xs:string</td>
                <td>Text description of the ShearDisplacementStructure, typically taken from an entry on a geological map legend.</td>
            </tr>
            <tr>
                <td>faultType</td>
                <td>xs:string</td>
                <td>Type of ShearDisplacementStructure (as defined in GeoSciML).</td>
            </tr>
            <tr>
                <td>movementType</td>
                <td>xs:string</td>
                <td>Summary of the type of movement (e.g. dip-slip, strike-slip) on the ShearDisplacementStructure.</td>
            </tr>
            <tr>
                <td>deformationStyle</td>
                <td>xs:string</td>
                <td>Description of the style of deformation (e.g. brittle, ductile etc) for the ShearDisplacementStructure.</td>
            </tr>
            <tr>
                <td>displacement</td>
                <td>xs:string</td>
                <td>Text summary of displacement across the ShearDisplacementStructure.</td>
            </tr>
            <tr>
                <td>geologicHistory</td>
                <td>xs:string</td>
                <td>Text (possibly formatted with formal syntax) description of the sequence of events that formed and have affected the ShearDisplacementStructure. Events include process and optional environment information.</td>
            </tr>
            <tr>
                <td>observationMethod</td>
                <td>xs:string</td>
                <td>Metadata snippet indicating how the spatial extent of the feature was determined. ObservationMethod is a convenience property that provides a quick and dirty approach to observation metadata when data are reported using a feature view (as opposed to observation view).</td>
            </tr>
            <tr>
                <td>positionalAccuracy</td>
                <td>xs:string</td>
                <td>Preferred use is a quantitative value defining the radius of an uncertainty buffer around a MappedFeature, e.g. a positionAccuracy of 100 m for a line feature defines a buffer polygon of total width 200 m centered on the line. Some other text description that quantifies position accuracy may be provided, e.g. a term from a controlled vocabulary. Vocabulary used should be described in the dataset metadata.</td>
            </tr>
            <tr>
                <td>source</td>
                <td>xs:string</td>
                <td>Text describing feature specific details and citations to source materials, and if available providing URLs to reference material and publications describing the geologic feature. This could be a short text synopsis of key information that would also be in the metadata record referenced by metadata_uri.</td>
            </tr>
            <tr>
                <td class="rqd">faultType_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a controlled concept from a vocabulary defining the fault (ShearDisplacementStructure) type. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
            </tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/faulttype</td>
            </tr>
            <tr>
                <td colspan="3" class="INSPIRE">The current INSPIRE specific controlled vocabulary is: http://inspire.ec.europa.eu/codelist/FaultTypeValue/</td>
            </tr>
            <tr>
                <td class="rqd">movementType_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a controlled concept from a vocabulary defining the ShearDisplacementStructure movement type. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
            </tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/faultmovementtype</td>
            </tr>
            <tr>
                <td colspan="3" class="INSPIRE">There is no INSPIRE specific controlled vocabulary for movement type.</td>
            </tr>
            <tr>
                <td class="rqd">deformationStyle_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a controlled concept from a vocabulary defining the ShearDisplacementStructure deformation style. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
            </tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary URI stem is: http://resource.geosciml.org/classifier/cgi/deformationstyle<br />for concepts see: http://resource.geosciml.org/vocabulary/cgi/201211/deformationstyle.html</td>
            </tr>
            <tr>
                <td colspan="3" class="INSPIRE">There is no INSPIRE specific controlled vocabulary for deformation style</td>
            </tr>
            <tr>
                <td class="rqd">representativeAge_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a controlled concept specifying the most representative stratigraphic age interval for the GeologicUnit. This will be defined entirely at the discretion of the data provider and may be a single event selected from the geologic feature&#8217;s geological history or a value summarizing the all or part of the feature&#8217;s history.</td>
            </tr>
            <tr>
                <td class="rqd">representativeOlderAge_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a controlled concept specifying the most representative older value in a range of stratigraphic age intervals for the GeologicUnit. This will be defined entirely at the discretion of the data provider and may be a single event selected from the geologic feature&#8217;s geological history or a value summarizing the all or part of the feature&#8217;s history.</td>
            </tr>
            <tr>
                <td class="rqd">representativeYoungerAge_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a controlled concept specifying the most representative younger value in a range of stratigraphic age intervals for the GeologicUnit. This will be defined entirely at the discretion of the data provider and may be a single event selected from the geologic feature&#8217;s geological history or a value summarizing the all or part of the feature&#8217;s history.</td>
            </tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary are: http://resource.geosciml.org/classifier/ics/ischart and<br />http://resource.geosciml.org/classifier/cgi/stratchart (for OneGeology-Europe Precambrian Epoch definitions for the Fenno-Scandian Shield)</td>
            </tr>
            <tr>
                <td colspan="3" class="INSPIRE">The current INSPIRE specific controlled vocabulary is: http://inspire.ec.europa.eu/codelist/GeochronologicEraValue/</td>
            </tr>
            <tr>
                <td>numericOlderAge</td>
                <td>xs:double</td>
                <td>Older age in numerical representation in Ma.</td>
            </tr>   
            <tr>
                <td>numericYoungerAge</td>
                <td>xs:double</td>
                <td>Younger age in numerical representation in Ma.</td>
            </tr>
            <tr>
                <td>specification_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to the GeoSciML ShearDisplacementStructure feature that describes the instance in detail. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
            </tr>
            <tr>
                <td>metadata_uri</td>
                <td class="nbtype">xs:string</td>
                <td>URI referring to a metadata record describing the provenance of data.</td>
            </tr>
            <tr>
                <td>genericSymbolizer</td>
                <td>xs:string</td>
                <td>Identifier for a symbol from standard (locally or community defined) symbolization scheme for portrayal.</td>
            </tr>
            <tr>
                <td class="rqd">shape</td>
                <td>GM_Object<br />(GM_curve)</td>
                <td>Geometry defining the extent of the feature of interest.</td>
            </tr>
            <tr>
                <td colspan="2">Other attribute(s)</td>
                <td>A placeholder allowing any user-defined attributes to be delivered in addition to those specified above.</td>
            </tr>
        </tbody>
    </table>

.. _service_provision_data_preparation_lite_geologicunitview:

GeologicUnitView features
^^^^^^^^^^^^^^^^^^^^^^^^^

GeologicUnitView features represent outcrops of a particular geologic unit, typically with polygon geometry. The properties of these features provide a simplified view of information associated with GeoSciML GeologicUnit features. A geologic unit in this context is an identifiable body of material within the Earth. GeologicUnitView features are instances of GeoSciML MappedFeature with property values from the associated GeologicUnit specifier summarized in text fields for human data consumers, and with fields containing standard identifiers for geologic unit type, representative lithology, and geologic age. The specification_uri property identifies a description resource specific to the geologic unit cropping out in the extent of the polygon (or other) geometry of the feature. The specification_uri should dereference to yield a formally-encoded representation of the geologic unit, ideally in GeoSciML for interoperability. Properties populated by identifiers are suffixed with ‘_uri’ and contain URIs referring to other resources, for example controlled concepts in published vocabularies.

**Elements in GeologicUnitView feature class**

.. raw:: html


	<table>	
		<thead>
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Notes</th>
            </tr>
        </thead>
		<tbody>
			<tr>
                <td class="rqd">identifier</td>
                <td>xs:string</td>
                <td>Globally unique identifier for the individual feature. Recommended practice is that this identifier be derived from the primary key for the spatial objects in the source data in case information needs to be transferred from the interchange format back to the source database. This identifier is analogous to the identifier for a GeoSciML MappedFeature.</td>
            </tr>
			<tr>
                <td>name</td>
                <td>xs:string</td>
                <td>Display name for the GeologicUnit; this can be used to put in a geologic unit name, or more likely an abbreviation used to label outcrops of the unit in a map display.</td>
            </tr>
			<tr>
				<td>description</td>
				<td>xs:string</td>
				<td>Text description of the GeologicUnit, typically taken from an entry on a geological map legend.</td>
			</tr>
			<tr>
				<td>geologicUnitType</td>
				<td>xs:string</td>
				<td>Type of GeologicUnit (as defined in GeoSciML).</td>
			</tr>
			<tr>
				<td>rank</td>
				<td>xs:string</td>
				<td>Stratigraphic rank of GeologicUnit (as defined in GeoSciML). Examples: formation, member, group, supergroup.</td>
			</tr>
			<tr>
				<td>lithology</td>
				<td>xs:string</td>
				<td>Text (possibly formatted with formal syntax) description of the GeologicUnit&#8217;s lithology.</td>
			</tr>
			<tr>
				<td>geologicHistory</td>
				<td>xs:string</td>
				<td>Text (possibly formatted with formal syntax) description of the age of the GeologicUnit (where age is a sequence of events and may include process and environment information).</td>
			</tr>
			<tr>
				<td>numericOlderAge</td>
				<td>xs:double</td>
				<td>Older age in numerical representation in Ma.</td>
			</tr>
			<tr>
				<td>numericYoungerAge</td>
				<td>xs:double</td>
				<td>Younger age in numerical representation in Ma.</td>
			</tr>
			<tr>
				<td>observationMethod</td>
				<td>xs:string</td>
				<td>ObservationMethod is a convenience property to provide observation metadata. Example values might include &#8216;<i>field observation by author</i>&#8217;, &#8216;<i>compilation from published maps</i>&#8217;, &#8216;<i>air photo interpretation</i>&#8217;.</td>
			</tr>
			<tr>
				<td>positionalAccuracy</td>
				<td>xs:string</td>
				<td>Preferred use is a quantitative value defining the radius of an uncertainty buffer around a MappedFeature, e.g. a positionAccuracy of 100 m for a line feature defines a buffer polygon of total width 200 m centered on the line. Some other text description that quantifies position accuracy may be provided, e.g. a term from a controlled vocabulary. Vocabulary used should be described in the dataset metadata. For polygon mapped features this is intended for use to indicate the position uncertainty of the contact and fault features bounding the outcrop polygon, which is only necessary if the associated line features are not included with the polygons.</td>
			</tr>
			<tr>
				<td>source</td>
				<td>xs:string</td>
				<td>Text describing feature specific details and citations to source materials, and if available providing URLs to reference material and publications describing the geologic feature. This could be a short text synopsis of key information that would also be in the metadata record referenced by metadata_uri.</td>
			</tr>
			<tr>
                <td class="rqd">geologicUnitType_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI referring to a controlled concept from a vocabulary defining the GeologicUnit types. Mandatory property - if no value is provided then an URI referring to a controlled concept explaining why the value is nil must be provided.</td>
			</tr>
			<tr>
                <td colspan="3" class="CGI">The current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/geologicunittype/</td>
			</tr>
			<tr>
                <td colspan="3" class="INSPIRE">The current INSPIRE specific controlled vocabulary is: http://inspire.ec.europa.eu/codelist/GeologicUnitTypeValue/</td>
			</tr>
			<tr>
                <td class="rqd">representativeLithology_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI referring to a controlled concept specifying the characteristic or representative lithology of the unit. This may be a concept that defines the supertype of all lithology values present within a GeologicUnit or a concept defining the lithology of the dominant CompositionPart (as defined in GeoSciML) of the unit. This identifier is intended for use as the symbol key for a lithologic map portrayal of the geologic unit features.</td>
			</tr>
			<tr>
                <td colspan="3" class="CGI">The current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/lithology</td>
			</tr>
			<tr>
                <td colspan="3" class="INSPIRE">The current INSPIRE specific controlled vocabulary is: http://inspire.ec.europa.eu/codelist/LithologyValue/</td>
			</tr>
			<tr>
                <td class="rqd">representativeAge_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI referring to a controlled concept specifying the most representative stratigraphic age interval for the GeologicUnit. This will be defined entirely at the discretion of the data provider and may be a single event selected from the geologic feature&#8217;s geological history or a value summarizing all or part of the feature&#8217;s history. This identifier is intended for use as a symbol key for a geologic-age-based portrayal of the geologic unit features.</td>
			</tr>
			<tr>
                <td class="rqd">representativeOlderAge_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI referring to a controlled concept specifying the most representative older value in a range of stratigraphic age intervals for the GeologicUnit. This will be defined entirely at the discretion of the data provider and may be a single event selected from the geologic feature&#8217;s geological history or a value summarizing all or part of the feature&#8217;s history.</td>
			</tr>
			<tr>
                <td class="rqd">representativeYoungerAge_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI referring to a controlled concept specifying the most representative younger value in a range of stratigraphic age intervals for the GeologicUnit. This will be defined entirely at the discretion of the data provider and may be a single event selected from the geologic feature&#8217;s geological history or a value summarizing all or part of the feature&#8217;s history.</td>
			</tr>
			<tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary are: http://resource.geosciml.org/classifier/ics/ischart and<br />http://resource.geosciml.org/classifier/cgi/stratchart (for OneGeology-Europe Precambrian Epoch definitions for the Fenno-Scandian Shield)</td>
			</tr>
			<tr>
                <td colspan="3" class="INSPIRE">The current INSPIRE specific controlled vocabulary is: http://inspire.ec.europa.eu/codelist/GeochronologicEraValue/</td>
			</tr>
			<tr>
				<td>specification_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI for a complete description of the geologic unit cropping out within the extent of the feature&#8217;s geometry. Preferred representation is a GeoSciML GeologicUnit feature instance. Mandatory property - if no value is provided then a nil reason URI explaining why the value is nil must be provided</td>
			</tr>
			<tr>
				<td>metadata_uri</td>
                <td class="nbtype">xs:string</td>
				<td>URI referring to a metadata record describing the provenance of data</td>
			</tr>
			<tr>
				<td>genericSymbolizer</td>
				<td>xs:string</td>
				<td>Identifier for a symbol from standard (locally or community defined) symbolization scheme for portrayal</td>
			</tr>
			<tr>
                <td class="rqd">shape</td>
				<td>GM_Object</td>
				<td>Geometry defining the extent of the feature of interest</td>
			</tr>
			<tr>
                <td colspan="2">Other attribute(s)</td>
				<td>A placeholder allowing any user-defined attributes to be delivered in addition to those specified above.</td>
			</tr>
		</tbody>
	  </table>


.. _service_provision_data_preparation_lite_boreholeview:

BoreholeView features
^^^^^^^^^^^^^^^^^^^^^

BoreholeView is a simplified view of a GeoSciML Borehole. In GeoSciML terms, this will be an instance of a Borehole feature with key property values summarised as labels (unconstrained character strings) or arbitrarily selected classifiers to be used for thematic mapping purposes. The latter are the properties suffixed with “_uri” and will contain URIs referring to controlled concepts in published vocabularies.

**Elements in BoreholeView feature class**

.. raw:: html

	<table>	
		<thead>
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Notes</th>
            </tr>
        </thead>
		<tbody>
			<tr>
                <td class="rqd">identifier</td>
                <td>xs:string</td>
                <td>Globally unique identifier for the individual feature. Recommended practice is that this identifier be derived from the primary key for the spatial objects in the source data in case information needs to be transferred from the interchange format back to the source database. This identifier is analogous to the identifier for a GeoSciML MappedFeature.</td>
            </tr>
			<tr>
                <td>name</td>
                <td>xs:string</td>
                <td>Display name for the Borehole.</td>
            </tr>
			<tr>
				<td>description</td>
				<td>xs:string</td>
				<td>Text description of the Borehole</td>
			</tr>
			<tr>
				<td>purpose</td>
				<td>xs:string</td>
				<td>The purpose or purposes for which the borehole was drilled. (e.g., mineral exploration, hydrocarbon exploration, hydrocarbon production, groundwater monitoring, geothermal)</td>
			</tr>
			<tr>
				<td>status</td>
				<td>xs:string</td>
				<td>The current status of the borehole (e.g., abandoned, completed, proposed, suspended)</td>
			</tr>
			<tr>
				<td>drillingMethod</td>
				<td>xs:string</td>
				<td>The drilling method, or methods, used for this borehole (e.g., RAB, auger, diamond core drilling, air core drilling, piston)</td>
			</tr>
			<tr>
				<td>operator</td>
				<td>xs:string</td>
				<td>The organisation or agency responsible for commissioning of the borehole (as opposed to the agency which drilled the borehole)</td>
			</tr>
			<tr>
				<td>driller</td>
				<td>xs:string</td>
				<td>The organisation responsible for drilling the borehole (as opposed to commissioning the borehole)</td>
			</tr>
			<tr>
				<td>drillStartDate</td>
				<td class="nbtype">xs:string</td>
				<td>The date of the start of drilling formatted according to ISO8601 (e.g., 2012-03-17)</td>
			</tr>
			<tr>
				<td>drillEndDate</td>
				<td class="nbtype">xs:string</td>
				<td>The date of the end of drilling formatted according to ISO8601 (e.g., 2012-03-28)</td>
			</tr>
			<tr>
				<td>startPoint</td>
				<td>xs:string</td>
				<td>The position relative to the ground surface where the borehole commenced (e.g., open pit floor or wall, underground, natural land surface, sea floor)</td>
			</tr>
			<tr>
				<td>inclinationType</td>
				<td>xs:string</td>
				<td>The type of inclination of the borehole (e.g., vertical, inclined up, inclined down, horizontal)</td>
			</tr>
			<tr>
                <td>boreholeMaterialCustodian</td>
                <td>xs:string</td>
				<td>The organisation that is the custodian of the material recovered from the borehole</td>
			</tr>
			<tr>
                <td>boreholeLength_m</td>
                <td>xs:string</td>
				<td>The length of a borehole, in metres, as determined by the data provider. Length may have different sources (e.g., driller’s measurement, logger’s measurement, survey measurement)</td>
			</tr>
            <tr>
                <td>elevation_m</td>
                <td>xs:string</td>
				<td>The elevation data, in metres, for the borehole (i.e., wellbore) start point. This is a compromise approach to allow for delivery of legacy 2D data without elevation data, and for software that cannot process a 3D GM_Point</td>
			</tr>
            <tr>
                <td>elevation_srs</td>
                <td>xs:string</td>
				<td>An URI of a spatial reference system of the elevation value. (e.g., mean sea level). Mandatory if elevation_m is populated. The SRS shall be a one dimensional vertical SRS (i.e., EPSG code in the range 5600-5799),<br/>
                For example: http://www.epsg-registry.org/export.htm?gml=urn:ogc:def:crs:EPSG::5711</td>
			</tr>
            <tr>
                <td>positionalAccuracy</td>
                <td>xs:string</td>
				<td>An estimate of the accuracy of the location of the borehole collar location.  Ideally, this would be a quantitative estimate of accuracy (e.g., 20 metres)</td>
			</tr>
            <tr>
                <td>source</td>
                <td>xs:string</td>
				<td> describes details and citations to source materials for the borehole and, if available, providing URLs to reference material and publications describing the borehole. This could be a short text synopsis of key information that would also be in the metadata record referenced by metadata_uri</td>
			</tr>
			<tr>
                <td>parentBorehole_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI referring to one or more representations of a parent borehole (e.g., a parent well of a sidetrack wellbore)<br />If present, parentBorehole_uri SHOULD resolve to a representation of a GeoSciML borehole.<br />
                **If the borehole does not have any parent, this field shall be empty**</td>
			</tr>
			<tr>
				<td>metadata_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI referring to a metadata record describing the provenance of data</td>
			</tr>
			<tr>
				<td>genericSymbolizer</td>
				<td>xs:string</td>
				<td>Identifier for a symbol from standard (locally or community defined) symbolization scheme for portrayal</td>
			</tr>
			<tr>
                <td class="rqd">shape</td>
				<td>GM_Object</td>
				<td>Geometry defining the extent of the feature of interest</td>
			</tr>
			<tr>
                <td colspan="2">Other attribute(s)</td>
				<td>A placeholder allowing any user-defined attributes to be delivered in addition to those specified above</td>
			</tr>
		</tbody>
	  </table>


.. _service_provision_data_preparation_lite_earthresourceml:

EarthResourceML-Lite
--------------------

EarthResourceML-Lite is a model and schema for simple map services (eg, WMS and WFS Simple Features). It is an abridged version of the full EarthResourceML model and can be used to deliver simplified views on mineral occurrences and their commodities, mines, mining activities and mine waste products.

There are six EarthResourceML-Lite views descibed in the 2.0 standard, these are:  MineView, CommodityResourceView, MineralOccurrenceView, MiningActivityView, MiningWasteView, and ProcessingPlantView.  Below we lay out what is expected of the views for those features we think that many geological survey organizations will be able to support.

For full details of the ERML-Lite schema see: http://schemas.earthresourceml.org/earthresourceml-lite/2.0/erml-lite.xsd

For full documentation of all the views see http://www.earthresourceml.org/earthresourceml-lite/2.0.1/documentation/


.. _service_provision_data_preparation_lite_mineraloccurrenceview:

MineralOccurrenceView features
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. raw:: html

	<table>	
		<thead>
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Notes</th>
            </tr>
        </thead>
		<tbody>
			<tr>
                <td class="rqd">identifier</td>
                <td>xs:string</td>
                <td>A unique identifier (ideally an URI) to identify this Mineral Occurrence mapped feature</td>
            </tr>
			<tr>
                <td>name</td>
                <td>xs:string</td>
                <td>Name of the Mineral Occurrence, if applicable</td>
            </tr>
			<tr>
				<td class="rqd">mineralOccurrenceType</td>
				<td>xs:string</td>
				<td>The type of mineral occurrence. Examples may include prospect, occurrence, mineral deposit, ore deposit, field, district, lode. Ideally terms should be sourced from the MineralOccurrenceType controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/mineral-occurrence-type</td>
			</tr>
			<tr>
				<td class="rqd">commodity</td>
				<td>xs:string</td>
				<td>The commodity or commodities found at an EarthResource. Multiple commodities terms should be concatenated if required. Ideally terms should be sourced from the CommodityCode controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/commodity-code</td>
			</tr>
			<tr>
				<td>mineName</td>
				<td>xs:string</td>
				<td>The name of a mine associated with the Mineral Occurrence, if applicable</td>
			</tr>
			<tr>
				<td>geologicHistory</td>
				<td>xs:string</td>
				<td>A brief description of the age and mineralisation history of the mineral occurrence</td>
			</tr>
			<tr>
				<td>hostGeologicUnit</td>
				<td>xs:string</td>
				<td>Name or description of the host geologic unit</td>
			</tr>
			<tr>
				<td>mineralDepositModel</td>
				<td>xs:string</td>
				<td>Systematically arranged information describing the interpreted mineralisation model or classification for the mineral occurrence. Ideally, terms should be sourced from a controlled vocabulary. May be empirical (descriptive) or theoretical (genetic). (eg, Porphyry Cu, IOCG, VHMS, Epithermal vein)</td>
			</tr>
			<tr>
				<td>mineralOccurrenceShape</td>
				<td>xs:string</td>
				<td>Shape of the mineral occurrence (eg, lenticular, pipe, tabular). Ideally terms should be sourced from the EarthResourceShape controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/earth-resource-shape</td>
			</tr>
			<tr>
				<td>explorationActivityType</td>
				<td>xs:string</td>
				<td>The type of exploration activity eg, geological mapping, drilling, geophysical surveys, geochemical mapping. Ideally terms should be sourced from the ExplorationActivityType controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/exploration-activity-type</td>
			</tr>
			<tr>
				<td>explorationActivityDuration</td>
				<td>xs:string</td>
				<td>Period, or extent in time, of any exploration activity. eg; 1987-1989</td>
			</tr>
			<tr>
				<td>explorationResult</td>
				<td>xs:string</td>
				<td>The result of the exploration activity eg, mineralised zone identified, geochemical anomaly. Ideally terms should be sourced from the ExplorationResult controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/exploration-result</td>
			</tr>
			<tr>
                <td>observationMethod</td>
                <td>xs:string</td>
				<td>Description of the method that was used to identify the location of the Mineral Occurrence. Ideally terms should be sourced from the FeatureObservationMethod controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/mappedfeatureobservationmethod</td>
			</tr>
			<tr>
                <td>positionalAccuracy</td>
                <td>xs:string</td>
				<td>Text description of the accuracy of the feature location. (eg, accurate, approximate, diagrammatic, indefinite, unknown, 5 metres, 1 kilometre)</td>
			</tr>
            <tr>
                <td>source</td>
                <td>xs:string</td>
				<td>A reference for the source(s) of information for the Mineral Occurrence</td>
			</tr>
            <tr>
                <td class="rqd">mineralOccurrenceType_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the commodity. Ideally should link to the CommodityCode controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/mineral-occurrence-type</td>
			</tr>
            <tr>
                <td class="rqd">representativeCommodity_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the major commodity or commodity group for the Mineral Occurrence. Ideally should link to the CommodityCode controlled vocabulary</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/commodity-code</td>
			</tr>
            <tr>
                <td>mine_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify an associated Mine.</td>
			</tr>
			<tr>
                <td>hostGeologicUnit_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the host geologic unit. Ideally, a link to a GeoSciML GeologicUnit or GeologicUnitView. feature</td>
			</tr>
			<tr>
				<td>mineralDepositModel_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the interpreted mineral deposit model classification for the mineral occurrence. Should link to a controlled vocabulary term</td>
			</tr>
			<tr>
				<td>representativeAge_uri</td>
				<td class="nbtype">xs:string</td>
				<td>An URI referring to a GeologicalTimescale controlled concept specifying the most representative geologic age interval for the mineralisation. This will be defined entirely at the discretion of the data provider and may be a single event selected from the mineral occurrence's geologic history or a value summarising the all or part of its history</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/ics/ischart</td>
			</tr>
            <tr>
				<td>representativeOlderAge_uri</td>
				<td class="nbtype">xs:string</td>
				<td>An URI referring to a GeologicalTimescale controlled concept specifying the oldest interpreted age limit for the mineralisation</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/ics/ischart</td>
			</tr>
            <tr>
				<td>representativeYoungerAge_uri</td>
				<td class="nbtype">xs:string</td>
				<td>An URI referring to a GeologicalTimescale controlled concept specifying the youngest interpreted age limit for the mineralisation</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/ics/ischart</td>
			</tr>
            <tr>
				<td>specification_uri</td>
				<td class="nbtype">xs:string</td>
				<td>An URI to identify a full EarthResourceML description of the Mineral Occurrence feature</td>
			</tr>
			<tr>
                <td class="rqd">shape</td>
				<td>gml:GeometryPropertyType</td>
				<td>Geometry defining the location or extent of the mineral occurrence. Only one geometry type may be used in a single MineralOccurrenceView feature service</td>
			</tr>
			<tr>
                <td colspan="2">Other attribute(s)</td>
				<td>A placeholder allowing any user-defined attributes to be delivered in addition to those specified above</td>
			</tr>
		</tbody>
	  </table>


.. _service_provision_data_preparation_lite_commodityresourceview:

CommodityResourceView features
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. raw:: html

	<table>	
		<thead>
            <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Notes</th>
            </tr>
        </thead>
		<tbody>
			<tr>
                <td class="rqd">identifier</td>
                <td>xs:string</td>
                <td>A unique identifier (ideally an URI) to identify this Commodity Resource mapped feature</td>
            </tr>
			<tr>
                <td class="rqd">commodity</td>
                <td>xs:string</td>
                <td>A commodity found in an EarthResource. Other commodity values at the EarthResource should be listed in separate instances. Ideally terms should be sourced from the CommodityCode controlled vocabulary.</td>
            </tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/commodity-code</td>
			</tr>
			<tr>
				<td>commodityRank</td>
				<td>xs:string</td>
				<td>The importance of a commodity compared to other commodities that occur in the mineral deposit. Several commodities may be of interest in a deposit. This classification is based on the potential or endowment: reserves + resources. eg 'primary commodity', 'secondary commodity', 'by-product'</td>
			</tr>
			<tr>
				<td>commodityImportance</td>
				<td>xs:string</td>
				<td>The size ranking of the commodity resource in comparison to the worldwide distribution of mineral deposits. Commodity rank is based on the total endowment in an EarthResource, i.e. (cumulated) past production + reserves (not including past production) + resources, or if the deposit has never been exploited, reserves + resources. A statistical comparison with a large set of deposits throughout the world enables the determination of the deposit as class A (very large), B (large), or C (medium-sized) for a particular commodity. The rank of a commodity resource is thus not based on political or economic considerations</td>
			</tr>
			<tr>
				<td>mineralOccurrenceName</td>
				<td>xs:string</td>
				<td>Name of an associated mineral occurrence</td>
			</tr>
			<tr>
				<td>mineName</td>
				<td>xs:string</td>
				<td>The name of a mine associated with the commodity resource, if applicable</td>
			</tr>
			<tr>
				<td>totalEndowment</td>
				<td>xs:string</td>
				<td>Endowment refers to that quantity of a mineral in accumulations (deposits) meeting specified physical characteristics such as quality, size and depth. Usually includes all resources and reserves, as a commodity's total endowment does not have to have prospects for eventual economic extraction. It includes the total amount of a commodity originally introduced to a particular location during the deposit forming processes - and thus can include resources, reserves, past production and mining and metallurgical losses. Text string datatype so units of measure can be included in value. eg, 1.57 Mt @ 3.0 g/t Au</td>
			</tr>
			<tr>
				<td>totalReserves</td>
				<td>xs:string</td>
				<td>The economically mineable part of a Measured and/or Indicated mineral resource. It includes diluting materials and allowances for losses, which may occur when the material is mined. ‘Marketable Coal Reserves’ maybe reported in conjunction with, but not instead of, reports of Ore (Coal) Reserves. ‘Saleable product’ (e.g. for industrial minerals) can be reported in conjunction with ore reserve. Synonyms: Ore Reserve; Coal Reserve (s); Diamond (or gemstone) Ore Reserve; Mineral Reserves (not preferred, should be stated that used to mean the same as JORC’s Ore Reserve); Mineable production estimates. Text string data type so units of measure can be included in value. eg, 1.23 Mt @ 3.0 g/t Au</td>
			</tr>
			<tr>
				<td>reservesCategory</td>
				<td>xs:string</td>
				<td>The category of reserves (eg, measured, indicated). Should be a EarthResourceReserveCategory controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/reserve-assessment-category</td>
			</tr>
			<tr>
				<td>totalResources</td>
				<td>xs:string</td>
				<td>Total amount and grade of a concentration or occurrence of material of intrinsic economic interest in or on the Earth's crust in such form, quality and quantity that there are reasonable prospects for eventual economic extraction. eg, 1.57 Mt @ 3.0 g/t Au</td>
			</tr>
			<tr>
				<td>resourcesCategory</td>
				<td>xs:string</td>
				<td>The category of resources (eg, indicated, inferred). Should be a EarthResourceResourceCategory controlled vocabulary term.</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/resource-assessment-category</td>
			</tr>
			<tr>
				<td>classificationMethodUsed</td>
				<td>xs:string</td>
				<td>The classification method used to calculate the measurement of ore. Should be a MineralResourceReportingClassificationMethod controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/classification-method-used</td>
			</tr>
			<tr>
                <td>observationMethod</td>
                <td>xs:string</td>
				<td>Description of the method that was used to identify the location of the commodity occurrence. Ideally, terms should be sourced from a controlled vocabulary. (eg, global positioning system, published map, field observation, downhole survey, aerial photography, field survey).</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/mappedfeatureobservationmethod</td>
			</tr>
			<tr>
                <td>positionalAccuracy</td>
                <td>xs:string</td>
				<td>Text description of the accuracy of the feature location. (eg, accurate, approximate, diagrammatic, indefinite, unknown, 5 metres, 1 kilometre)</td>
			</tr>
            <tr>
                <td>source</td>
                <td>xs:string</td>
				<td>A reference for the source(s) of information for the commodity description.</td>
			</tr>
            <tr>
                <td class="rqd">commodityClassifier_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the commodity. Ideally should link to the CommodityCode controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/commodity-code</td>
			</tr>
            <tr>
                <td>mineralOccurrence_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify an associated Mineral Occurrence</td>
			</tr>
            <tr>
                <td>mine_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify an associated Mine.</td>
			</tr>
			<tr>
                <td>reservesCategory_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the reserve category. Should link to a EarthResourceReserveCategory controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/reserve-assessment-category</td>
			</tr>
			<tr>
				<td>resourcesCategory_uri</td>
                <td class="nbtype">xs:string</td>
				<td>An URI to identify the resource category. Should link to a EarthResourceQuantityAssessmentCategory controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/resource-assessment-category</td>
			</tr>
			<tr>
				<td>classificationMethodUsed_uri</td>
				<td class="nbtype">xs:string</td>
				<td>An URI to identify the classification method used to calculate the measurement of ore. Should link to a MineralResourceReporting ClassificationMethod controlled vocabulary term</td>
			</tr>
            <tr>
                <td colspan="3" class="CGI">Current CGI controlled vocabulary is: http://resource.geosciml.org/classifier/cgi/classification-method-used</td>
			</tr>
            <tr>
				<td>specification_uri</td>
				<td class="nbtype">xs:string</td>
				<td>An URI to identify a full EarthResourceML description of the commodity resource feature</td>
			</tr>
			<tr>
                <td class="rqd">shape</td>
				<td>gml:GeometryPropertyType</td>
				<td>Geometry defining the location or extent of the commodity resource. Only one geometry type may be used in a single CommodityResourceView feature service</td>
			</tr>
			<tr>
                <td colspan="2">Other attribute(s)</td>
				<td>A placeholder allowing any user-defined attributes to be delivered in addition to those specified above</td>
			</tr>
		</tbody>
	  </table>





