Accreditation sections to be considered
=======================================

.. todo::

    remove this html section on accreditation, should probably go into profile section / or separate accreditation section


.. raw:: html

      <table class="reqdTable" id="projStarsTab">
      <tr><td><p><img src="/images/stars/requirement/2star.jpg" alt="2 star accreditation requirement" width="175" height="36" /><br />
      <label>2 star accreditation requirement</label></p></td>
      <td>

      For a 2 star accredited service ALL OneGeology layers must supply a LatLonBoundingBox defined using SRS EPSG:4326 [WGS1984 latitude/longitude].

      For a 2 star accredited service ALL OneGeology layers must support EPSG:4326.

      Each layer must supply a list of the SRS it supports
      </td>
      </tr>
      </table>

You can find out more information about `EPSG codes <http://www.epsg.org/>`_.  The file ms4w\proj\nad\EPSG in your MS4W distribution contains a list of EPSG codes and their projection parameters in a form that the PROJ library used by MapServer can understand.  Hopefully, this should cover all cases.  If you do not find your system there you could try looking in some of the other files in the "nad" directory and copying the appropriate line or following some of the links given in the MapServer FAQ at `where-do-i-find-my-epsg-code <http://www.MapServer.org/faq.html#where-do-i-find-my-epsg-code>`_.

The new version of the OneGeology Portal supports the display of a number of coordinate systems, not just the default EPSG:4326 and the suggested EPSG:3857. as below:

   EPSG:3031
      Antarctic Polar Stereographic (WGS84) `http://epsg.io/3031 <http://epsg.io/3031>`_
   EPSG:3034
      Lambert Conformal Conic (ETRS89) `http://epsg.io/3034 <http://epsg.io/3034>`_ (suitable for INSPIRE compliance)
   EPSG:3413
      NSIDC Sea Ice Polar Stereographic North (WGS84) `http://epsg.io/3413 <http://epsg.io/3413>`_
   EPSG:3857
      Web Mercator (WGS84) `http://epsg.io/3857 <http://epsg.io/3857>`_
   EPSG:4258
      2D Latitude / Longitude (ETRS89) `http://epsg.io/4258 <http://epsg.io/4258>`_ (suitable for INSPIRE compliance)
   EPSG:4326
      2D Latitude / Longitude (WGS84) `http://epsg.io/4326 <http://epsg.io/4326>`_

      So you may also want to add these coordinate systems to your service, if they are applicable to your service.
      


.. todo::

    remove this html section on accreditation, should probably go into profile section / or separate accreditation section

.. raw:: html

      <table class="reqdTable">
      <tr><td><p><img src="/images/stars/requirement/3star.jpg" alt="3 star accreditation requirement" width="175" height="36" /><br />
      <label>3 star accreditation requirement</label></p></td>
      <td><p>For a 3 star accredited service, where an age harmonization layer is defined, it must be based on the IUGS standards.<br />
      If you wish you are encouraged to go a step further and follow the GeoSciML-Portrayal schema, which would allow your age service to be queried and re-symbolized using CGI URI codes.</p></td>
      </tr></table>

See (`Section 7 <7_1.html>`_) for details on how to enable GeoSciML-Portrayal in your service.
