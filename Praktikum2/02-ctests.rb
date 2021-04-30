require "./02-container"
require "test/unit"
class TestQueue < Test::Unit::TestCase

    def fill(length)
        array = MyQueue.new(length)
        i = 1
        while i <= length do
            array.enqueue(i)
            i+=1
        end
        #puts "Queue filled with:"
        #array.list
        return array
    end

    def test_size
        queue = fill(5)
        assert queue.size == 5
    end

    def test_clear
        queue = fill(5)
        queue.clear
        assert queue.size == 0
    end
    def test_peek
        queue = fill(5)
        assert queue.peek == 1
    end
    def test_dequeue
        queue = fill(5)
        assert queue.dequeue == 1
    end
    def test_empty
        queue = fill(5)
        queue.clear
        assert queue.empty? == true
    end
    def test_length
        queue = fill(5)
        assert queue.length == 5
        assert queue.size == 5
    end
    def test_overflow
        queue = fill(5)
        queue.dequeue
        assert queue.enqueue(1) == 1
        assert queue.enqueue(1) == 0
        assert queue.length == 5
    end
    def test_enqueue_arr
        queue = MyQueue.new(5)
        x = [1,"Two",false]
        assert queue.enqueue(x) == 3
        assert queue.size == 3
    end
end


class TestStack < Test::Unit::TestCase

    def fill(length)
        array = MyStack.new(length)
        i = 1
        while i < length+1 do
            array.push(i)
            i+=1
        end
        #puts "Stack filled with:" Ausgabe von Befüllung
        #array.list
        return array
    end

    def test_size
        stack = fill(6)
        assert stack.size == 6
    end

    def test_clear
        stack = fill(5)
        stack.clear
        assert stack.size == 0
    end
    def test_peek
        stack = fill(5)
        assert stack.peek == 5
    end
    def test_pop
        stack = fill(5)
        assert stack.pop == 5
    end
    def test_empty
        stack = fill(5)
        stack.clear
        assert stack.empty? == true
    end
    def test_length
        stack = fill(5)
        assert stack.length == 5
        assert stack.size == 5
    end
    def test_overflow
        stack = fill(5)
        stack.pop
        assert stack.push(1) == 1
        assert stack.push(1) == 0
        assert stack.length == 5
    end
    def test_push_arr
        stack = MyStack.new(5)
        x = [1,"Two",false]
        assert stack.push(x) == 3
        assert stack.size == 3
    end
end
