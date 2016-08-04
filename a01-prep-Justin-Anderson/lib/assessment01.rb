class Array
  def my_inject(accumulator = nil)
    if(accumulator == nil)
      accumulator = self.first
      self[1..-1].each do |el|
        accumulator = yield accumulator,el
      end
    else
      self.each do |el|
        accumulator = yield accumulator,el
      end
    end
    accumulator
  end
end

def is_prime?(num)
  (2...num).none? do |test_number|
    num % test_number == 0
  end
end

def primes(count)
  return [] if count == 0
  primes = []
  current_number = 2
  until(primes.length == count)
    if(is_prime?(current_number))
      primes << current_number
    end
    current_number += 1
  end
  primes

end

# the "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
# Also, be aware that the first factorial number is 0!, which is defined
# to equal 1. So the 2nd factorial is 1!, the 3rd factorial is 2!, etc.



def factorials_rec(num)
  return [1,1] if num == 2
  return [1] if num == 1

  factorial_array = factorials_rec(num-1)
  factorials = factorial_array + [(num-1) * factorial_array.last]
  factorials
end

class Array
  def dups
    found = Hash.new(nil)
    duplications = Hash.new([])
    self.each_with_index do |el, index|
      if(found.include?(el))
        if(duplications[el].empty?)
          duplications[el] += [found[el]]
        end
        duplications[el] += [index]
      else
        found[el] = index
      end
    end
    duplications
  end
end

class String

  def substrings
    index1 = 0
    substrings = []
    while index1 < self.length
      index2 = index1
      while index2 < self.length
        substrings << self[index1..index2]
        index2 +=1
      end
      index1 += 1
    end
    substrings
  end

  def symmetric_substrings
    sym_subs = []
    substrs = self.substrings
    substrs.each do |string|
      if(string.length != 1 && string == string.reverse)
        sym_subs << string
      end
    end
    sym_subs
  end
end

class Array
  def merge_sort(&prc)
    return self if self.length <= 1
    prc ||= Proc.new{ |x,y| x <=> y}
    left_side = self[0...self.length/2]
    right_side = self[self.length/2..-1]
    sorted_left = left_side.merge_sort(&prc)
    sorted_right = right_side.merge_sort(&prc)
    Array.merge(sorted_left,sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged_array = []
    until left.empty? || right.empty?
      case prc.call(left.first, right.first)
      when -1
        merged_array << left.shift
      when 0
        merged_array <<left.shift
      when 1
        merged_array << right.shift
      end
    end

    merged_array += left + right
    merged_array
  end
end
