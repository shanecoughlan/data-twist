# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013, 2014 Kana Fukuma and Shane Coughlan
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

module OutputFormat
    def output(last_str,outputfile,array,term_count)
	    post_author = 1
	    count = 0
	    content = "<br/>[geo_mashup_map zoom=16]<br/><small>Geo-data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href=\"http://opendatacommons.org/licenses/odbl/\">Open Data Commons Open Database License</a> (ODbL)</small><br/>This entry was last updated: "
	    File.open(outputfile,"a") { |f|
		    
		    # write about the "wp_posts" file ("wp_posts"ファイルについて書きます)
		    f.write "--\n-- Dumping data for table `wp_posts`\n--\n\n"
		    f.write "INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES\n"
    
		    array.each { |a|
			    count = count + 1
			    f.write "(#{a[3]}, #{post_author}, '#{a[7]}', '#{a[7]}', '#{a[2]}#{content}#{a[7]}', '#{a[1]}', '', 'publish', 'open', 'open', '', '#{a[3]}', '', '', '#{a[7]}', '#{a[7]}', '', 0, 'http://www.opendawn.com/test/geo1/#{a[7][0..9].gsub!("-","/")}/#{a[3]}/', 0, 'post', '', 0)"
			    
			    f.write ",\n" if array.length != count
		    }
		    f.write ";\n\n"
		    
		    count = 0
		    # write about the "wp_geo_mashup_locations" file ("wp_geo_mashup_locations"ファイルについて書きます)
		    f.write "--\n-- Dumping data for table `wp_geo_mashup_locations`\n--\n\n"
		    f.write "INSERT INTO `wp_geo_mashup_locations` (`id`, `lat`, `lng`, `address`, `saved_name`, `geoname`, `postal_code`, `country_code`, `admin_code`, `sub_admin_code`, `locality_name`) VALUES\n"
		    
		    array.each { |a|
			    count = count + 1
			    f.write "(#{a[3]}, #{a[4]}, #{a[5]}, '', '#{a[6]}-#{a[3]}', NULL, '', '', '', NULL, '')"
			    
			    f.write ",\n" if array.length != count
		    }
		    f.write ";\n\n"
    
		    count = 0
		    # write about the "wp_geo_mashup_location_relationships" file ("wp_geo_mashup_location_relationships"ファイルについて書きます)
		    f.write "--\n-- Dumping data for table `wp_geo_mashup_location_relationships`\n--\n\n"
		    f.write "INSERT INTO `wp_geo_mashup_location_relationships` (`object_name`, `object_id`, `location_id`, `geo_date`) VALUES\n"
		    
		    array.each { |a|
			    count = count + 1
			    f.write "('post', #{a[3]}, #{a[3]}, '#{a[7]}')"
			    
			    f.write ",\n" if array.length != count
		    }
		    f.write ";\n\n"
    
		    count = 0
		    # write about the "wp_term_relationships" file ("wp_term_relationships"ファイルについて書きます)
		    f.write "--\n-- Dumping data for table `wp_term_relationships`\n--\n\n"
		    f.write "INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES\n"
		    
		    array.each { |a|
			    count = count + 1
			    f.write "(#{a[3]}, #{a[8]}, 0)"
			    f.write ",\n" if array.length != count
		    }
		    f.write ";\n\n"
    
		    count = 0
		    # write about the wp_term_taxonomy (wp_term_taxonomyについて書きます)
		    f.write "--\n-- Dumping data for table `wp_term_taxonomy`\n--\n\n"
		    f.write "INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES\n"
		    f.write "(1,1,'category','uncategorized',0,#{term_count[2]}),\n"
		    f.write "(3,3,'category','shop',0,#{term_count[0]}),\n"
		    f.write "(4,4,'category','amenity',0,#{term_count[1]});\n\n"
    
    
		    # write the last string (最後の文字列を書き込む)
		    last_str.each { |str|
			    f.write str
		    }
	    }
    end
end