def range(start_number,end_number)
  return [end_number] if start_number == end_number
  array = []
  array += [start_number] + range(start_number+1, end_number)

end

p range(2,9)
