print "Please input your Name: "
name = gets.chomp
date = "Frankfurt, " + Time.new.strftime("%Y-%m-%d ")
msg = "thanks for your message! I am currently unavailable
and cut off from email, but will be back in the office
by next Monday. I'll answer your message a.s.a.p."
puts date.rjust(50) , + "Dear " + name , msg , "Kind regards, \n Manuel Otto Santovenia"