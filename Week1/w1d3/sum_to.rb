def sum_to(n)
  return nil if(n < 0)
  return 0 if n == 0
  n + sum_to(n-1)
end

puts sum_to(5)
puts sum_to(1)
puts sum_to(9)
puts sum_to(-8)
