# encoding: utf-8

 =begin
This is a Data Twist file
Experimental script to twist Open Data into new shapes

Copyright (c) 2013 Kana Fukuma and Shane Coughlan

Data Twist is Free Software. You might also call it Open Source.
You can redistribute it and/or modify it under either the terms of the
2-clause BSDL (see the file BSDL), or the terms listed in README.md
 =end

require 'uri' # uriライブラリ読み込み
require 'kconv' # cmdにREXMLでの処理結果の文字列を表示するためのライブラリ
require 'Date'

# input
def input
	count = 0
	array = []
	name = ""
	type = ""

	# filename input
	begin
		print "Please input filename: "
		filename = gets.chop
		#filename = "html01.txt"
		puts "filename:#{filename}\n"
	
		file = File.read(filename)
	rescue
		print "\n*** Error : Please one more again! ***\n"
		retry
	end
	
	print "\n------------\n\n"
	
	begin
		# read a line of the file
		file.each_line { |line|

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
					array << [type,name,desc]
				end
			end
		}
	rescue
		print "error"
	end
	
	print "\n------------\n\n"
	return array
end

def output(array)
	id = 1
	post_author = 1
	date1 = DateTime.now.strftime("%Y-%m-%d %S:%M:%H")
	date2 = DateTime.now.strftime("%Y/%m/%d")
	File.open("o_test03.xml","w") { |f|
		array.each { |a|
			e_title = a[1].downcase
			e_title.gsub!(" ","-")
			puts "e_title :#{e_title}"
			e_title = URI.escape(e_title)

			f.write "<table name=\"wp_4_posts\">\n"
			f.write "<column name=\"ID\">#{id}</column>\n"
			f.write "<column name=\"post_author\">#{post_author}</column>\n"
			f.write "<column name=\"post_date\">#{date1}</column>\n"
			f.write "<column name=\"post_date_gmt\">#{date1}</column>\n"
			f.write "<column name=\"post_content\">#{a[2]}</column>\n"
			f.write "<column name=\"post_title\">#{a[1]}</column>\n"
			f.write "<column name=\"post_excerpt\"></column>\n"
			f.write "<column name=\"post_status\">publish</column>\n"
            f.write "<column name=\"comment_status\">open</column>\n"
            f.write "<column name=\"ping_status\">open</column>\n"
            f.write "<column name=\"post_password\"></column>\n"
			f.write "<column name=\"post_name\">#{e_title}-#{id}</column>\n"
            f.write "<column name=\"to_ping\"></column>\n"
            f.write "<column name=\"pinged\"></column>\n"
            f.write "<column name=\"post_modified\">#{date1}</column>\n"
            f.write "<column name=\"post_modified_gmt\">#{date1}</column>\n"
            f.write "<column name=\"post_content_filtered\"></column>\n"
            f.write "<column name=\"post_parent\">0</column>\n"
            f.write "<column name=\"guid\">http://www.opendawn.com/test/geo1/#{date2}/#{e_title}-#{id}/</column>\n"
            f.write "<column name=\"menu_order\">0</column>\n"
            f.write "<column name=\"post_type\">post</column>\n"
            f.write "<column name=\"post_mime_type\"></column>\n"
            f.write "<column name=\"comment_count\">0</column>\n"
			f.write "</table>\n"

			id = id + 1
		}
	}
end

array = input
output(array)