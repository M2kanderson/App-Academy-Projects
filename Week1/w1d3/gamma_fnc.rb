# def factorial(n)
#   return 1 if n<=1
#   n*factorial(n-1)
# end
#
#
# def gamma_fnc(n)
#   return nil if n == 0
#   factorial(n - 1)
# end


def gamma_fnc(n)
  return nil if n == 0
  return 1 if n <= 1
  (n-1)*gamma_fnc(n - 1)
end

p gamma_fnc(0)  # => returns nil
p gamma_fnc(1)  # => returns 1
p gamma_fnc(4)  # => returns 6
p gamma_fnc(8)  # => returns 5040
