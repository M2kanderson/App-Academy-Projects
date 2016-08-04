def subsets(array)
  return [array] if array.empty?
  subset = [array]
  array.each do |el|
    subset += subsets(array - [el])
    #subset += [array] if array.length >= 2
    #subset += [el,subsets(array-[el])]
  end
  subset.uniq

end


p subsets([1,2,3])
