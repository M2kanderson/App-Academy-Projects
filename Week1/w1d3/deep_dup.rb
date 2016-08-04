def deep_dup(array)
  return array if !array.is_a?(Array)

  duplicate = array.dup
  duplicate.each_with_index do |el,i|
    duplicate[i] = deep_dup(el)
  end
  duplicate
end

a = [1,[2],[3,[4]]]
a2 = deep_dup(a)
a2 << [2,3]
p a
p a2
