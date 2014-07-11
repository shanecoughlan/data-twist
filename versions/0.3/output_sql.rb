# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013 Kana Fukuma and Shane Coughlan
# Version 0.3
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

require 'uri' # uriライブラリ読み込み
require 'kconv' # cmdにREXMLでの処理結果の文字列を表示するためのライブラリ
require 'Date'


# input
def input
	count = 0
	array = []
	id = 25
	name = ""
	type = ""
	lat = 0.0
	lon = 0.0

	# filename input
	begin
		#print "Please input filename: "
		#filename = gets.chop
		filename = "i_test02.txt"
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
			# lat and lon
			if line.match("<wpt lat=")
				if /lat="(.*)" lon="(.*)"/ =~ line
					lat = $1
					lon = $2
				end
			end
			
			# name
			if line.match("<name>") 
				if />(.*):(.*)</ =~ line
					type = $1
					name = $2
					puts "name: " + name.tosjis
					puts "type: " + type.tosjis
				elsif />(.*)</ =~ line
					name = $1
					type = $1
					puts "name: " + name.tosjis
					puts "type: " + type.tosjis
				end
			end
			
			# desc and type
			if line.match("<desc>")
				if />(.*)</ =~ line
					desc = $1
					puts "desc: " + desc.tosjis
					array << [type,name,desc,id,lat,lon]
					id = id + 1
				end
			end
		}
	rescue
		print "error"
	end

	print "\n------------\n\n"
	return array
end

# copy_format
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

def output(last_str,outputfile,array)
	#id = 20
	post_author = 1
	count = 0
	date1 = DateTime.now.strftime("%Y-%m-%d %S:%M:%H")
	date2 = DateTime.now.strftime("%Y/%m/%d")
	File.open(outputfile,"a") { |f|
		
		# write about "wp_posts" file
		f.write "--\n-- Dumping data for table `wp_posts`\n--\n\n"
		f.write "INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES\n"

		array.each { |a|
			e_title = a[1].downcase
			e_title.gsub!(" ","-")
			puts "e_title :#{e_title}"
			e_title = URI.escape(e_title)
			id = a[3]

			count = count + 1
			f.write "(#{id}, #{post_author}, '#{date1}', '#{date1}', '#{a[2]}', '#{a[1]}', '', 'publish', 'open', 'open', '', '#{e_title}-#{id}', '', '', '#{date1}', '#{date1}', '', 0, 'http://www.opendawn.com/test/geo1/#{date2}/#{e_title}-#{id}/', 0, 'post', '', 0)"
			
			f.write ",\n" if array.length != count
			#id = id + 1
		}
		f.write ";\n\n"
		
		count = 0
		# write about "wp_geo_mashup_locations" file
		f.write "--\n-- Dumping data for table `wp_geo_mashup_locations`\n--\n\n"
		f.write "INSERT INTO `wp_geo_mashup_locations` (`id`, `lat`, `lng`, `address`, `saved_name`, `geoname`, `postal_code`, `country_code`, `admin_code`, `sub_admin_code`, `locality_name`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			id = a[3]
			f.write "(#{id}, #{a[4]}, #{a[5]}, '', '#{a[1]}', NULL, '', '', '', NULL, '')"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"

		count = 0
		# write about "wp_geo_mashup_location_relationships" file
		f.write "--\n-- Dumping data for table `wp_geo_mashup_location_relationships`\n--\n\n"
		f.write "INSERT INTO `wp_geo_mashup_location_relationships` (`object_name`, `object_id`, `location_id`, `geo_date`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			id = a[3]
			f.write "('post', #{id}, #{id}, '#{date1}')"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"
		last_str.each { |str|
			f.write str
		}
	}
end

outputfile = "o_sql02.sql"
array = input
last_str = copy_format(outputfile)
output(last_str,outputfile,array)