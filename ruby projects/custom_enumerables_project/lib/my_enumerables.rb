module Enumerable
  # Your code goes here
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
    def my_each
        for elem in self
            yield elem
        end
    end
    def my_each_with_index
        i = 0
        for elem in self
            yield elem, i
            i += 1
        end
    end
    def my_select
        result = []
        my_each {|elem| result.push(elem) if yield elem}
        result
    end
    def my_all?
        expr = ->(elem){yield elem}
        my_each {|elem| return false unless expr.call(elem)}
        return true
    end
    def my_any?
        expr = ->(elem){yield elem}
        my_each {|elem| return true if expr.call(elem)}
        return false
    end
    def my_none?
        expr = ->(elem){yield elem}
        my_each {|elem| return false if expr.call(elem)}
        return true
    end
    def my_count
        if !block_given?
            return length
        end
        count = 0
        expr = ->(elem){count += 1 if yield elem}
        my_each { |elem| expr.call(elem) }
        return count
    end
    def my_map(a_proc=nil)
        result = []
        self.my_each { |elem| result.push(yield elem) }
        result
    end
    def my_inject(initial=nil)
        accumulator = initial
        my_each do |element|
            accumulator = accumulator.nil? ? element : yield(accumulator, element)
        end
        accumulator
    end
end

