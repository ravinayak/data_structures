# Used for namespacing
#
module DynamicProgramming
  # Used for namespacing
  #
  class KnapsackSubsetSum
    
    attr_accessor :arr, :sum
    
    def initialize(arr, sum)
      @input_arr = arr
      @sum = sum
    end
    
    def solve_subset_sum(arr, sum)
      subset_sum_solution(arr, sum)
    end
    
    private
    
    # Function to solve subset problem
    #
    # @param arr [Array]
    # @return [Array]
    #
    def subset_sum_solution(arr, sum)
      positive_elems_sum = negative_elements_sum = 0
      (0...arr.length).each do |index|
        positive_elems_sum = positive_elems_sum + arr[index] if arr[index] > 0
        negative_elements_sum = negative_elements_sum + arr[index] if arr[index] < 0
      end
      
      return false if sum < negative_elements_sum || sum > positive_elems_sum
      offset = negative_elements_sum.abs
      row_count, col_count = arr.length + 1, sum + offset + 1
      bool_subset_sum_arr = Array.new(row_count) { Array.new(col_count) }
      (0..(col_count - 1)).each do |index|
        bool_subset_sum_arr[0][index] = false
      end
      (1..(row_count - 1)).each do |i|
        (0..(col_count - 1)).each do |j|
          mapped_col_val = j + negative_elements_sum
          res = (bool_subset_sum_arr[i-1][j]) || arr[i-1] == mapped_col_val
          remainder_sum_col_count = (mapped_col_val - arr[i-1]) + offset
          if remainder_sum_col_count >= 0 && remainder_sum_col_count < col_count
            res = res || bool_subset_sum_arr[i-1][remainder_sum_col_count]
          end
          bool_subset_sum_arr[i][j] = res
        end
      end
      puts bool_subset_sum_arr.inspect
      print_solution(bool_subset_sum_arr, negative_elements_sum, sum, arr)
    end
    
    # @param bool_subset_sum_arr [Array]
    # @param negative_elements_sum [Integer]
    # @sum [Integer]
    # @arr [Array]
    # @return [NIL]
    #
    def print_solution(bool_subset_sum_arr, negative_elements_sum, sum, arr)
      return puts "No Such Subset exists whose sum is same as given sum :: #{sum}" unless
        bool_subset_sum_arr[arr.length][sum + negative_elements_sum.abs]
      res_arr, offset = [], negative_elements_sum.abs
      i, col_count = arr.length, sum + offset
      j = col_count
      while i > 0 && j > 0
          mapped_col_val = j + negative_elements_sum
          x = mapped_col_val - arr[i - 1]
          remainder_sum_col_count = x + offset
          print "X #{x} -- I #{i} -- J #{j}"
          if remainder_sum_col_count < 0 || remainder_sum_col_count > col_count
            i = i - 1
          elsif x == 0
            res_arr << arr[i-1]
            j = remainder_sum_col_count
          elsif bool_subset_sum_arr[i-1][remainder_sum_col_count]
            puts 'here man'
            res_arr << arr[i-1]
            i = i -1
            j = remainder_sum_col_count
          else
            i = i - 1
          end
      end
      puts
      puts "Subset is :: #{res_arr}"
    end
  end
end

# To run knapsack subset sum
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/knapsack_subset_sum'
# set, sum = [-3, -1, -5, 4, -7, 20 ], 10
# subset = DynamicProgramming::KnapsackSubsetSum.new(set, sum)
# subset.solve_subset_sum(set, sum)

