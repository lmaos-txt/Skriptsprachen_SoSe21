class Container
    def initialize(max_size=0)
        @buf = [] #Keine feste Größe, damit size/length den notwendigen Wert ausgibt 
        @max_size = max_size
    end

    def append(array)
        if !array.kind_of?(Array)
            array = [array]
        end
        if @max_size == 0 or @buf.size < @max_size
            i = 0
            while i < array.size do
                if @buf.size < @max_size
                    @buf.append(array[i])
                    i +=1
                end
            end
            return i
        end
        return 0;
    end

    def empty?
        @buf.size == 0 
    end

    def clear
        x = @buf.length()
        @buf.clear()
        x
    end
    def size
        @buf.size
    end
    alias length size

    def list #not used helper but nice. displays all entries
        i = 0
        while i < @buf.size do
            puts @buf[i]
            i +=1
        end
    end
end

class MyQueue < Container

    def initialize(max_size=0)
        super(max_size)
    end

    alias enqueue append
    def dequeue()
        @buf.delete_at(0)
    end
    
    def peek()
        @buf[0]
    end
     
end

class MyStack < Container

    def initialize(max_size=0)
        super(max_size)
    end
    
    alias push append

    def pop()
        @buf.delete_at(-1)
    end
    
    def peek()
        @buf[-1]
    end
    alias depth size
    alias length size
    
end