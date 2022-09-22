# "(){}[]"   =>  True
# "([{}])"   =>  True
# "(}"       =>  False
# "[(])"     =>  False
# "[({})](]" =>  False

def check_no_bracket(bracket_string)
  if bracket_string.length == 0 || !( /\{|\[|\(/  =~ bracket_string)
    puts("The given string is invalid")
    exit
  end
end

def check_valid_bracket(bracket_string)
  check_no_bracket(bracket_string)
  bracket_hash ={'(' => ')' , '[' => ']' , '{' => '}'}
  opening_brackets,closing_brackets = Array.new,Array.new
  for character in bracket_string.chars
     if bracket_hash.keys.include?(character)
       opening_brackets.push(character)
     elsif bracket_hash.values.include?(character)
        closing_brackets.push(character)
     end
  end
  if opening_brackets.length != closing_brackets.length
    return false
  end
  for bracket_index in 0..opening_brackets.length-1
    if !(bracket_hash[opening_brackets[bracket_index]].eql? closing_brackets[bracket_index])
      return false
    end
  end
  return true
end

puts("Enter the bracket string")
bracket_string = gets.chomp()
if check_valid_bracket(bracket_string)
 puts("The Brackets in the string is balanced")
else
  puts("The Brackets in the string is not balanced")
end


def invert_tree(root)
  return nil if root.nil?
     root.left, root.right = root.right, root.left
     invert_tree(root.left)
     invert_tree(root.right)
     root
 end
