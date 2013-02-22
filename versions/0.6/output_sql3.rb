# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013 Kana Fukuma and Shane Coughlan
# Version 0.6
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

require 'uri'
require 'kconv'
require 'Date'


# input
def input(inputfile)
	# initialize
	count = 0
	array = []
	id = 0
	name = ""
	desc = ""
	lat = 0.0
	lon = 0.0
	type = ""
	timestamp = ""
	flag = false

	# filename input
	begin
		#print "Please input filename: "
		#filename = gets.chop
		filename = inputfile
		#puts "filename:#{filename}\n"
	
		file = File.read(filename)
	rescue
		print "\n*** Error : Please one more again! ***\n"
		retry
	end
	
	print "\n------------\n\n"
	
	begin
		# read a line of the file
		file.each_line { |line|

			# id, lat and lon
			if line.match("<node id=")
				unless line.match("/>")
					if /id="(.*)" v(.*) timestamp="(.*)" uid(.*) lat="(.*)" lon="(.*)"/ =~ line
						id = $1
						timestamp = $3
						lat = $5
						lon = $6
						flag = true
					elsif /id="(.*)" lat="(.*)" lon="(.*)" user(.*) timestamp="(.*)"/ =~ line
						id = $1
						lat = $2
						lon = $3
						timestamp = $5
						flag = true
					end
				end
			end
			
			if flag
				# name
				if line.match("k=\"name\"") 
					if /v="(.*)"/ =~ line
						name = $1
					end
				end
				
				# desc
				if line.match("k=\"amenity\"")
					if /v="(.*)"/ =~ line
						desc = $1
					end
				end
			end

			# array
			if line.match("</node>")
				if name != ""
					e_name = name.downcase
					e_name.gsub!(" ","-")
					e_name = URI.escape(e_name)
					timestamp.gsub!("T", " ")
					timestamp.gsub!("Z", " ")
					array << [type,name,desc,id,lat,lon,e_name,timestamp]
					print "."
				end

				# initialize
				id = 0
				name = ""
				desc = ""
				lat = 0.0
				lon = 0.0
				type = ""
				timestamp = ""
				flag = false
			end
		}
	rescue
		print "error"
	end

	print "\n------------\n\n"
	return array
end

# copy sql_format
def copy_format(new_file)
	filename = "sql_format.sql" # format_file
	last_str = []
	num = 0

	# file copy
	file = File.read(filename)
	File.open(new_file,"w"){ |output|
		file.each_line { |input|
			if input.include?("=@OLD") # catch the last string
				last_str << input
			else
				output.write input # write the output file
			end
		}
	}
	return last_str
end

# output
def output(last_str,outputfile,array)
	post_author = 1
	count = 0
	content = "<br/>[geo_mashup_map zoom=16]<br/><small>Geo-data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href=\"http://opendatacommons.org/licenses/odbl/\">Open Data Commons Open Database License</a> (ODbL)</small><br/>This entry was last updated: "
	File.open(outputfile,"a") { |f|
		
		# write about the "wp_posts" file
		f.write "--\n-- Dumping data for table `wp_posts`\n--\n\n"
		f.write "INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES\n"

		array.each { |a|
			count = count + 1
			f.write "(#{a[3]}, #{post_author}, '#{a[7]}', '#{a[7]}', '#{a[2]}#{content}#{a[7]}', '#{a[1]}', '', 'publish', 'open', 'open', '', '#{a[6]}-#{a[3]}', '', '', '#{a[7]}', '#{a[7]}', '', 0, 'http://www.opendawn.com/test/geo1/#{a[7][0..9].gsub!("-","/")}/#{a[6]}-#{a[3]}/', 0, 'post', '', 0)"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"
		
		count = 0
		# write about the "wp_geo_mashup_locations" file
		f.write "--\n-- Dumping data for table `wp_geo_mashup_locations`\n--\n\n"
		f.write "INSERT INTO `wp_geo_mashup_locations` (`id`, `lat`, `lng`, `address`, `saved_name`, `geoname`, `postal_code`, `country_code`, `admin_code`, `sub_admin_code`, `locality_name`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			f.write "(#{a[3]}, #{a[4]}, #{a[5]}, '', '#{a[6]}-#{a[3]}', NULL, '', '', '', NULL, '')"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"

		count = 0
		# write about the "wp_geo_mashup_location_relationships" file
		f.write "--\n-- Dumping data for table `wp_geo_mashup_location_relationships`\n--\n\n"
		f.write "INSERT INTO `wp_geo_mashup_location_relationships` (`object_name`, `object_id`, `location_id`, `geo_date`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			f.write "('post', #{a[3]}, #{a[3]}, '#{a[7]}')"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"

		# write the last string
		last_str.each { |str|
			f.write str
		}
	}
end
#inputfile = "test-mapquest-xapi-london-amenity-wildcard-data-big.osm" # -> sql5
#inputfile = "osm-website-central-matsue.osm.xml" # -> sql6
inputfile = "osm-website-central-matsue-min.osm.xml"
outputfile = "o_sql07.sql"
array = input(inputfile)
last_str = copy_format(outputfile)
output(last_str,outputfile,array)