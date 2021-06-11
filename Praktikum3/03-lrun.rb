require "./03-lottery.rb"
class Run
    def initialize
        changeParams()
        runLoop()
    end

    def changeParams
        while !@num.kind_of?(Integer) && !@num.eql?(0)
            puts "Geben sie die Anzahl der gesamten Kugeln ein:"
            @num = gets.to_i
        end
        while !@toDraw.kind_of?(Integer) && !@toDraw.eql?(0)
            puts "Geben sie die Anzahl der zu ziehenden Kugeln ein:"
            @toDraw = gets.to_i
            puts @toDraw
        end
    end

    def runLoop
        @input = ""
        l = Lottery.new(@num)
        supNum = Lottery.new(9)
        while !@input.upcase.eql?("Q")
            puts "\nWählen sie Ihren Betriebsmodus aus:\n1:en bloc, 2: Iteriert, 3: Sortiert, Q: Quit"
            @input = gets[0]
            if @input.eql?("1")
                print "En block: "
                l.draw_all(@toDraw).each do |num|
                    print "#{num} "
                end
                print "Superzahl: #{supNum.draw_one}"
            elsif @input.eql?("2")
                print "Iteriert: "
                l.draw(@toDraw){|num| print "#{num} "}
                print "Superzahl: "
                supNum.draw(1){|res| print "#{res}"}
            elsif @input.eql?("3")
                print "Sortiert: "
                l.draw_sorted(@toDraw){|num| print "#{num} "}
                print "Superzahl: "
                supNum.draw_sorted(1){|res| print "#{res}"}
            elsif @input.upcase.eql?("Q")
                puts "Goodbye!"
            else
                puts 'falsche Eingabe!'
            end
        end

    end
end
r = Run.new()