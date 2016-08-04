def exp_r1(base, n)
  return 1 if n == 0
  base * exp_r1(base, n-1)
end

def exp_r2(base, n)
  return 1 if n == 0
  return base if n == 1
  if(n.even?)
    exp_r2(base, n / 2) ** 2
  else
    base * exp_r2(base, (n-1) / 2) ** 2
  end
end

start_time = Time.now
puts exp_r1(8,100)

p Time.now - start_time
