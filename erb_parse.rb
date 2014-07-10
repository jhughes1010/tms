#James Hughes
#erb parser

 Dir.glob('**/*.html.erb').each do|f|
 puts f
 

noWhitespace = ""
File.open( f ).each do |line|
    noWhitespace << line.strip.gsub(/\r\n?/, "")
end
noWhitespace.gsub!("<","\n<")
noWhitespace.gsub!(">",">\n")
noWhitespace.gsub!("\n\n","\n")
noWhitespace.lstrip!
txt = noWhitespace.split(/\n/)
#print txt
indentLevel = 0
indentSpacing = 4

txt.each do |line|
	if line["</"]
		indentLevel -= 1
	end
	spaces = indentLevel * indentSpacing
	#puts spaces
	if spaces >0
		for ln in 0..spaces
			print " "
		end
	end
	puts line		
	if line["<"]
		unless line["</"]
			unless line["<%"]
				indentLevel += 1
			end
		end
	end
	if line["hr"]
		indentLevel -= 1
	end
end
end
