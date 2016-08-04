class Array

  def my_each(&blk)
    index = 0
    while (index < self.length)
      blk.call(self[index])
      index +=1
    end
  end

  def my_select(&blk)
    index = 0
    new_array = []
    self.my_each do |item|
      if blk.call(item)
        new_array << item
      end
    end
    new_array
  end

  def my_reject(&blk)
    index = 0
    new_array = []
    self.my_each do |item|
      unless blk.call(item)
        new_array << item
      end
    end
    new_array
  end

  def my_any?(&blk)
    self.my_each do |el|
      if(blk.call(el))
        return true
      end
    end
    false
  end

  def my_all?(&blk)
    self.my_each do |el|
      unless(blk.call(el))
        return false
      end
    end
    true
  end

  def my_flatten
    new_array = []
    self.my_each do |el|
      if(el.is_a?(Array))
        new_array = new_array + el.my_flatten
      else
        new_array << el
      end
    end
    new_array
  end

  def my_zip(*args)
    new_array = []
    index = 0
    self.my_each do |el|
      sub_array = []
      sub_array << el
      args.my_each do |array|
        sub_array << array[index]
      end
      new_array << sub_array
      index += 1
    end
    new_array
  end

  def my_rotate(shift = 1)
    new_array = self.dup
    shift.abs.times do
      if(shift > 0)
        new_array << new_array.shift
      else
        new_array.unshift(new_array.pop)
      end
    end
    new_array
  end

  def my_join(separator = "")
    new_string = ""
    self[(0..-2)].my_each do |item|
      new_string << item + separator
    end
    new_string << self.last
  end

  def my_reverse
    new_array = []
    self.my_each do |item|
      new_array.unshift(item)
    end
    new_array
  end

end


p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]
