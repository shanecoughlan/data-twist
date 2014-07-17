# encoding: utf-8

# This is a Data Twist file
# Experimental script to twist Open Data into new shapes
# Copyright (c) 2013, 2014 Kana Fukuma and Shane Coughlan
# 
# Data Twist is Free Software. You might also call it Open Source.
# You can redistribute it and/or modify it under either the terms of the
# 2-clause BSDL (see the file BSDL), or the terms listed in README.md

# required Ruby componants (必要なRubyのcomponants)
require 'uri'
require 'kconv'
require 'date'
require 'optparse'
require 'open-uri'

# set the program name, version and copyright (プログラム名、バージョン、および著作権を設定する)
$PROGRAM_NAME = 'Data Twist'
$PROGRAM_VERSION = '0.26'
$PROGRAM_COPYRIGHT = 'Copyright (c) 2013, 2014 Kana Fukuma and Shane Coughlan'
$PROGRAM_COPYRIGHT_JA = '著作権 (c) 2013, 2014 福間加菜とコークラン クェーン マーティン'
$PROGRAM_LICENSE = 'This application is licensed under Ruby + BSDL. See README.md for details.'
$PROGRAM_LICENSE_JA = 'このアプリケーションはルビー+ BSDL下でライセンスされています. 詳細についてはREADME.mdを参照してください。'

# get the input format information (入力フォーマット情報を取得する)
require "./inputformat"	#call inputformat.rb (呼び出すinputformat.rb)
include InputFormat 	#run inputformat.rb (始めるinputformat.rb)

# set the SQL template (SQLテンプレートを設定する)
require "./templatesql"	#call templatesql.rb (呼び出すtemplatesql.rb)
include TemplateSQL 	#run templatesql.rb (始めるtemplatesql.rb)

# get the output format information (出力フォーマット情報を取得する)
require "./outputformat"#call outputformat.rb (呼び出すoutputformat.rb)
include OutputFormat 	#run outputformat.rb (始めるoutputformat.rb)

# check the command line for options (オプションについては、コマンドラインを確認)
options = {}
QA = OptionParser.new do |opts|
	
  # prepares an overview banner for the --help switch (helpスイッチの概要バナーを準備)
	opts.banner = "\nUsage overview (使用方法の概要): data-twist.rb [options]"
	
  # gets a file
  	options[:get_file] = "" # code to get a file based on command line input (コマンドラインの入力に基づいて、ファイルを取得するためのコード)
		opts.on( '-g', '--get FILE', 'Get file (ファイルを取得)' ) do|get_file|

		# sets a buffer size (バッファサイズを設定します)
		BUFFER_SIZE = 8 * 1_024

		# gets the file and names it according to the end of the URL (ファイルを取得し、URLの末尾に応じてそれに名前を付ける)
		puts "\nDownloading from (ダウンロード) #{get_file}"
		downloaded_file = get_file.split(/\//).last
		# output to the user to confirm this (これを確認するためのユーザへの出力)
		puts "Creating (作成): #{downloaded_file}"

		# checks remote file size and shows download progress (リモート·ファイル·サイズをチェックして、ダウンロードの進行状況を示しています)
		open(get_file, "r",
		     :content_length_proc => lambda {|content_length| puts "\nSize in bytes (バイト単位のサイズ): #{content_length}" },
		     :progress_proc => lambda { |size| printf("Downloaded (ダウンロード): %010d bytes\r", size.to_i) }) do |input|
		  # writes the downloaded file (ダウンロードしたファイルを書き込む)
		  open(downloaded_file, "wb") do |output|
		    while (buffer = input.read(BUFFER_SIZE))
		      output.write(buffer)
		    end
		  end
		  # prepares to name the decompressed file based on the downloaded file (ダウンロードしたファイルに基づいて、解凍したファイルに名前を付けるための準備)
		  decompressed_file = downloaded_file.split(".").first(2).join(".")
		  # decompresses the downloaded file (ダウンロードしたファイルを解凍)
		  system *%W(bzip2 -d #{downloaded_file})
		  # making sure to carry the decompressed file name to the end of the script (スクリプトの最後に解凍されたファイル名を運ぶことを確認すること)
		  options[:get_file] = decompressed_file
		end
		# end message for the get and decompress section (取得し、セクションを解凍するための終了メッセージ)
		puts "\n\nThe download is complete."
		puts "ダウンロードが完了しました。"
	end
    
  # takes the input file name (入力ファイル名を受け取る)
	options[:load_file] = ""
		opts.on( '-l', '--load FILE', 'Load file (ファイルを読み込む)' ) do|load_file|
		options[:load_file] = load_file
	end

  # takes the output file name (出力ファイル名を受け取る)
	options[:output_file] = ""
		opts.on( '-o', '--output FILE', 'Create output file (出力ファイル名)' ) do|output_file|
		options[:output_file] = output_file
	end 
   
  # displays the help screen (ヘルプ画面を表示)
	opts.on( '-h', '--help', 'Show this overview (概要を表示)' ) do
		puts opts
		puts   ""
		puts   "Example commands (コマンドの例):"
		puts   "\nGet a file with 'ruby data-twist.rb -g URL'"
		puts   "'ruby data-twist.rb -g URL'を使用してファイルを取得する"
		puts   "\nConvert data with 'ruby data-twist.rb -l [INPUT FILE] -o [OUTPUT]'"
		puts   "'ruby data-twist.rb -l [INPUT FILE] -o [OUTPUT]'を使用してデータを変換する"
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
		# checking to see if a file was downloaded
		then options[:load_file] = "#{options[:get_file]}"
			# if not the string is still empty and Data Twist exists with an error
			if options[:load_file].empty?
				puts "\nI cannot see the input file. Please try again."
				puts "\n私は、入力ファイルを見ることができません。もう一度やり直してください。"
				puts "\nYou can get help by typing 'ruby data-twist.rb -h'"
				puts "\nあなたは、'ruby data-twist.rb -h'を入力してヘルプを表示することができます"
				puts "\n"
				exit
				# if the string had a value Data Twist continues
				else
			end
	end
		
  # check to insert a default output file name if needed (必要に応じて、デフォルトの出力ファイル名を挿入することをチェック)
	if options[:output_file].empty?
		then options[:output_file] = "output.sql"
	end

# next line takes values from (次の行では、次の値を取得): options[:load_file]
inputfile = "#{options[:load_file]}"

# next line takes values from (次の行では、次の値を取得): options[:output_file]
outputfile = "#{options[:output_file]}" 
array,term_count = input(inputfile)
last_str = copy_format(outputfile)
output(last_str,outputfile,array,term_count)