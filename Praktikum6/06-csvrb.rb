# !/usr/bin/env ruby
# Otto Santovenia, Luis Manuel Alfred, 1190173, 03.06.2021

data = []
csv = 
fl = File.open("marathon-ffm-2003.txt") 
fl.each {|line| data.append(line)}
regex = /(\D+?), (\D+?) ([A-Z]+ )?(W\d{2}|M\d{2}) (\d{2}) (\d+:\d+:\d+) (\d+:\d+:\d+) (\d+:\d+:\d+) (\d+:\d+:\d+) (\d+,\d+)(\D+)(\d+) (\d+) (\d+) (\d+) /
while data[0].size > 0
    match = data[0].match(regex)
    if match != nil
        match = match[0]
        match =~ regex
        data[0].slice! match
        File.write("res.csv", "#{$13};#{$12};#{$1}, #{$2};#{$3};#{$5};#{$11};#{$4};#{$14};#{$15};#{$7};#{$6};#{$8};#{$9};#{$10}\n", mode: "a")
    else
        puts "SRC file format is broken. Aborting. Exported Data will remain!"
        puts data[0][0...500]
        exit
    end
end