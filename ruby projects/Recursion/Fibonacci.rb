def fibs(x)
    result = []
    x.times do |i|
        if i == 0 || i == 1
            result << i
        else
            result << result[-1] + result[-2]
        end
    end
    result
end

def fibs_rec(x)
    return [0,1] if x<=2
    result = fibs_rec(x-1)
    result << result[-1] + result[-2]
end