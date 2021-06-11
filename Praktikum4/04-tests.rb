require "./04-rational.rb"
require "test/unit"

class TestRationals < Test::Unit::TestCase

    def setup
        @null = MyRational.new(0)
        @eins = MyRational.new(1)
        @zwei = MyRational.new(2)
        @zehn = MyRational.new(10)
        @minuseins = MyRational.new(-1)
        @einhalb = MyRational.new(1,2)
        @dreiviertel = MyRational.new(3,4)
        @zweidrittel = MyRational.new(2,3)
        @neunminusfuenftel = MyRational.new(9,-5)
        @zwoelfachtel = MyRational.new(12,8)

    end

    def test_initialize
        puts "\nBeginne Initialisierungstests"
        assert @null == MyRational.new(0)
        assert @zwoelfachtel == MyRational.new(3,2)
        assert @neunminusfuenftel == MyRational.new(-9,5)
        assert @eins == MyRational.new(1)
        assert @minuseins == MyRational.new(-1)
        assert @einhalb == MyRational.new(1,2)
        assert @dreiviertel == MyRational.new(3,4)
        assert @zweidrittel == MyRational.new(2,3)
        assert_raise RuntimeError do
            MyRational.new(0,0)
        end

    end

    def test_strichrechnung
        puts "\nBeginne Strichrechnungstests"
        assert @null - @null == @null
        assert @null + @null == @null
        assert @null - @eins == @minuseins
        assert @null - @minuseins == @eins
        assert @null + @einhalb == @einhalb
        assert @einhalb + @null == @einhalb
        assert @zweidrittel + @einhalb = MyRational.new(7,6)
        assert @einhalb + @zweidrittel = MyRational.new(7,6)
        assert @minuseins + @eins = @null
        assert @zwoelfachtel + @neunminusfuenftel = MyRational.new(-3,10)
        assert_raise RuntimeError do
            @null + "test"
        end
    end

    def test_punktrechnung
        puts "\nBeginne Punktrechnugstests"
        assert @zehn * @zehn = MyRational.new(100)
        assert @zehn * @null = @null
        assert @einhalb * einhalb = MyRational.new(1,4)
        assert @dreiviertel * @einhalb = MyRational.new(3,8)
        assert @einhalb * @minuseins = MyRational.new(-1,2)
        assert @zehn / @zehn = @eins
        assert @einhalb / @einhalb = @eins
        assert (@zehn - @eins) * @einhalb = MyRational.new(9,2)
        assert @dreiviertel / @einhalb = MyRational.new(3,2)
        assert @einhalb / @minuseins = MyRational.new(-1,2)
        assert_raise RuntimeError do
            @zehn / @null 
        end
    end

    def test_fac
        puts "\nBeginne Fakultätsrechnung"
        assert 0.fact == 1
        assert 5.fact == 120
        assert @eins.fact == 1
        assert @zwei.fact == 2
        assert @null.fact == @eins
        assert_raise RuntimeError do
             @minuseins.fact
        end
        assert_raise RuntimeError do
            MyRational.new(9,2).fact
        end
    end

    def test_pow
        puts "\nBeginne Initialisierungstests"
        assert 0.pow(2) == 0
        assert 0.pow(0) == 1
        assert -1.pow(2) == 1
        assert @null.pow(0) == @eins
        assert @zehn.pow(2) == MyRational.new(100)
        assert @minuseins.pow(2) == @eins
    end

    def test_operations
        puts "\nBeginne Operationen"
        assert @null < @eins == true
        assert @zehn > 0 == true
        assert @null < 1 == true
        assert @eins < @eins == false
    end

    def test_to_s
        puts "\nBeginne Stringtests"
        assert @null.to_s == "( 0 / 1 )"
        assert @eins.to_s == "( 1 / 1 )"
        assert @zwei.to_s == "( 2 / 1 )"
        assert @minuseins.to_s == "( -1 / 1 )"
        assert @einhalb.to_s == "( 1 / 2 )"
        assert @dreiviertel.to_s == "( 3 / 4 )"
        assert @zweidrittel.to_s == "( 2 / 3 )"
        assert @neunminusfuenftel.to_s == "( -9 / 5 )"
        assert @zwoelfachtel.to_s == "( 3 / 2 )"
    end

    def test_to_f
        puts "\nBeginne Floattests"
        assert @null.to_f == 0
        assert @eins.to_f == 1
        assert @zwei.to_f == 2
        assert @minuseins.to_f == -1
        assert @einhalb.to_f == 0.5
        assert @dreiviertel.to_f == 0.75
        assert @zweidrittel.to_f == 2.0/3.0
        assert @neunminusfuenftel.to_f == -1.8
        assert @zwoelfachtel.to_f == 1.5
    end

end

