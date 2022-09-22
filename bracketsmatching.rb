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
bracket_hash ={'(' => ')' , '[' => ']' , '{' => '}'}
check_no_bracket(bracket_string)
stack_of_brackets = Array.new
for character in bracket_string.chars
    if (bracket_hash.keys).include?(character)
      stack_of_brackets.push(character)
    else
      if stack_of_brackets.empty? || !(bracket_hash[stack_of_brackets.pop()].eql?(character))
        return false
      end
   end
end
stack_of_brackets.empty?
end

puts("Enter the bracket string")
bracket_string = gets.chomp()
if check_valid_bracket(bracket_string)
 puts("The Brackets in the string is balanced")
else
  puts("The Brackets in the string is not balanced")
end
