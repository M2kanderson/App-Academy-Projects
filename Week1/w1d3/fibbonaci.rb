def fibonacci(n)
  return [1] if n == 1
  return [1,1] if n == 2

  fibonacci(n-1) << fibonacci(n-2).last + fibonacci(n-1).last
end

p fibonacci(6)
