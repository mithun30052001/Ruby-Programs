def tree_swap(tree_hash)
  tree_hash[:left],tree_hash[:right] = tree_hash[:right] , tree_hash[:left]
  tree_hash.each do |key,value|
    if value.is_a?(Hash)
      iterate(value)
    end
  end
  return tree_hash
end

const_tree = {
    value: 1,
    left: {
      value: 2,
      left: { value: 4 },
      right: { value: 5 },
    },
    right: {
      value: 3,
      left: { value: 6 },
      right: { value: 7 },
    },
  }
puts(tree_swap(const_tree))

