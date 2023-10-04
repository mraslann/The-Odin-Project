def merge_sort(arr)
    return arr if arr.length < 2
    mid = arr.length / 2
    left = merge_sort(arr[0,mid])
    right = merge_sort(arr[mid..-1])
    sorted = []
    until left.empty? || right.empty?
        if left[0] > right[0]
            sorted << right[0]
            right = right[1..-1]
        else
            sorted << left[0]
            left = left[1..-1]
        end
    end
    sorted += left + right
    return sorted
end