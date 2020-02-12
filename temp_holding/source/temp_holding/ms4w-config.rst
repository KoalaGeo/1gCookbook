MS4W software installation
==========================





Updating an existing OneGeology MS4W installation
=================================================

From time to time it will be necessary to update your MapServer or MS4W installation, for example when bug fixes are released, or when the software is upgraded to allow a new version of the WMS specification to be served.   To update to a new version of MS4W, you should first stop and uninstall the existing Apache service by running the "apache-uninstall.bat" file found in the ms4w folder (i.e. by clicking on it).  You can then just unzip the new MS4W zip file into the same location, and allow it to overwrite all existing files.  Any file or folder within the existing ms4w folder that you have created will not be deleted.  You then need to run the apache-install.bat script inside the ms4w folder to install your new version of Apache.  The new version of the MapServer binaries will be installed into the cgi-bin folder; if you are following the methodology set out by the exemplar WMS, you will need to copy the new binaries to each of the Application sub folders within cgi-bin, and rename the mapserv.exe to wms.

If your Apache installation is up-to-date and you only wish to update MapServer you need only get a copy of the MapServer binaries for example, from the latest MS4W zip, or sometimes as a separate MapServer zip downloadable from `http://dl.maptools.org/dl/ms4w/ <http://dl.maptools.org/dl/ms4w/>`_, and copy them over the existing MapServer files in the cgi-bin folder (and sub-folders as appropriate). See section `4.3.1 <4_3_1.html>`_ for further details.

You will need to rename the copy of "mapserv.exe" inside your cgi-bin folder to "wms". Make sure there is no .exe extension, especially if you do not have file extensions visible in your Explorer windows.  You may get a warning about changing the file suffix; this is OK.

If you already have an Apache installation
==========================================

If you already have an installation of Apache which you want to use it is possible to copy the necessary parts of the MS4W bundle to your installation.  The details will depend on exactly how you have configured your installation but the main steps you will need to follow are as follows.  They are in the context of using a pristine Apache (v2.2.17) installation so, if you have done a lot of customization of your installation you may need to adapt them.

Instead of following all the above steps for installation simply unzip the ms4w.zip file to a convenient temporary location.  You will then need to copy the following files over to your existing Apache installation.  In the following we give directory paths from the ms4w root wherever you unzipped it.

Copy the contents of ms4w\Apache\cgi-bin to the cgi-bin directory of your Apache installation.  (Strictly you may not need all these files but it is easier just to copy them all across.)

Add the following directives in an appropriate place in your httpd.conf file.

.. code-block:: apacheconf

   #----------------------------------
   # Alias for MapServer tmp directory
   #----------------------------------
   Alias /ms_tmp/ /ms4w/tmp/ms_tmp/
   <Directory "/ms4w/tmp/">
       AllowOverride None
       Options None
       Order allow, deny
       Allow from all
   </Directory>
   
Replace "/ms4w/tmp/" with the path to somewhere on your machine suitable for storing the temporary image files which MapServer generates during its operation.  You may also want to copy the contents of ms4w\tmp to this directory as it contains a script that can be used to delete old files from this directory and which could be set as a scheduled task.

You will also want to copy the following directories from the MS4W bundle to somewhere convenient on your machine: ms4w\proj\nad, ms4w\gdaldata and ms4w\gdalplugins.  Then add the following to your httpd.conf file, replacing the path /ms4w/ with the directory you have copied the above directories to.

.. code-block:: apacheconf

   # set environment vars necessary for MapServer
   SetEnv PROJ_LIB /ms4w/proj/nad/
   # Replace /Apache/cgi-bin/ below with your
   # Apache cgi-bin directory path
   SetEnv PATH /Apache/cgi-bin/
   # Set GDAL_DATA environment variable to location
   # of supporting gdal files
   SetEnv GDAL_DATA "/ms4w/gdaldata"
   # Set GDAL_DRIVER_PATH environment variable for gdal plugins
   SetEnv GDAL_DRIVER_PATH "/ms4w/gdalplugins"
   # uncomment the following line to log MapServer errors to a file
   #SetEnv MS_ERRORFILE "/ms4w/tmp/ms_error.txt"

Configuring your MapServer WMS
==============================

The following section takes you through the exemplar service installed as part of the full download i.e. with Apache and MapServer (as part of MS4W) included.   We are assuming that you will install into the root directory of a drive as required of this installation; typically this will be c:\, with all the content created within a folder called ‘ms4w’ (e.g. c:\ms4w).  You do not need to create a folder called ‘ms4w’ as it is already part of the exemplar zip.  To configure your own service using this structure you will need to make changes in the following folders:

**C:\\ms4w\\apache\\cgi-bin\\** ~ you need to make a copy of the MapServer binaries and put them in a sub-folder with an alias name that conforms to the OneGeology WMS profile.  This will be your service URL.

