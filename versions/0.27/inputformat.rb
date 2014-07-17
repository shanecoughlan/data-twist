# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013, 2014 Kana Fukuma and Shane Coughlan
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

module InputFormat
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
	    term_count = [0,0,0] # [0] = shop_count, [1] = amenity_count, [2] = uncategorized
    
	    # filename input
	    begin
		    filename = inputfile
		    file = File.read(filename)
	    end
	    
	    # output to explain data twisting has started (データツイストを開始する説明を出力)
	    print "\n== Starting to twist data / データツイストの開始 ==\n\n"
	    
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
					    end
				    elsif line.match("k=\"amenity\"")
					    if /v="(.*)"/ =~ line
						    amenity = $1
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
					    
					    if shop != "" # shop
						    desc = shop
						    term = 3
						    term_count[0] = term_count[0]+1
					    elsif amenity != "" # amenity
						    desc = amenity
						    term = 4
						    term_count[1] = term_count[1]+1
					    else # uncategorized
						    term = 1
						    term_count[2] = term_count[2]+1
					    end
					    # this is the checking code to find duplicate latitude and longitude (重複する緯度・経度を見つけるためのチェックコード)
					    if (a = array.select{ |a| a[4] == lat && a[5] == lon}) == []
						    array << [type,name,desc,id,lat,lon,e_name,timestamp,term]
						    write_data = write_data + 1
					    else
						    #puts "duplication data:#{id},#{name},#{lat},#{lon}"
						    same_data = same_data + 1
					    end
					    # this is the progress feedback code (進行状況のフィードバックコード)
					    (write_data + same_data + 1).times do |processed|
					    print "\rLocations processed so far (Locationはこれまでに処理): #{processed}"
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
    
	    print "\n\n== Summary / 要約 ==\n"
	    puts "\nI found #{same_data} duplicate entries in the input file."
	    puts "入力ファイル内に#{same_data}個の重複したエントリを見つけました。"
	    puts "\nI wrote #{write_data} locations to the output file."
	    puts "出力ファイルに#{write_data}か所の情報を書きました。"
	    puts "\nI processed a total of #{same_data + write_data} locations during my analysis."
	    puts "分析中に合計#{same_data + write_data}個のエントリを処理しました。"
	    puts "\n"
	    return array,term_count
    end
end