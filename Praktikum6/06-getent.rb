#!/usr/bin/env ruby
# Otto Santovenia, Luis Manuel Alfred, 1190173, 28.05.21

=begin
Aufgaben A & B

A1:
/x.+y.*z/
 - x y z
 - xasdfjkyasdfjkz
 - xxxyyyzzz
A2:
/\d{3,}[.,]?\d*/
 - 100,5
 - 111111.6
 - 348290,234578
A3:
/\BB/
 - bB
 - adsfklB
 - 123B
A4:
/(\||\+)(.*?)\1/
 - |a|
 - +asd fjk+


B1:
/(.+),.+(\d{2}.\d{2}.\d{2,4})/
- Wiesbaden, den 21.05.21
- Köln, den 01.12.2020
- Frankfurt am Main, den 01.12.2020

B2:
/(-|)(\d+)(,|)(\d+|)(-|)/
- 123
- 123,55
- 123,555
- -123
- -123,55
- -123,555
- 123-

=end
class Passwords
  def initialize()
  $output = `getent passwd`
  end
  def print_hash(hash)
    puts"_____________________________"
    puts "|    Group    | # of Users  |"

    hash.each do |key, value| 
      puts "|    %5d    |    %5d    |" % [key,value]
    end
    puts " ▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔"
  end 
  def compute()
    nonBash = []
    members = {}
    puts "*********User in Group 200************"
    $output.each_line do |line|
      if line =~/^#/ || line =~/^\n/
        next
      end
      compartments = line.scan(/[^:]+/)
      if !(compartments[-1] =~ /bash/)
          nonBash.append(compartments[0])
      end
      if line =~/([\w]+)/ && compartments[3].to_i == 200 then
         puts $1
      end
      if members[compartments[3].to_i] == nil
        members[compartments[3].to_i] = 1
      else 
         members[compartments[3].to_i] = members[compartments[3].to_i] + 1
       end
    end
    members = members.sort.to_h
    puts "**************************","# of Users not using \"bash\": #{nonBash.size()}"
    puts "**********Report************"
    print_hash(members)
  end
end

l = Passwords.new()
l.compute
