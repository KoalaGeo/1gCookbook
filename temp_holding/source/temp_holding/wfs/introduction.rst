Introduction
============

This guidance describes how to set up a web service using free and open source Geoserver software to provide a OneGeology compliant ISO/OGC Web Feature Service (WFS) version 2.0 serving GeoSciML v4.1 as described in the `GeoSciML Encoding Cookbook <http://onegeology.org/docs/technical/GeoSciML_Cookbook_1.3.pdf>`_.  A WFS setup using the encoding guidance in the Encoding Cookbook will enable the service to be used and queried using the OneGeology portal age and lithology WFS query tool, thus enabling the service to achieve 5 star accreditation. 

If you follow the INSPIRE specific instructions described within the text you will also have an INSPIRE compliant WFS. This will implement the WFS functionality described in chapters 6 and 7 of the latest `Technical Guidance for the implementation of INSPIRE Download Services <http://inspire.jrc.ec.europa.eu/documents/Network_Services/Technical_Guidance_Download_Services_v3.1.pdf>`_. This is entirely optional for OneGeology so you can ignore the INSPIRE sections if this is not of interest to you.

The guidance includes example data and configuration files that can be used to create running Open GeoSpatial Consortium (OGC) Web Feature Services (WFS) that deliver data in `GeoSciML <http://www.opengeospatial.org/standards/geosciml>`_. This example illustrates aspects of service and data configuration that should help the reader to set up services using their own data. The example also shows how this can be simplified to deliver data conforming to the `INSPIRE Geology theme schema <http://inspire.ec.europa.eu/schemas/ge-core/3.0/GeologyCore.xsd>`_.

Pre-requisites / System Requirements
------------------------------------

The cookbook is technical and some assumptions are made about the reader's background knowledge:

* The reader is a, or is working closely with an expert in the data model and schema for GeoSciML who has read the sister cookbook to this one first - `GeoSciML Encoding Cookbook <http://onegeology.org/docs/technical/GeoSciML_Cookbook_1.3.pdf>`_
* The reader has some familiarity with setting up web servers and preferably Java servlet containers.
* The reader is able to install software on their machine and can follow the appropriate installation instructions for PostgreSQL, PostGIS and GeoServer documented on the websites for that software.

To set up a production WFS you will need server equipment to run your database and GeoServer. Estimating the level of hardware resources required to support a responsive service is a complex task depending on the amount of your data, its complexity and the demand that will be placed on your service by users. It is out of the scope of this document to give advice on these issues but you can find some assistance from the GeoServer web site and mailing list. To test setting up a service using the example in this guide a modern PC with Intel Core or equivalent processor and 4Gb RAM should certainly be adequate and you can probably get away with less.

The software required includes the PostgreSQL database with PostGIS spatial extensions, Java, a Java servlet container such as Apache Tomcat, and GeoServer itself. If you use one of the GeoServer packages that include Jetty then you won't need to install a servlet container separately. There are a lot of different versions and all these software packages are continuously updated. You may have conditions specific to your site which make particular versions preferable. For example, you may already have your data in a different database system such as Oracle Spatial rather than PostGIS. It isn't possible to cover all possible set ups here. Below are the specific software versions we have used to test the contents of this cookbook.

===================  ==========  =======  ====  ============
Operating system     PostgreSQL  PostGIS  Java  GeoServer
===================  ==========  =======  ====  ============
Windows Server 2008         9.3      2.1     8         2.7.2
CentOS 7                    9.4     2.94     8  2.8.5, 2.9.1
===================  ==========  =======  ====  ============

The guidance in this cookbook should also work with other versions of the software possibly with minor modifications. You should use GeoServer v2.7 or later to get support for WFS 2.0 features such as paging. v2.4.5 was the earliest version we have successfully used without significant bugs in the complex feature support. Specific GeoServer versions have specific requirements of the version of Java that they will work with. You should check `<http://docs.geoserver.org/stable/en/user/production/java.html#production-java>`_ for the current recommendations. For GeoServer 2.7 at least Java 7 (a.k.a. 1.7) is required and Java 8 seems to work without problems.
