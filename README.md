Data Twist
==========

An experimental script family to twist Open Data into new shapes.

Copyright (c) 2013 Shane Coughlan and Kana Fukuma

These scripts are designed to take OpenStreetMap XML data and import it
into a geo-aware version of Wordpress. This allows information like shops
and tourist locations to quickly populate directories, at least in
theory.

The initial focus is on allowing XAPI, OSM website XML downloads and
Osmosis node filters from a database to be converted into SQL files that
we can quickly load into a Wordpress install. There are some dependencies
at the moment, with the key item being the Geo Mashup plug-in for Wordpress
to allow us to store geo-references with each post.

There are three iterations of our experiments in the current repo.

The first is simpleXML2XML, where a Ruby script takes simple POI from a
Cloudmade download to transform the data into a format that allows import
through the Wordpress RSS import feature. This allowed import of items
that did not have duplicate titles, but ran into issue with the automatic
duplication filter used by Wordpress for RSS import.

The second is simpleXML2dbXML, an experiment to push the data directly into
a Wordpress MySQL database and avoid any duplication filters. This had
import errors with phpMyAdmin. Then we found that an export from the same
application failed to import too, so we decided it's probably better to
look for a more flexbile solution.

The third iteration is simpleXML2SQL, which allows us to convert the data
from OpenStreetMap into a format that can be imported into a Wordpress
database in several ways. It looks like a winner, and Kana included geo
awareness for the Geo Mashup plug-in.

Usage is pending. Probably input_[WHATEVER] input.filename export.filename
Current code is from a hack session and under rapid development.
Don't use with caution. Use with terror.

Data Twist is free software release by Shane Coughlan <shane@opendawn.com>.
You can redistribute it and/or modify it under either the terms of the
2-clause BSDL (see the file BSDL), or the conditions listed in the LEGAL
file.

There is some sample data from OpenStreetMap included to test the scripts.
OpenStreetMap is open data, licensed under the Open Data Commons Open
Database License (ODbL). Find out more about this license here:
http://opendatacommons.org/licenses/odbl/