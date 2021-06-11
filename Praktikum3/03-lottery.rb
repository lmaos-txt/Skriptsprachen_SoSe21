class Lottery
    def initialize(limit=49)
        @buf = []
        @lim = limit
        1.upto(@lim){|num| @buf.append(num)}
    end

    def draw_one
        choose = rand(@buf.size)# Number to draw
        while @buf[choose] == nil do
            if @buf.count(nil).eql?(@lim)
                return nil
            end
            if choose == @buf.size
                choose = 0
            else 
                choose += 1
            end
        end
        res = @buf[choose]
        @buf[choose]= nil
        return res
    end

    def draw_all(n=6)
        res = []
        n.times do
            res.push(draw_one)
        end
        return res
    end

    def draw(n=6)
        if block_given?
            1.upto(n) do
                res = draw_one 
                if res == nil
                    return false
                else
                    yield res
                end
            end 
        else
            puts "Error: No block given"
            return false
        end
        return true
    end

    def draw_sorted(n=6)
        if block_given?
            res = []

            n.times do |num|
                r = draw_one
                if(r == nil)
                    return false
                else
                    res.push(r)
                end
            end
            res = res.sort
            0.upto(res.size-1){ |i| yield(res[i])}
        else
            puts "Error: No block given"
            return false
        end
        return true
    end

    def list #not used helper but nice. displays all entries
        i = 0
        while i < @buf.size do
            puts @buf[i]
            i +=1
        end
    end
    
end
