.. _service_provision_data_preparation_shapefile:

Shapefile
=========

.. todo::

   Possible need for an id column (WFS?). Convert referenced appendices (now just A) from the old cookbook?

.. toctree::
   :maxdepth: 2

   short_names

OneGeology does not recommend using Shapefiles as the data source for your services but, if you already have your data in this format, it can be used as a data source with some restrictions.

If you wish to set up a :term:`SLD enabled WMS` or :term:`Simple feature WFS` using the standard fields needed for age and lithology highlighting in the Portal or following one of the standard 'Lite' schemas then the 10 character limit on field names in Shapefiles means your server will need to map shorter Shapefile field names to the longer expected field names in the standards. We provide some `recommended shapefile definitions <short_names.html>`_ for some GeoSciML-Lite features that are reasonably readable and would enable using common mapping files to produce services using the full names.

Another consideration might be that, if the coordinate system of your Shapefile is not EPSG:4326 and your service is predominantly to be used in the OneGeology Portal, then your server will have to do a lot of on-the-fly coordinate conversion. To ameliorate this you can `convert the coordinate system of your Shapefile </wmsCookbook/appendixA.html>`_. The tools referred to in the previous link are available from http://www.gdal.org if you haven't done the MS4W download that it assumes. 


