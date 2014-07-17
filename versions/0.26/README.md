Data Twist
==========

An experimental script family to twist Open Data into new shapes.

Copyright (c) 2013, 2014 Kana Fukuma and Shane Coughlan

Overview
--------

Data Twist is a project to help people use Open Data to make directories.
It is a project that helps anyone create open versions of Yelp (tm) or
TripAdvisor (tm).

Data Twist acts a foundation for open directories by importing OpenStreetMap
XML data into Wordpress.

Data Twist has a few dependencies. One is Wordpress. Another is Geo Mashup, a
plug-in that allows you to store geo-references with each Wordpress post.

Usage
-----

<pre>
Usage overview: data-twist.rb [options]
    -g, --get FILE                   Get a file
    -l, --load FILE                  Load a file
    -o, --output FILE                Create the output file
    -h, --help                       Display this overview
    -v, --version                    Show the version number

Here are some example commands:
Get and automatically process a file with 'ruby data-twist.rb -g URL'
Convert data with 'ruby data-twist.rb -l [INPUT FILE] -o [OUTPUT]'
</pre>

If you fail to specify an output file the script will default to "output.sql"

After Data Twist processes the data, load "output.sql" into your Wordpress 
database:

(1) Drop the following tables from the Wordpress database to ensure it is
clean:
 - wp_geo_mashup_locations
 - wp_geo_mashup_location_relationships
 - wp_posts
 - wp_terms
 - wp_term_relationships
 - wp_term_taxonomy
(you can do this through your SQL web admin tools like phpMyAdmin)

(2) Import "output.sql" to load your directory

That's it! You should be ready to go!

Warning
-------

The current code is under rapid development. It probably has some bugs. If you
find one, please let us know.

If Data Twist sets fire to your house, chases your cat up a tree, or causes
you to quit computers and become a vegetable farmer, don't blame us.

License
-------

Data Twist is Free Software. You can call it Open Source too. Whatever you
prefer.

You can redistribute it and/or modify Data Twist under either the terms of the
2-clause BSDL (see the file BSDL), or the conditions listed in the LEGAL file.

There is some sample data from OpenStreetMap included to test the scripts.
OpenStreetMap is open data, licensed under the Open Data Commons Open
Database License (ODbL). Find out more about this license here:
http://opendatacommons.org/licenses/odbl/