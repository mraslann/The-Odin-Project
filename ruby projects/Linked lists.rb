class Node
    attr_accessor :value, :next_node
    def initialize(value = nil, next_node = nil)
        @value = value
        @next_node = next_node
    end
end
class LinkedList
    attr_accessor :head, :tail
    def initialize
        @head = nil
        @tail = nil
    end
    def append(value)
        new_node = Node.new(value)
        if !@tail
            @tail = new_node
        else
            @tail.next_node = new_node
        end
        @tail = new_node
    end

    def prepend(value)
        new_node = Node.new(value)
        @head = new_node
    end

    def size
        current_node = @head
        counter = 0
        while current_node
            counter += 1
            current_node = current_node.next_node
        end
        counter
    end
end

def at(position)
    current_node = @head
    position.times do
        current_node = current_node.next_node
    end
    current_node
end

def pop
    current_node = @head
    while current_node
        if current_node.next_node == @tail
            current_node.next_node = nil
            @tail = current_node
            break
        else
            current_node = current_node.next_node
        end
    end
end

def contains?(value)
    current_node = @head
    while current_node
        if current_node.value == value
            return true
        end
        current_node = current_node.next_node
    end
    return false
end

def find(value)
    current_node = @head
    counter = 0
    while current_node
        if current_node.value == value
            return counter
        end
        current_node = current_node.next_node
        counter += 1
    end
    return nil
end

def to_s
    current_node = @head
    while current_node
        puts "( #{current_node.value} ) -> "
    end
    puts "nil"
end