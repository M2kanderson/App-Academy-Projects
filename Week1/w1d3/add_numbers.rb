def add_numbers(nums_array = [])
  return nil if nums_array.empty?
  return nums_array.first if nums_array.length == 1
  nums_array.shift + add_numbers(nums_array)
end

p  add_numbers([1,2,3,4]) # => returns 10
p  add_numbers([3]) # => returns 3
p  add_numbers([-80,34,7]) # => returns -39
p add_numbers() # => returns nil
