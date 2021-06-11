module MyExtras
    def fact
        if self.to_f == 0
            return self.class == Integer ? 1 : self.class.new(1)
        end
        if self.to_f.round != self.to_f || self.to_f < 0
            raise "fact is not defined for negative or not whole numbers"
        end
        res = self
        num = res.to_f.round - 1
        while num > 0 do
            res *= num
            num -= 1
        end
        return res
    end
    def pow(n)
        if n == 0
            return self.class == Integer ? 1 : self.class.new(1)
        end
        n -= 1
        res = self
        while n > 0
            res *= self
            n -= 1
        end
        return res
    end
end

class MyRational
    include Comparable
    include MyExtras
    def initialize(z,n = 1)
        if n == 0
            raise "Denominator can not be 0"
        end
        if !z.is_a?(Integer) || !n.is_a?(Integer)
            raise "Denominator or Nominator have to be Integers"
        end 
        res = ggt(z,n)
        @zaehler = z / res
        @nenner = n / res
    end

    def to_s
        return "( #{@zaehler} / #{@nenner} )"
    end

    def to_f
        return zaehler.to_f / nenner.to_f
    end
    
    def make_equal(r_one, r_two)
        # Gets kgV and modifies them with both rationals

        r = kgV(r_one.nenner,r_two.nenner) # kvG
        
        # Get factor for both rationals
        modif_one = r / r_one.nenner
        modif_two = r / r_two.nenner

        # modify raitonals
        r_one.zaehler= modif_one * r_one.zaehler
        r_one.nenner= modif_one * r_one.nenner

        r_two.zaehler= modif_two * r_two.zaehler
        r_two.nenner= modif_two * r_two.nenner

        return [r_one,r_two]
    end

    def +(obj)
        if obj.class ==  MyRational
            res = make_equal(self, obj)
            return MyRational.new((res[0].zaehler + res[1].zaehler), res[0].nenner)
        elsif obj.class == Integer
            return self + MyRational.new(obj)
        else
            raise "Operations with #{obj.class} are not supported"
        end
    end

    def -(obj)
        if obj.class ==  MyRational
            res = make_equal(self, obj)
            return MyRational.new((res[0].zaehler - res[1].zaehler), res[0].nenner)
        elsif obj.class == Integer
            return self - MyRational.new(obj)
        else
            raise "Operations with #{obj.class} are not supported"
        end
    end

    def *(obj)
        if obj.class ==  MyRational
            return MyRational.new((zaehler * obj.zaehler), (nenner * obj.nenner))
        elsif obj.class == Integer
            return self * MyRational.new(obj)
        else
            raise "Operations with #{obj.class} are not supported"
        end
    end

    def /(obj)
        if obj.nenner == 0 || obj.zaehler == 0
            raise "Div by Zero is not defined"
        end
        if obj == self
            return self * MyRational.new(obj.nenner,obj.zaehler)
        end
        if obj.class ==  MyRational
            tmp = obj.zaehler
            obj.zaehler = nenner
            obj.nenner = zaehler
            return self * obj
        elsif obj.class == Integer
            return self / MyRational.new(obj)
        else
            raise "Operations with #{obj.class} are not supported"
        end

    end

    def **(obj)
        obj -= 1
        res = self
        while obj != 0 do
            res *= self
            obj -=1
        end
        return res
    end

    def +@
        self
    end

    def -@
        self
    end

    def <=>(op)
        if self.to_f > op.to_f
            return 1
        elsif self.to_f == op.to_f
            return 0
        else self.to_f < op.to_f
            return -1 
        end
    end

    def nenner
        return @nenner
    end  

    def nenner=(n)
        @nenner = n

    end

    def zaehler
        return @zaehler
    end    
    
    def zaehler=(z)
        @zaehler = z
    end

    def ggt(a,b)
        while b != 0 do
            h = a%b
            a = b
            b = h
        end
        return a == 0 ?  1 : a
    end

    def kgV(a,b)
        return (a * b) / ggt(a,b)
    end
    private :make_equal
end

class Integer
    include MyExtras
end
q = MyRational.new(1.7,1)
puts q