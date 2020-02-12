Complex Feature Configuration
=============================

This part of the cookbook describes selected parts of the configuration files from the example set. This should give you a good overview of the configuration files needed and what the different parts do. They produce valid GeoSciML v3.2, v4.1 and INSPIRE Annex II Geology theme features and so, hopefully will provide a good starting point to adapt for your own services. However, the mapping for your service from your source data may require some features not used in the example. For these cases you should refer to the `Working with Application Schemas <http://docs.geoserver.org/stable/en/user/data/app-schema/index.html>`_ section of the GeoServer manual which contains comprehensive documentation on the different kinds of mapping from source to output XML that are possible. (It uses GeoSciML v2 based examples.)

Because a single ``gsmlb:GeologicUnit`` can be observed at several distinct locations on the Earth's surface, several ``gsmlb:MappedFeature`` features may point via their ``gsmlb:specification`` property to the same ``gsmlb:GeologicUnit``.

.. include:: WFS_output_abbr_1G.literal

Versions of the cookbook example set and configurations since 2016-08-17 also include ``gsmlb:MappedFeature`` features pointing to ``gsmlb:ShearDisplacementStructure`` (faults).

app-schema.properties
---------------------

This file (in the ``WEB-INF/classes`` directory) is not strictly required but is very useful for storing certain configuration parameters that will be re-used in different parts of the other configuration files and for storing configuration parameters like database usernames and passwords outside of the GeoServer data directory so that the latter can be copied freely. The `Property Interpolation <http://docs.geoserver.org/stable/en/user/data/app-schema/property-interpolation.html>`_ section of the GeoServer manual contains more information on how properties can be set and used in other parts of the configuration files. In the reference configuration files this contains database connection parameters, some commonly used URI values and the setting to turn on `joining <http://docs.geoserver.org/stable/en/user/data/app-schema/joining.html>`_. In fact with current versions of GeoServer (certainly pre-dating v2.4.5) joining is turned on by default and is the recommended setting. There may be some limited situations as described in the `joining documentation <http://docs.geoserver.org/stable/en/user/data/app-schema/joining.html>`_, however, when you need to switch this off. The cookbook example also uses property interpolation to set database column name prefixes to choose whether to use columns that include CGI URI values or INSPIRE URI values.

Data directory
--------------

The example configuration files can be copied into an existing GeoServer data directory so that you can get a working service to try out up and running as quickly as possible. The parts relevant for configuration of a complex feature WFS are contained in the ``workspaces`` directory described in the next section. Other parts of your service configuration like service metadata, security etc. can be set up using the web interface. Thus, when you come to set up your own service, you will probably start with the default GeoServer data directory, configure service metadata etc. in the web interface, and copy the complex feature configuration files from the reference ``data/workspaces`` directory to your own data directory for editing there.

Workspace layout
----------------

The files for configuring complex feature output are contained in the ``data/workspaces`` directory. Inside this directory there is a sub-directory for each namespace of features you will be serving and other namespaces that these features may use somewhere in their content. In the example this includes::

 workspaces
 ├── base
 ├── gco
 ├── ge
 ├── gmd
 ├── gml
 ├── gsml
 ├── gsmlb
 ├── gsmlem
 ├── gsmlga
 ├── gsmlgs
 ├── gsmlgu
 ├── gsmlu
 ├── swe
 └── xlink

These cover all the namespaces used by features in the example data set. If you use different application schemas or even additional GeoSciML packages such as boreholes, you will need to create similar directories for the namespaces used in those schemas. The ``gsmlb`` directory contains mappings to create MappedFeature, GeologicUnit and ShearDisplacementStructure features using the GeoSciML v4.1 Basic package. The ``ge`` and ``base`` directories contain mappings to create features conforming to the :ref:`inspire_geology_schema_wfscb`. The other ``gsml*`` directories contain mappings using the older (and more complex) GeoSciML v3.2. The remaining directories are for namespaces that are imported by the others. 

.. todo::

  I'm not quite sure where the prefix for the namespace is decided and what would happen if the schemas used more than one.
  I'm not sure if the examples without mapping files are only necessary if they are secondary namespaces and I'm not sure if the namespace.xml and workspace.xml files need to be defined for those with datastore and mapping files - are they redundant? They are only described in the documentation for secondary namespaces. They are created for simple feature stores in standard geoserver; are they used by UI?
  If namespace.xml and workspace.xml are used by all workspaces then describe them next as needing setting up for each namespace. Can these be set in the UI?
  Think about making example set have all namespaces used by GeoSciML even if not in features in example set as this will give a headstart for people creating them.

