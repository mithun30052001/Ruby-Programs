$initial_amount = 0
$customer_count = 1
$chocolate_money = 0

def calculate_initial_amount(denominations)
  denomination_array, denomination_array_index, total_amount = [1,2,5,'5C',10,'10C',20,50,100,200,500,2000],0,0
  for denomination_count in (denominations.values)
     total_amount += denomination_array[denomination_array_index] * denomination_count.to_i
     denomination_array_index += 1
  end
  total_amount
end

def create_order()
  valid_order = true
  puts("Hello customer#{$customer_count}! The cost of the product is")
  selling_price = gets.chomp().to_i
  puts("The money given is:")
  money_given = gets.chomp().to_i
  if(money_given == 0 || selling_price == 0)
    valid_order = false
    if selling_price == 0 && money_given != 0
      puts("The amount #{money_given} has been returned back to the customer")
    end
  else
    while money_given < selling_price
      puts("Insufficient cash Please give correct cash")
      money_given = gets().chomp.to_i
    end
    $customer_count += 1
    return valid_order,selling_price,money_given
  end
end

def create_transaction(denominations_hash_copy,denominations,selling_price,money_given)
  available_denominations = [2000,500,200,100,50,20,10,5,2,1]
  string_denominations = available_denominations.map{|element| element.to_s}
  string_denominations<<"5C"<<"10C"
  puts("Enter the denominations given by the customer")
  user_denominations,sum_of_given_money = Array.new,0
  while(sum_of_given_money < money_given)
    given_denomination = gets.chomp
    while !(string_denominations.include?(given_denomination))
      puts("Invalid denomination!! Please enter a valid amount")
      given_denomination = gets.chomp
    end
    user_denominations<<given_denomination
    sum_of_given_money += given_denomination.to_i
  end
  user_denominations.each {|denomination| denominations[denomination.upcase]+=1}
  balance = money_given - selling_price
  updated_denominations = give_balance(balance,denominations_hash_copy,denominations,available_denominations,money_given)
end

def give_balance(balance,denominations_hash_copy,denominations,available_denominations,money_given)
  total_balance = balance
  while balance != 0
    denomination_index = 0
    while((balance / available_denominations[denomination_index]).abs <= 0)
       denomination_index += 1
    end
    change_available_index = (available_denominations[denomination_index]).to_s
    while(denominations[change_available_index] == 0 && denomination_index < available_denominations.length)
      denomination_index += 1
      change_available_index = (available_denominations[denomination_index]).to_s
    end
    if ((change_available_index.eql?("10")) || (change_available_index.eql?("5")))
      change_available_index = decide_coin_or_note(change_available_index,denominations)
    end
   if(denomination_index == available_denominations.length)
    if(balance <= 10)
      chocolate_case(total_balance,balance,denominations,denominations_hash_copy)
     balance = 0
    else
      puts("Can you please comeback with proper change")
      denominations = denominations_hash_copy.clone
      break
    end
    else
      denominations[change_available_index] -= 1
      balance = balance - available_denominations[denomination_index]
    end
  end
  return denominations
end

def decide_coin_or_note(change_available_index,denominations)
  change_available_index = change_available_index + "C"
      if (denominations[change_available_index] == 0)
        change_available_index = change_available_index[0..-2]
      end
  return change_available_index
end

def chocolate_case(total_balance,balance,denominations,denominations_hash_copy)
  if(total_balance - balance > 0)
    puts("Balance given as cash for Rs.#{(total_balance - balance).to_s}")
  end
  puts("Sorry!! No change would you take a chocolate worth Rs.#{balance.to_s}")
  user_reply = gets.chomp
  if (user_reply.casecmp?("1") || user_reply.casecmp?("yes") || user_reply.casecmp?("y"))
    puts("Chocolate given for balance money of Rs.#{balance.to_s}")
    $chocolate_money = balance
  else
    puts("Customer invalid")
    $customer_count -= 1
    denominations = denominations_hash_copy.clone
  end
end

def validate_cashbox(denominations,selling_price)
  isvalid = calculate_initial_amount(denominations) - $final_amount == selling_price + $chocolate_money? true : false
  $chocolate_money = 0
  return isvalid
end

def main()
  denominations = {
    '1' => 10,
    '2' => 10,
    '5' => 10,
    '5C' => 10,
    '10' => 10,
    '10C' => 10,
    '20' => 10,
    '50' => 10,
    '100' => 10,
    '200' => 10,
    '500' => 10,
    '2000' => 10
  }
  $final_amount = calculate_initial_amount(denominations)
  fixed_initial = $final_amount
  puts("The initial amount in the cash-box is")
  puts($final_amount)
  shop_closed =false
  sales_array=Array.new
  while !(shop_closed)
    timeup=false
    order_accepted = create_order()
    if order_accepted
      denominations_hash_copy = denominations.clone
      selling_price,money_given=order_accepted[1],order_accepted[2]
      denominations= create_transaction(denominations_hash_copy,denominations,selling_price,money_given)
      if denominations != denominations_hash_copy
        sales_array <<[selling_price,money_given,money_given-selling_price]
        no_issue = validate_cashbox(denominations , selling_price)
        if !(no_issue)
          puts("Some issue in the cashbox ,checking please wait...........")
          puts denominations
          sales_array.pop
        else
          amount = calculate_initial_amount(denominations)
          $initial_amount = $final_amount
          $final_amount = amount
        end
      end
    end
    puts("The cash-box denominations after this sale is")
    puts denominations
    puts "Do you want to continue"
    close_status = gets.chomp()
    if(close_status.casecmp?("no") || close_status.casecmp?("n") || close_status.casecmp?("0"))
      timeup = true
    end
    if(timeup == true)
      shop_closed = true
    end
  end
  puts("The sales for each customer is")
  puts(sales_array.inspect)
  puts("The denominations count at the end of the day is")
  puts(denominations)
  puts("The final amount in hand for the shopkeeper is")
  puts($final_amount)
  puts("The income of the shopkeeper for the day is")
  puts($final_amount - fixed_initial)
end

main()

