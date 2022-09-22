def swap_subtrees(tree_array,levels,left_start_index,right_start_index)
  power_of_two = 2
  right_start_index += (2 ** power_of_two)
  while(right_start_index < tree_array.length)
    puts right_start_index
    power_of_two +=1
    right_start_index += (2 ** power_of_two)
  end
  #puts tree_array.inspect
  return tree_array
end

puts("Enter the tree elements in the order of level order traversal:")
tree_array=gets.chomp().split().map{|element| element}
root , start_index , levels= tree_array[0], 0 , 1 + (Math.log(tree_array.length,2)).floor
left_child , right_child = 2*(start_index)+1 ,2*(start_index)+2
power_of_two,swap_call = 2,2
while((left_child < tree_array.length)  &&  (right_child < tree_array.length))
  if(right_child == swap_call)
   tree_array = swap_subtrees(tree_array,levels,left_child,right_child)
   swap_call =
  end
  tree_array[left_child] , tree_array[right_child] = tree_array[right_child] , tree_array[left_child]
  puts "The children of #{tree_array[start_index]} are #{tree_array[left_child]} and #{tree_array[right_child]}"
  start_index += 1
  left_child , right_child = 2*(start_index)+1 ,2*(start_index)+2
end
puts tree_array.inspect
