# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013, 2014 Kana Fukuma and Shane Coughlan
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

module TemplateSQL
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
end