# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013 Kana Fukuma and Shane Coughlan
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

# required Ruby componants (必要なRubyのcomponants)
require 'uri'
require 'kconv'
require 'Date'
require 'optparse'
require 'open-uri'

# set the program name, version and copyright (プログラム名、バージョン、および著作権を設定する)
$PROGRAM_NAME = 'Data Twist'
$PROGRAM_VERSION = '0.17'
$PROGRAM_COPYRIGHT = 'Copyright (c) 2013 Kana Fukuma and Shane Coughlan'
$PROGRAM_COPYRIGHT_JA = '著作権 (c) 2013 福間加菜とコークラン クェーン マーティン'
$PROGRAM_LICENSE = 'This application is licensed under Ruby + BSDL. See README.md for details.'
$PROGRAM_LICENSE_JA = 'このアプリケーションはルビー+ BSDL下でライセンスされています. 詳細についてはREADME.mdを参照してください。'

# input
def input(inputfile)
	# initialize the script (スクリプトを初期化)
	count = 0
	array = []
	id = 0
	name = ""
	desc = ""
	lat = 0.0
	lon = 0.0
	type = ""
	timestamp = ""
	shop = ""
	amenity = ""
	flag = false
	same_data = 0
	write_data = 0
	all = 0
	term = 0
	term_count = [0,0] # [0] = shop_count, [1] = amenity_count

	# filename input
	begin
		filename = inputfile
		file = File.read(filename)
	end
	
	print "\n------------\n\n"
	
#	begin
		# read a line from the file
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
				if line.match("k=\"shop\"")
					if /v="(.*)"/ =~ line
						shop = $1
						term_count[0] = term_count[0]+1
					end
				elsif line.match("k=\"amenity\"")
					if /v="(.*)"/ =~ line
						amenity = $1
						term_count[1] = term_count[1]+1
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
					if shop != ""
						desc = shop
						term = 3
					elsif amenity != ""
						desc = amenity
						term = 4
					else
						term = 0
					end
					if (a = array.select{ |a| a[4] == lat && a[5] == lon}) == []
						array << [type,name,desc,id,lat,lon,e_name,timestamp,term]
						write_data = write_data + 1
					else
						#p a
						#puts "duplication data:#{id},#{name},#{lat},#{lon}"
						same_data = same_data + 1
					end
					# this is the progress feedback code (これは進行状況のフィードバック·コードです)
					(write_data + same_data + 1).times do |processed|
					print "\rLocations processed so far: #{processed}"
					end
				end

				# initialize
				id = 0
				name = ""
				desc = ""
				lat = 0.0
				lon = 0.0
				shop = ""
				amenity = ""
				term = 0
				type = ""
				timestamp = ""
				flag = false
				
			end
		}
	#  this was commented out because it caused an error loop? Please review. (それはエラーループが発生したため、これはコメントアウトされたのですか？レビューをしてください。)
	#rescue
	#	print "error"
	#end

	print "\n\n== Summary ==\n"
	puts "I found #{same_data} duplicate entries in the input file."
	puts "I wrote #{write_data} locations to the output file."
	puts "I processed a total of #{same_data + write_data} locations during my analysis."
	return array,term_count
end

# gets the sql format information (SQL形式の情報を取得します)
def copy_format(new_file)
	filename = "sql_format.sql" # Sets the SQL format filename (SQL形式のファイル名を設定します)
	last_str = []
	num = 0

	# file copy
	file = File.read(filename)
	File.open(new_file,"w"){ |output|
		file.each_line { |input|
			if input.include?("=@OLD") # catches the last string (最後の文字列をキャッチ)
				last_str << input
			else
				output.write input # writes the output file (出力ファイルを書き込み)
			end
		}
	}
	return last_str
end

