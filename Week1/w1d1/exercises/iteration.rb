def factors(num)
  factors = []
  (1..num).each do |i|
    if num % i == 0
      factors << i
    end
  end
  factors
end
