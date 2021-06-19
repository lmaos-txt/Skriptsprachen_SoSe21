require './XMath'
include Math
require 'benchmark'

10.times{|x|
    n = 1..4
    printf("x: %g\t\t|", x)
    (1..4).each {|n| printf("n: %2.8f\t", XMath::scalbn(x, n)) }
    printf("|%2.8f\n", XMath::log1p(x))
}


def sin_int(x0, x1, n2)
    x0 = x0.to_f
    x1 = x1.to_f
    delta = ((x1-x0)/(n2*2))
    front = 0.0
    mid = 0.0
    back = 0.0
    for i in 0...(2*n2)+1 do
        if((i == 0) || (i == 2*n2))
            front += Math.sin(x0+i*delta)
        end
        if((i == 0) && (i == 2*n2))
            back += Math.sin(x0+i*delta)
        end
        if(i%2 == 1)
            mid += Math.sin(x0+i*delta)
        end
    end
    return (delta/3)*(front+4*mid+back)
end
x = [1,10,100,100000,1000000]
x.each{|x|
    puts "C XMath:\t\t N = #{x} \t| #{XMath::sin_int(0,Math::PI/2,x)}"
    c = Benchmark.measure{ XMath::sin_int(0,Math::PI/2,x) }
    puts "Compute Time for C:\t N = #{x} \t| #{c}"
    puts "Ruby XMath:\t\t N = #{x} \t| #{sin_int(0,Math::PI/2,x)}"
    r= Benchmark.measure{ sin_int(0,Math::PI/2,x) }
    puts "Compute Time for Ruby:\t N = #{x} \t| #{r}"
    puts "The Difference:(Ruby is x amount of time Slower/Faster) #{r-c}"
    puts "_____________________________________________________"
}