The example configuration defines 2 feature types to be served by the WFS. Their configurations are stored in data store sub-directories of the appropriate namespace directory and are named according to the pattern ``prefix_Feature`` for a feature ``prefix::Feature``::

 workspaces
 ├── base
 ├── gco
 ├── ge
 ├── gmd
 ├── gml
 ├── gsml
 ├── gsmlb
 │   └── gsmlb_GeologicUnit
 │   └── gsmlb_MappedFeature
 │   └── gsmlb_ShearDisplacementStructure
 ├── gsmlem
 ├── gsmlga
 ├── gsmlgs
 ├── gsmlgu
 ├── gsmlu
 ├── swe
 └── xlink


Each of the data store directories contains files similar to the following example for ``gsmlb::MappedFeature``::

 gsmlb_MappedFeature
 ├── AppSchemaDataAccess.xsd
 ├── datastore.xml
 ├── gsmlb_MappedFeature
 │   └── featuretype.xml
 └── gsmlb_MappedFeature.xml

The ``AppSchemaDataAccess.xsd`` file isn't used for the configuration, it is just provided as a convenience when you are editing a mapping file such as ``gsmlb_MappedFeature.xml`` to allow a validating XML editor to give you hints that you have the structure of the file correct. The following sections will describe the ``datastore.xml`` file which creates an application schema data store and specifies the mapping file described in the section after which contains the substantive portion of the configuration mapping source data fields to output in the complex feature types.

.. todo::
  
  There isn't a description of featuretype.xml, does this need creating?, what is it used by and is it configured by UI?

datastore.xml
-------------

Each data store configuration file ``datastore.xml`` specifies the location of a mapping file and triggers its loading as an app-schema data source. This file should not be confused with the source data store, which is specified inside the mapping file.

For ``gsmlb:MappedFeature`` the file is ``workspaces/gsmlb/gsmlb_MappedFeature/datastore.xml``

.. include:: datastore.literal

.. note:: Ensure that there is no whitespace inside an ``entry`` element.

For other feature types the pattern is the same where you replace the names and ids appropriately and change the namespace if necessary. The url entry is a file: URI pointing to the location of the mapping file relative to the GeoServer data directory. The dbtype entry will always be app-schema to define complex feature types.

Mapping files
-------------

Configuration of app-schema feature types is performed in mapping files e.g. 

* ``workspaces/gsmlb/gsmlb_GeologicUnit/gsmlb_GeologicUnit.xml``

* ``workspaces/gsmlb/gsmlb_MappedFeature/gsmlb_MappedFeature.xml``

* ``workspaces/gsmlb/gsmlb_ShearDisplacementStructure/gsmlb_ShearDisplacementStructure.xml``


Namespaces
``````````

Each mapping file contains namespace prefix definitions. The below extract is from ``gsmlb_MappedFeature.xml``

.. code-block:: xml

 <namespaces>
  <Namespace>
   <prefix>gml</prefix><uri>http://www.opengis.net/gml/3.2</uri>
  </Namespace>
  <Namespace>
   <prefix>gsmlb</prefix><uri>http://www.opengis.net/gsml/4.1/GeoSciML-Basic</uri>
  </Namespace>
  <Namespace>
   <prefix>swe</prefix><uri>http://www.opengis.net/swe/2.0</uri>
  </Namespace>
  <Namespace>
   <prefix>xlink</prefix><uri>http://www.w3.org/1999/xlink</uri>
  </Namespace>
  <Namespace>
   <prefix>xsi</prefix><uri>http://www.w3.org/2001/XMLSchema-instance</uri>
  </Namespace>
 </namespaces>

Only those namespace prefixes used in the mapping file need to be declared although you may find it easier just to put all the namespaces used by your target schema in all of them.

