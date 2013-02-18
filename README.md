Data Twist
==========

Experimental script to twist Open Data into new shapes

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

Usage is pending. Probably input_[WHATEVER] input.filename export.filename
Current code is from a hack session and under rapid development.
Don't use with caution. Use with terror.

Data Twist is free software release by Shane Coughlan <shane@opendawn.com>.
You can redistribute it and/or modify it under either the terms of the
2-clause BSDL (see the file BSDL), or the conditions listed in the LEGAL
file.