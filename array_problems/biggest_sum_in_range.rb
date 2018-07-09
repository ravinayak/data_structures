require_relative '../array_problems/utility_functions'

# Used for namespacing
#
module ArrayProblems
  # Class
  #
  class BiggestSumInRange
    include UtilityFunctions
    
    attr_accessor :num
    
    def initialize(num)
      @num = num
    end
    
    def prep_biggest_num(input_num)
      return input_num if input_num <= 9
      
      digits_arr = prepare_digits_for_num(input_num)
      possible_num = 0
      (0...(digits_arr.length - 1)).each do |i|
        possible_num = possible_num + 9 * (10 ** i)
      end
      
      possible_greatest_num = possible_num + ((digits_arr[digits_arr.length - 1]) * (10 ** (digits_arr.length - 1)))
      return [possible_greatest_num, digits_arr.reduce(0) { |a, e| a + e } ] if possible_greatest_num == input_num
      
      current_greatest_num = possible_num + ((digits_arr[digits_arr.length - 1] - 1) * (10 ** (digits_arr.length - 1)))
      current_max_sum = (9 * (digits_arr.length - 1)) + (digits_arr[digits_arr.length - 1] - 1)
      start_next_num = next_num = (digits_arr[digits_arr.length - 1]) * (10 ** (digits_arr.length - 1))
      start_next_sum = next_sum = digits_arr[digits_arr.length - 1]
      
      while next_num <= input_num
        (0...10).each do |i|
          next_num = start_next_num + i
          next_sum = start_next_sum + i
          break if next_num > input_num

          if current_max_sum <= next_sum
            current_max_sum = next_sum
            current_greatest_num = next_num
          end
        end
        start_next_num = next_num = next_num + 1
        start_next_sum = next_sum = prepare_digits_for_num(next_num).reduce(0) { |a, e| a + e }
      end
      [current_greatest_num, current_max_sum]
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/array_problems/biggest_sum_in_range'
# num = 48
# arr_prob = ArrayProblems::BiggestSumInRange.new(19)
# arr_prob.prep_biggest_num(num)