Source data store
`````````````````

The data for this tutorial is contained in the PostGIS database set up in the previous section.

For this example, each feature type uses an identical source data store configuration. The ``Parameter`` elements contain values for various database connection parameters. Here we are using `property interpolation <http://docs.geoserver.org/stable/en/user/data/app-schema/property-interpolation.html>`_ so that these don't have to get changed in each mapping file if they change and so that the configuration files can be shared without exposing password information. The values of the interpolated variables (which have the form ``${name}``) should be defined in the ``WEB-INF/classes/app-schema.properties`` file. An example which you can use as a template to fill in with your own values is at ftp://ftp.bgs.ac.uk/pubload/OneGeology/wfscookbook/app-schema.inspire.YYYY-MM-DD.properties. (Updated versions will have different dates instead of YYYY-MM-DD. The example service can be configured to use INSPIRE vocabulary values or IUGS-CGI vocabulary values by setting appropriate variables in this file.)

.. code-block:: xml

 <sourceDataStores>
  <DataStore>
   <id>datastore</id>
   <parameters>
    <Parameter>
     <name>dbtype</name><value>${cgi.dbtype}</value>
    </Parameter>
    <!--
    <Parameter>
     <name>jndiReferenceName</name><value>${cgi.jndi}</value>
    </Parameter>
    -->
    <Parameter>
     <name>host</name><value>${cgi.host}</value>
    </Parameter>
    <Parameter>
     <name>port</name><value>${cgi.port}</value>
    </Parameter>
    <Parameter>
     <name>database</name><value>${cgi.database}</value>
    </Parameter>
    <Parameter>
     <name>user</name><value>${cgi.user}</value>
    </Parameter>
    <Parameter>
     <name>passwd</name><value>${cgi.passwd}</value>
    </Parameter>
    <Parameter>
     <name>schema</name><value>${cgi.schema}</value>
    </Parameter>
    <Parameter>
     <name>Expose primary keys</name><value>true</value>
    </Parameter>
   </parameters>
  </DataStore>
 </sourceDataStores>

See `http://docs.geoserver.org/stable/en/user/data/app-schema/data-stores.html <http://docs.geoserver.org/stable/en/user/data/app-schema/data-stores.html>`_ for a description of how to use other types of data store.


Target types
````````````

The XML Schemas which are required to define a feature type and its properties are specified in the ``targetTypes`` section. The type of the output feature is defined in ``targetElement`` in the ``typeMapping`` section. The below example is from ``gsmlb_MappedFeature.xml``

.. code-block:: xml

 <targetTypes>
  <FeatureType>
   <schemaUri>
    http://schemas.opengis.net/gsml/4.1/geoSciMLBasic.xsd
   </schemaUri>
  </FeatureType>
 </targetTypes>

In this case the schema is published, but because the OASIS XML Catalog is used for schema resolution, a private or modified schema in the catalog can be used if desired.

Mappings
````````

The ``typeMappings`` element begins with configuration elements. From ``gsmlb_MappedFeature.xml``

.. code-block:: xml

 <typeMappings>
  <FeatureTypeMapping>
   <sourceDataStore>datastore</sourceDataStore>
   <sourceType>mapped_feature_gu</sourceType>
   <targetElement>gsmlb:MappedFeature</targetElement>           

* The mapping starts with ``sourceDataStore``, which gives the arbitrary identifier used above to name the source of the input data in the ``sourceDataStores`` section.

* ``sourceType`` gives the name of the source simple feature type. In this case it is the simple feature type ``mapped_feature_gu``, sourced from the table of the same name in the PostGIS database set up in the previous chapter. In versions of the cookbook example configuration since 2016-08-16 this has been changed to point to the view ``mapped_feature_all`` which includes both outcrop polygons of geologic units and linear fault traces.

* When working with databases ``sourceType`` is the name of a table or view. Database identifiers must be lowercase for PostGIS or uppercase for Oracle Spatial.

* ``targetElement`` is the name of the output complex feature type.

gml:id mapping
``````````````

The first mapping sets the ``gml:id`` to be the feature id specified in the source simple feature property which comes from the database column of the same name.

.. code-block:: xml

 <AttributeMapping>
  <targetAttribute>gsmlb:MappedFeature</targetAttribute>
  <idExpression><OCQL>uuid</OCQL></idExpression>
 </AttributeMapping>


* ``targetAttribute`` is the XPath to the element for which the mapping applies, in this case, the top-level feature type.

