def merge_sort(array)
  return array if array.length <= 1
  left_array = array[0...(array.length/2)]
  right_array = array[(array.length/2)..-1]
  left_sorted = merge_sort(left_array)
  right_sorted = merge_sort(right_array)

  sorted = []
  until left_sorted.empty? || right_sorted.empty?
    sorted << ((left_sorted.first < right_sorted.first) ? left_sorted.shift : right_sorted.shift)
    # if left_sorted.first < right_sorted.first
    #   sorted << left_sorted.shift
    # else
    #   sorted << right_sorted.shift
    # end
    # if left_sorted.empty?
    #   sorted += right_sorted
    # elsif right_sorted.empty?
    #   sorted += left_sorted
    #end
  end
  sorted + left_sorted + right_sorted
end


arr = (0..20).to_a.shuffle
p arr
p merge_sort(arr)
