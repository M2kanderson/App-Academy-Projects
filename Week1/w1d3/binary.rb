require 'byebug'
def bsearch(array, target)

  middle = array.length.even? ? (array.length/2)-1 : (array.length - 1)/2
  return middle if array[middle] == target
  return "NOT FOUND" if array.length <= 1 && array.first != target
  if target < array[middle]
    search = bsearch(array[0...middle],target)
    if(search.is_a?(String))
      return search
    else
      return middle - (((array.length-1)/2) - search)
    end
  else
    search = (bsearch(array[(middle+1)..-1], target))
    if(search.is_a?(String))
      return search
    else
      return middle + search + 1
    end
  end
end

p bsearch([1, 3, 4, 5, 9], 5)