* ``idExpression`` is a special form that can only be used to set the ``gml:id`` on a feature. In the tutorial database we have a column ``uuid`` suitable for use as a ``gml:id`` attribute value. If your database doesn't have such a column you may be able to use the special function ``getId()`` here instead. This will synthesise an id from the table or view name, a dot ".", and the primary key of the table. If this is not desirable, any other field or CQL expression can be used, if it evaluates to an `NCName <http://www.w3.org/TR/1999/REC-xml-names-19990114/#NT-NCName>`_. In versions of the cookbook example configuration since 2016-08-16 this uses the column ``mf_id``.

The above would generate output like

.. code-block:: xml

 <gsmlb:MappedFeature gml:id="bgsn_digmap20111213000014089_625k">
 ...  


.. only:: INSPIRE
   
   inspireId mapping
   `````````````````
   
   A common property that many INSPIRE themes will have is an inspireId. An example mapping for this property is contained in the ``workspaces/ge/ge_GeologicUnit/ge_GeologicUnit.xml`` file. The relevant section is reproduced below

   .. code-block:: xml

      <AttributeMapping>
       <targetAttribute>ge:inspireId/base:Identifier/base:localId</targetAttribute>
       <sourceExpression><OCQL>bgs_namedrockunit_uri</OCQL></sourceExpression>
      </AttributeMapping>
      <AttributeMapping>
       <targetAttribute>ge:inspireId/base:Identifier/base:namespace</targetAttribute>
       <sourceExpression><OCQL>'http://data.bgs.ac.uk/'</OCQL></sourceExpression>
      </AttributeMapping>

Ordinary mapping
````````````````

Most mappings consist of a target and source. Here is a simple property with a text value from ``gsmlb_GeologicUnit.xml``

.. code-block:: xml

 <AttributeMapping>
  <targetAttribute>gml:description</targetAttribute>
  <sourceExpression>
   <OCQL>description</OCQL>
  </sourceExpression>
 </AttributeMapping>

* In this case, the value of ``gml:description`` is just the value of the ``description`` column in the ``geol_unit`` table.

* For a database, the field name is the name of the column (the table/view is set in ``sourceType`` above). Database identifiers must be lowercase for PostGIS or uppercase for Oracle Spatial.

* CQL expressions can be used to calculate content. Use caution because queries on CQL-calculated values prevent the construction of efficient SQL queries.

* Source expressions can be CQL literals, which are single-quoted.

The above would generate output like

.. code-block:: xml

 <gml:description>STRATHCLYDE GROUP - SEDIMENTARY ROCK CYCLES,
  STRATHCLYDE GROUP TYPE</gml:description>

Client properties
`````````````````

In addition to the element content, a mapping can set values of XML attributes on property elements. These are called "client properties" in GeoServer terminology. Here is one from ``gsmlb_CompositionPart.xml``

.. code-block:: xml

 <AttributeMapping>
  <targetAttribute>gsmlb:material/gsmlb:RockMaterial/gsmlb:lithology</targetAttribute>
  <ClientProperty><name>xlink:href</name><value>${dic.col.prefix}lithology_uri</value></ClientProperty>
  <ClientProperty><name>xlink:title</name><value>${dic.col.prefix}lithology_label</value></ClientProperty>
 </AttributeMapping>

* This mapping leaves the content of the ``gsmlb:lithology`` element empty but sets an ``xlink:href`` attribute to the value of the ``${dic.col.prefix}lithology_uri`` column and an ``xlink:title`` attribute to the value of the ``${dic.col.prefix}lithology_label`` column. Note that in this case the property attributes being set are nested two levels below the parent ``gsmlb:CompositionPart``. Note also that we are using property interpolation here to select the exact name of the database column to be used based on a variable set in the app-schema.properties file. This was useful so the example dataset can be configured to use vocabularies from different authorities but is less likely to be useful for your services.

* As can be seen from this example, multiple ``ClientProperty`` mappings can be set.

This would generate output like

.. code-block:: xml

   <gsmlb:lithology
    xlink:href=
     "http://resource.geosciml.org/classifier/cgi/lithology/clastic_mudstone"
    xlink:title="Mudstone"/>

Feature chaining
````````````````

In feature chaining, one feature type is used as a property of an enclosing feature type, by value or by reference. The following examples show the parts of the ``gsmlb_MappedFeature.xml`` and ``gsmlb_GeologicUnit.xml`` mapping files that put the gsmlb:GeologicUnit elements inside the gsmlb:specification properties of gsmlb:MappedFeature elements. In versions of the cookbook example since 2016-08-16 the below mapping has been commented out to be replaced by a more complex example described in the next section on Polymorphism.

