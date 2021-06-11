#! /usr/bin/env ruby
# Otto Santovenia, Luis Manuel Alfred, 1190173, 28.05.2021
#
# mit dem Script und einer entsprechenden Datei, ließen sich 71 Passwörter knacken
# jedoch wurde auch festgestellt, dass die häufigsten passwörter, wie 'password' durch das 
# Hashing auch in anderen Versionen akzeptiert werden, also kann auch 'password1' eingegeben werden
# zählt man diese Doppelungen mit, wurden 250+ Matches gefahren
def pw_printer(name,pw)
  puts "Found a match!:","User #{name} choose the Password '#{pw}'","++++++++++++++++++++++++++++"
  #File.write("log.txt", "Found a match!:\nUser #{name} choose the Password '#{pw}'\n++++++++++++++++++++++++++++\n", mode: "a")
end
puts "Enter 'quit' to quit"
pw_data = []
fl = File.open("passwd_sim") 
fl.each {|line| pw_data.append(line)}
while input = gets
  password = input =~/\s/ ? input.gsub(/\s+/,"") : input
  if password.upcase == 'QUIT'
    break
  end
  pw_data.each do |ln|
    ln =~ /([\w]+):([\S]+?):/
    pw_printer($1,password) if $2 == password.crypt($2[0..1])
  end
end
fl.close
