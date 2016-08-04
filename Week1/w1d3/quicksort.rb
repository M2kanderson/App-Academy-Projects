 class Array

  def quicksort
    return self if self.length <= 1
    pivot = self.shift
    left_side = []
    right_side = []
    self.each do |el|
      if(el < pivot)
        left_side << el
      else
        right_side << el
      end
    end
    left_side.quicksort + [pivot] + right_side.quicksort
  end
end

shuffled_array =[1,2,3,4,5,6,7,8,9].shuffle
p shuffled_array.quicksort
