#! /usr/bin/env ruby

# regex = ^\(\d+, '(.+?)', '(.+?)', '(.+?)', '(.+?)')
data = []
fl = File.open("db.sql")
fl.each { |line| data.append(line) }
data.each do |ln|
    ln =~ /^\(\d+, '(.+?)', '(.+?)', '(.+?)', '(.+?)'/
    $4
    File.write("pwdata", "#{$4}\n", mode: "a")
end


