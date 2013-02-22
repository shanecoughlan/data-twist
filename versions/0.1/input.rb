# encoding: utf-8

#require 'open-uri' # open-uriライブラリ読み込み
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
	File.open("o_test02.xml","w") { |f|
		array.each { |a|
			f.write "<item>\n"
			f.write "<pubDate>#{DateTime.now}</pubDate>\n"
			f.write "<category>#{a[0]}</category>\n" if a[0] != nil
			f.write "<title>#{a[1]}</title>\n"
			f.write "<content:encoded>#{a[2]}</content:encoded>\n"
			f.write "</item>\n"
		}
	}
end

array = input
output(array)