In ``gsmlb_MappedFeature.xml``

.. code-block:: xml

 <AttributeMapping>
  <targetAttribute>gsmlb:specification</targetAttribute>
  <sourceExpression>	
   <OCQL>lex_rcs</OCQL>
   <linkElement>gsmlb:GeologicUnit</linkElement>
   <linkField>FEATURE_LINK</linkField>
  </sourceExpression>
 </AttributeMapping>

In ``gsmlb_GeologicUnit.xml``

.. code-block:: xml

 <AttributeMapping>
  <targetAttribute>FEATURE_LINK</targetAttribute>
  <sourceExpression><OCQL>lex_rcs</OCQL></sourceExpression>
 </AttributeMapping>

* In this case from the mapping for ``gsmlb:MappedFeature``, we specify a mapping for its ``gsmlb:specification`` property.

* The ``linkElement`` specifies which feature (or other complex type) should be used as the value of the property.

* The ``link_specification`` field of the source ``gsmlb_MappedFeature`` simple feature is use as the "foreign key", which maps to the special ``FEATURE_LINK`` field in each ``gsmlb:GeologicUnit``.

* The mapping of the special ``FEATURE_LINK`` attribute in ``gsmlb_GeologicUnit.xml`` to the foreign key field of the underlying table means that every ``gsmlb:GeologicUnit`` with ``lex_rcs`` equal to the ``lex_rcs`` of the ``gsmlb:MappedFeature`` under construction is included as a ``gsmlb:specification`` property of the ``gsmlb:MappedFeature`` (by value).

Feature chaining has been used to construct the property ``gsmlb:specification`` of ``gsmlb:MappedFeature``. This property is a ``gsmlb:GeologicUnit``. The WFS response for ``gsmlb:MappedFeature`` combines the output of both feature types into a single response. The first ``gsmlb:MappedFeature`` has a ``gsmlb:specification`` property value of the ``gsmlb:GeologicUnit`` with the same ``lex_rcs`` code. The next time a mapped feature with the same ``lex_rcs`` code appears, rather than including the whole geologic unit inline again the property has an xlink:href attribute pointing to the first occurrence. The relationships between the feature instances are data driven.

Polymorphism
````````````
In versions of the cookbook example since 2016-08-16 the above mapping with ``gsmlb:MappedFeature``'s pointing to ``gsmlb:GeologicUnit``'s has been extended so that ``gsmlb:MappedFeature/gsmlb:specification`` can contain or point to either a ``gsmlb:GeologicUnit`` as above or a ``gsmlb:ShearDisplacementStructure`` (representing a fault). Setting up an attribute to have different forms like this is described in the `Polymorphism <http://docs.geoserver.org/stable/en/user/data/app-schema/polymorphism.html>`_ section of the GeoServer manual. The cookbook example implements this by having a column ``feature_type`` in the ``mapped_feature_all`` view which indicates whether a row is related to an entry in the ``geol_unit`` table (for ``gsmlb:GeologicUnit`` features) or the ``fault`` table (for ``gsmlb:ShearDisplacementStructure`` features). It then uses the Recode function to switch between which feature type is the ``linkElement`` based on the value of this column.

.. code-block:: xml

   <AttributeMapping>
    <targetAttribute>gsml:specification</targetAttribute>
    <sourceExpression>
     <OCQL>specification_id</OCQL>
     <linkElement>Recode(feature_type, 'gu', 'gsmlb:GeologicUnit', 'sds', 'gsmlb:ShearDisplacementStructure')</linkElement>
     <linkField>FEATURE_LINK</linkField>
    </sourceExpression>
   </AttributeMapping>

.. _inspire_geology_schema_wfscb:

INSPIRE Geology Theme Schema
````````````````````````````
   
If you want to produce a service with data conforming to the INSPIRE Geology theme schema you can examine the configuration files in the ``ge`` and ``base`` directories which were created by copying those in the ``gsmlb`` directory and changing the namespaces and schema locations. The only parts which needed adding which couldn't be adapted from the GeoSciML configuration files were those adding mappings for inspireId properties. It should be fairly simple for you to copy your own mapping files from a GeoSciML configuration to produce an INSPIRE Geology theme schema configuration following a similar process.
