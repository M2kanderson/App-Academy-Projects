# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  new_string = []
  words = str.split(" ")
  words.each do |word|
    new_word = []
    word.chars do |letter|
      new_word << ("a".ord + (letter.ord - ("a").ord + shift)%26).chr
    end
    new_string << new_word.join("")
  end
  new_string.join(" ")
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  digits = num.to_s.split("")
  sum = 0
  digits.each do |digit|
    sum += digit.to_i
  end
  if(sum > 10)
    digital_root(sum)
  else
    return sum
  end

end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'olleh'

def jumble_sort(str, alphabet = nil)
  letter_index_hash = Hash.new(0)
  if(alphabet)
    str.split("").each do |letter|
      letter_index_hash[letter] = alphabet.index(letter)
    end
    return letter_index_hash.sort_by{|k,v| v}.keys.join("")
  else
    return str.split("").sort.join("")
  end
end

class Array
  # Write an array method that returns `true` if the array has duplicated
  # values and `false` if it does not
  def dups?
    self.each do |el|
      if(self.count(el) > 1)
        return true
      end
    end
    return false
  end
end

# Determine if a string is symmetrical. 'racecar' and 'too hot to hoot' are
# examples of symmetrical strings.
#
# Do NOT use any built-in `reverse` methods.

class String
  def symmetrical?
    string_array = self.split(" ")
    reversed_array = []
    string_array.each do |character|
      reversed_array.unshift(character)
    end
    if(reversed_array == string_array)
      return true
    else
      return false
    end
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  (1..num).each do |test_num|
    if(num%test_num == 0)
      factors << test_num
    end
  end
  factors
end
