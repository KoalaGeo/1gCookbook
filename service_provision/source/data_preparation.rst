.. _service_provision_data_preparation:

****************
Data preparation
****************

In very broad terms we can describe preparing your data to be served in a OneGeology compatible service as a kind of ETL (Extract, Transform and Load) workflow. The data needs to be taken from its current format, possibly transformed into a different structure with transformed data values and loaded into as suitable data store for use by your chosen OGC web service software. This section contains some useful information to help in different cases but you will need to have some expertise already with suitable tools to manipulate your data.

If you only have data in the form of paper maps and just intend to provide a simple WMS without attribute data see ":ref:`service_provision_data_preparation_paper_map`".

If you have digital data and wish to make this available as it is and it has a simple format with a list of simple property values for each spatial object then it is likely that the server software we describe later will be able to read your data directly and make it available on the web in a number of standard formats based on the data fields in your source data. If the server software can't read your data format directly then you may need to convert it but most common GIS formats tend to be supported.

If you have digital data and you wish to supply it in a particular standard interchange format such as one of the GeoSciML or ERML simple or complex feature types then you will need to follow a workflow something like the below:

#. Determine which fields in the source data contain the information that is to be delivered in the interchange format fields. Multiple source fields may be combined into single interchange fields, and a single source field may impact values in multiple interchange fields.
#. Determine what steps are necessary to get the content into the interchange format. This may involve some calculation, such as concatenating text from multiple fields to populate the text fields in interchange format. Use of the standard vocabularies for interoperability will likely require mapping vocabulary terms in the source data to identifiers for concepts in the controlled vocabularies.
#. Set up a query to generate a table with field names exactly matching the field names in the interchange schema. In some cases it may be convenient to generate the interchange schema table in several steps, populating subsets of the fields each time. It may be useful to generate a table with unique combinations of contact, fault, or geologic unit properties from the source data, and map each combination to corresponding properties in the interchange format. 
#. The table(s) of unique descriptions can then be joined with the geometry elements of map features to generate the final feature classes for the web service. 

There are many possible approaches to mapping terms from one vocabulary to another. One situation in which a standard process can be defined is that a controlled vocabulary is used to populate a field in the source data, and that field maps directly to a field in the interchange format. For example, consider a source dataset that contains a ‘dominantLithology’ field with the information used to populate the ‘representativeLithology_uri’ for a GeologicUnitView feature. The recommended procedure in this case is:

#. Produce a table of the unique ‘dominantLithology’ values in the source data
#. Add columns to this table for the corresponding term name and URI from the CGI or INSPIRE standard lithology vocabulary.
#. Determine the best matching value from the CGI standard lithology vocabulary for each unique lithology term.
#. Use an SQL query or other data processing system to join the ‘dominantLithology’ field to the corresponding field in the lookup table to update the ‘representativeLithology_uri’ field to the correct standard lithology term URI.

In general, the most specific term from the interchange vocabulary that completely subsumes (encompasses) the meaning of the term in the source vocabulary should be used. If the source vocabulary has terms that are more specific than the controlled vocabulary, there will be some information lost in this process, but the original source terminology could be preserved in an appropriate text description field. Remember, the primary purpose of the controlled vocabulary fields is for data integration, search criteria, and standardized map legends.

As we don't know your data structure or vocabularies we cannot give detailed instructions on how to map your data to one of the standard formats. However, the sections on :ref:`service_provision_data_preparation_lite` and :ref:`service_provision_data_preparation_complex` describe the feature types and properties covered by GeoSciML and EarthResourceML and which CGI or INSPIRE vocabularies can be used for particular feature properties. This should provide a reference for deciding how to map your source data to one of these standard interchange formats.

.. toctree::
   :maxdepth: 1

   data_preparation/paper_map
   data_preparation/lite
   data_preparation/complex