**C:\\ms4w\\apps\\** ~ you need to create a sub-folder and add your data, service templates, and Mapfile.

**C:\\ms4w\\httpd.d\\** ~ you need to create an Apache .conf configuration file for your service, that follows the same naming convention as your service URL, and which maps together your app data and cgi service information.

You will also probably want to make changes in the following folder:

**C:\\ms4w\\apache\\htdocs\\** ~ html documents linking to your service

It is recommended you copy the exemplar data rather than modify it to ensure you always have a reference copy you can refer to and preview.

The first query a WMS client will send to a server is a GetCapabilities request.  In the response the server will supply information necessary for the client to know how many layers it is serving and how to retrieve them.  It will also supply human readable information that could be useful for humans to understand what data is being served, what limitations it has, what restrictions on use etc.  The way this information is viewable is dependent on the client, here we will just describe how you can make sure that it is included in the server response.  MapServer will generate much of this information automatically for you from the configuration of data layers you include but there are some extra WMS specific parameters to include filling in all the fields of a GetCapabilities response.  MapServer uses text configuration files called "Mapfiles" with a MapServer specific syntax to configure its web services.  The first main section is inside the <Service> element which can contain a variety of metadata, such as keywords and contact information about your WMS.  These are essentially all defined by corresponding fields in the MapServer Mapfile.  The next <Capability> section contains some essentially automatically generated <Request> specifications detailing what URLs to use for requesting maps, feature information etc., and a series of <Layer> elements inside one parent <Layer> which give some automatically generated and some WMS specifically configured data on each of your layers.  The example layers show exactly what parameters should be supplied for each layer; whilst   `Appendix G <appendixG.html>`_ (WMS version 1.1.1) and  `Appendix F <appendixF.html>`_ (WMS version 1.3.0) show how these relate to the appropriate GetCapabilities response.

Step-by-step configuration for MS4W
===================================








BGS exemplar service (SERVICE configuration)
============================================





Test your service
-----------------

Restart the Apache service using the Services control panel and then reload the http://localhost page in your browser.  You should get the index.html page with the link to your new service.  If you follow the link you should find a page with some test requests for some of the exemplar layer data.

Configure your new service
--------------------------

Next you need to configure your own data with the service.  You can use the example UK geology layers as a guide to creating your own shapefile based layers.  The BGS\_Bedrock\_Raster_Map directory provides a layer you can use as a guide for a raster file based layer.  The example uses an 8-bit palette PNG with transparent background and world file for georeferencing.  You could also use a 32-bit TIFF file with alpha layer transparency and world file for georeferencing or GeoTIFF file with georeferencing information incorporated inside the file.  Refer to the MapServer documentation for further details on raster formats or post a question to the OneGeology help forum if you have further questions.

You should remove the examples in your own folders and all the BGS\_Bedrock\_and\_Superficial_Geology files when you have finished i.e. make sure that you do not serve to the WWW the BGS dataset!  We will soon see if more than one web server is serving it!  The BGS 625k dataset and configuration is provided in the template application so that you can see everything that is required to set up a real OneGeology Level 1 WMS service including real metadata and example WMS service layer Names, Titles, Keywords etc.

First you should copy your source date (shapefiles or rasters) to your renamed version of the apps\ BGS_Bedrock_and_Superficial_Geology\data directory.  Next you need to edit the OneGeology Mapfile appropriately for your server.

You can refer to the full Mapfile for the BGS_Bedrock_and_Superficial_Geology service in `Appendix E <appendixE.html>`_.  You may also find the online `MapServer documentation <http://www.MapServer.org/documentation.html>`_ useful, to help you configure your service.

There are comments included to indicate where you need to edit values.  The important sections are reproduced below with comments.

You must then create "LAYER" sections for each map (e.g. Bedrock map, superficial geology map etc.) that you are going to serve.  The contents of these LAYER sections will depend on whether your data is in shapefile format or a raster image.  Examples are given below with comments where you will need to edit them according to your own data.

You may notice that in two of our example layers we have defined some ‘DUMMY’ classes.  This is a hack to work around a bug we found with Google Earth.  It should only affect you if you have layers with fewer than 16 classes.  If this is the case then read the comments in the Mapfile for an explanation and add some dummy classes to your own layers so that there are at least 16.

Also note that the example CLASS definitions do not have any polygon borders (no OUTLINECOLOR directive).  This is important as the different scales of viewing to be used within OneGeology mean that border lines would often obscure the polygons themselves.

You will also notice that we do not currently recommend enabling some capabilities in a WMS service such as setting Transparency (this can upset some WMS viewing clients and also other clients can allow the user to set the level of transparency interactively) and ScaleHint (this can upset several clients and make your service difficult to use in them).


