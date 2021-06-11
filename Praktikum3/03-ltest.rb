require "./03-lottery.rb"
require "test/unit"
require "optparse"
class TestQueue < Test::Unit::TestCase

    def test_draw_one # normale läufe
        l1 = Lottery.new(49)
        res = l1.draw_one
        assert_equal(res.class,Integer)
        n = 4
        l2 = Lottery.new(n)
        n.times {assert_equal(l2.draw_one.class,Integer)}
        l3 = Lottery.new(n)
        n.times{l3.draw_one}
        assert_equal(l3.draw_one,nil)
    end

    def test_draw_all
        l1 = Lottery.new(20)
        res = l1.draw_all
        res.each{ |numbers| assert_equal(numbers.class, Integer)}

        l2 = Lottery.new(20)
        res = l2.draw_all(5)
        assert_equal(res.size,5)
        res.each{ |numbers| assert_equal(numbers.class, Integer)}

        l3 = Lottery.new(20)
        res = l3.draw_all(20)
        assert_equal(res.size,20)
        res.each{ |numbers| assert_equal(numbers.class, Integer)}

        l4 = Lottery.new(20)
        res = l4.draw_all(21)
        assert_equal(res.size,21)
        assert_equal(res[20],nil)
    end

    def test_draw
        #Normaler Lauf
        l1 = Lottery.new(20)
        res = l1.draw(6) {|numbers| assert_equal(numbers.class,Integer)}
        assert_equal(res,true)
        # Mehr als möglich
        l2 = Lottery.new(5)
        res = l2.draw(6) {|numbers| assert_equal(numbers.class,Integer)} #ALles was zurückgegeben wird ist korrekt
        assert_equal(res,false)
    end

    def test_draw_sorted
        #Normaler Lauf
        l1 = Lottery.new(20)
        res = l1.draw_sorted(5){|numbers| assert_equal(numbers.class, Integer)}
        assert_equal(res, true)

        arr = []
        arr_cpy = []

        # Funktion Sortierung
        l2 = Lottery.new(20)
        res = l2.draw_sorted(5){|numbers| arr.push(numbers)}
        assert_equal(res, true)
        assert_equal(arr.size, 5)
        arr_cpy = arr.clone
        arr_cpy = arr_cpy.sort
        assert_equal(arr,arr_cpy)

        #Mehr Ziehungen als möglich
        l3 = Lottery.new(5)
        res = l3.draw_sorted(6){|numbers| assert_equal(numbers.class, Integer)}
        assert_equal(res,false)
    end

    def test_no_block
        l1 = Lottery.new(20)
        res = l1.draw
        assert_equal(res,false)
        l2 = Lottery.new(20)
        res = l2.draw_sorted
        assert_equal(res,false)
        
    end

end