# output
def output(last_str,outputfile,array,term_count)
	post_author = 1
	count = 0
	content = "<br/>[geo_mashup_map zoom=16]<br/><small>Geo-data from OpenStreetMap. &copy; OpenStreetMap contributors. OpenStreetMap is <i>open data</i>, licensed under the <a href=\"http://opendatacommons.org/licenses/odbl/\">Open Data Commons Open Database License</a> (ODbL)</small><br/>This entry was last updated: "
	File.open(outputfile,"a") { |f|
		
		# write about the "wp_posts" file ("wp_posts"ファイルについて書く)
		f.write "--\n-- Dumping data for table `wp_posts`\n--\n\n"
		f.write "INSERT INTO `wp_posts` (`ID`, `post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES\n"

		array.each { |a|
			count = count + 1
			f.write "(#{a[3]}, #{post_author}, '#{a[7]}', '#{a[7]}', '#{a[2]}#{content}#{a[7]}', '#{a[1]}', '', 'publish', 'open', 'open', '', '#{a[3]}', '', '', '#{a[7]}', '#{a[7]}', '', 0, 'http://www.opendawn.com/test/geo1/#{a[7][0..9].gsub!("-","/")}/#{a[3]}/', 0, 'post', '', 0)"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"
		
		count = 0
		# write about the "wp_geo_mashup_locations" file ("wp_geo_mashup_locations"ファイルについて書く)
		f.write "--\n-- Dumping data for table `wp_geo_mashup_locations`\n--\n\n"
		f.write "INSERT INTO `wp_geo_mashup_locations` (`id`, `lat`, `lng`, `address`, `saved_name`, `geoname`, `postal_code`, `country_code`, `admin_code`, `sub_admin_code`, `locality_name`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			f.write "(#{a[3]}, #{a[4]}, #{a[5]}, '', '#{a[6]}-#{a[3]}', NULL, '', '', '', NULL, '')"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"

		count = 0
		# write about the "wp_geo_mashup_location_relationships" file ("wp_geo_mashup_location_relationships"ファイルについて書く)
		f.write "--\n-- Dumping data for table `wp_geo_mashup_location_relationships`\n--\n\n"
		f.write "INSERT INTO `wp_geo_mashup_location_relationships` (`object_name`, `object_id`, `location_id`, `geo_date`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			f.write "('post', #{a[3]}, #{a[3]}, '#{a[7]}')"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"

		count = 0
		# write about the "wp_term_relationships" file ("wp_term_relationships"ファイルについて書く)
		f.write "--\n-- Dumping data for table `wp_term_relationships`\n--\n\n"
		f.write "INSERT INTO `wp_term_relationships` (`object_id`, `term_taxonomy_id`, `term_order`) VALUES\n"
		
		array.each { |a|
			count = count + 1
			f.write "(#{a[3]}, #{a[8]}, 0)"
			
			f.write ",\n" if array.length != count
		}
		f.write ";\n\n"

		count = 0
		# write about the wp_term_taxonomy (wp_term_taxonomyについて書く)
		f.write "--\n-- Dumping data for table `wp_term_taxonomy`\n--\n\n"
		f.write "INSERT INTO `wp_term_taxonomy` (`term_taxonomy_id`, `term_id`, `taxonomy`, `description`, `parent`, `count`) VALUES\n"
		
		f.write "(3,3,'category','shop',0,#{term_count[0]}),\n"
		f.write "(4,4,'category','amenity',0,#{term_count[1]});\n\n"


		# write the last string (最後の文字列を書き込む)
		last_str.each { |str|
			f.write str
		}
	}
end

def check_same_place(array)
	array.each{ |a|
		latlon << [a[4],a[5]]
	}
	
end

# check the command line for options (オプションについては、コマンドラインを確認)
options = {}
QA = OptionParser.new do |opts|
	
  # prepares an overview banner for the --help switch (helpスイッチの概要バナーを準備)
	opts.banner = "\nUsage overview (使用方法の概要): data-twist.rb [options]"
	
  # gets a file
  	options[:load_file] = "" # code to load a file based on command line input (ファイルをロードするためのコードでは、コマンドラインの入力に基づいて、)
		opts.on( '-g', '--get FILE', 'Get file (ファイルを取得)' ) do|urls|
		# code below is from here (以下のコードは、ここからです):
		# http://www.ruby-forum.com/topic/92121#183390

		BUFFER_SIZE = 8 * 1_024

		urls.each do |url|
		  puts "Downloading from #{url}"
		  output_file = url.split(/\//).last
		  puts "Creating a new file called #{output_file}"

		  open(url, "r",
		       :content_length_proc => lambda {|content_length| puts "This file is #{content_length} bytes long." },
		       :progress_proc => lambda { |size| printf("I am downloading it now: %010d bytes\r", size.to_i) }) do |input|
		    open(output_file, "wb") do |output|
		      while (buffer = input.read(BUFFER_SIZE))
		        output.write(buffer)
		      end
		    end
		  end
		  puts "\nOK, the download is complete."
		end
		puts "Please unzip the downloaded file before loading it into Data Twist."
		puts "You can get help by typing 'ruby data-twist.rb -h'"
		exit
	end
    
  # takes the input file name (入力ファイル名を受け取り、)
	options[:load_file] = ""
		opts.on( '-l', '--load FILE', 'Load file (ファイルを読み込む)' ) do|load_file|
		options[:load_file] = load_file
	end

  # takes the output file name (出力ファイル名を受け取り、)
	options[:output_file] = ""
		opts.on( '-o', '--output FILE', 'Create output file (出力ファイル名)' ) do|output_file|
		options[:output_file] = output_file
	end 
   
  # displays the help screen (ヘルプ画面が表示されます)
	opts.on( '-h', '--help', 'Show this overview (この概要を表示)' ) do
		puts opts
		puts   ""
		puts   "Example commands (コマンドの例):"
		puts   "\nGet a file with 'ruby data-twist.rb -g URL'"
		puts   "'ruby data-twist.rb -g URL'を使用してファイルを取得する"
		puts   "\nConvert data with 'ruby data-twist.rb -l [INPUT FILE] -o [OUTPUT]'"
		puts   "'ruby data-twist.rb -l [INPUT FILE] -o [OUTPUT]'を使用してデータを変換します"
		puts   ""
		exit
	end
	
  # shows the version, copyright and license (示しバージョン、著作権とライセンス)
	opts.on( '-v', '--version', 'Show the version (バージョンを表示)' ) do
		puts "\nYou are using #{$PROGRAM_NAME} #{$PROGRAM_VERSION}"
		puts "あなたは、#{$PROGRAM_NAME} #{$PROGRAM_VERSION}を使用している"
		puts "\n#{$PROGRAM_COPYRIGHT}"
		puts "#{$PROGRAM_COPYRIGHT_JA}"
		puts "\n#{$PROGRAM_LICENSE}"
		puts "#{$PROGRAM_LICENSE_JA}"
		exit
	end
	
end.parse!

  # check to deal with a missing input file name (不足している入力ファイル名に対処するためにチェック)
	if options[:load_file].empty?
		then
		puts "\nI cannot see the input file. Please try again."
		puts "\nYou can get help by typing 'ruby data-twist.rb -h'"
		puts "\n"
		exit
	end
		
  # check to insert a default output file name if needed (必要に応じて、デフォルトの出力ファイル名を挿入するにチェック)
	if options[:output_file].empty?
		then options[:output_file] = "output.sql"
	end

# next line takes values from (次の行では、から値を取得): options[:load_file]
inputfile = "#{options[:load_file]}"
# next line takes values from (次の行では、から値を取得): options[:output_file]
outputfile = "#{options[:output_file]}" 
array,term_count = input(inputfile)
last_str = copy_format(outputfile)
output(last_str,outputfile,array,term_count)