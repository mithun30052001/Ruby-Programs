def iterate(tree_hash)
  tree_hash.each do |key,value|
    if value.is_a?(Hash)
      iterate(value)
      value[:left],value[:right] = value[:right] , value[:left]
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
  main_hash ={const_tree:}
 #const_tree[:left],const_tree[:right] = const_tree[:right] , const_tree[:left]
 puts(iterate(main_hash))


