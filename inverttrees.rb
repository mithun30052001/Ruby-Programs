# Write code to invert the tree, move left nodes to right and vice-versa
# const tree = {
#   value: 1,
#   left: {
#     value: 2,
#     left: { value: 4 },
#     right: { value: 5 },
#   },
#   right: {
#     value: 3,
#     left: { value: 6 },
#     right: { value: 7 },
#   },
# };

def reverse_subtrees(tree_array,start_index,end_index)
  tree_array[start_index..end_index] = tree_array[start_index..end_index].reverse
  return tree_array
end

puts("Enter the tree elements in the order of level order traversal:")
tree_array=gets.chomp().split().map{|element| element}
start_index,end_index,power_of_two = 1,2,1
current_level , total_levels = 0 , Math.log(tree_array.length,2).ceil
while(current_level < total_levels-1)
  if(end_index >= tree_array.length)
    element_fill_count = end_index - (tree_array.length - 1)
    fill_array =Array.new(element_fill_count, "NIL")
    tree_array = tree_array + fill_array
  end
  reverse_subtrees(tree_array,start_index,end_index)
  current_level += 1
  start_index = end_index + 1
  end_index += 2 ** (power_of_two + 1)
  power_of_two += 1
end
puts tree_array.inspect

