require_relative '../stack/stack'

module Backtracking
  class PermutationsCombinations
    
    def initialize(input = nil)
      @input = input
    end
    
    # Generates permutations for distinct integers in an array
    #
    def generate_permutations(arr)
      prepare_permutations(arr, index: 0)
    end
    
    # Gneerate combinations for distinct integers in an array
    #
    def generate_combinations(arr, k_choose)
      stack = Stack::Stack.new
      prepare_combinations(arr, index: 0, k_choose: k_choose, stack: stack, output_arr: [])
    end
    
    private
    
    def prepare_permutations(arr, index:)
      case index
      when arr.length
        print arr
        puts
      else
        head = index
        (head...arr.length).each do |iteration|
          swap_flag = false
          case iteration
          when index
            prepare_permutations(arr, index + 1)
          else
            swap_flag = true
            swap(arr, index, iteration)
            prepare_permutations(arr, index + 1)
            swap(arr, index, iteration) if swap_flag
          end
        end
      end
    end
    
    def prepare_combinations(arr, index: , k_choose: , stack:, output_arr:)
      if k_choose == 0
        output_arr << stack.reverse_copy_stack
        return
      end
      
      return if index >= arr.length
      head = index
      (head...arr.length).each do |iteration|
        stack.push(arr[iteration])
        prepare_combinations(arr, index: iteration + 1, k_choose: k_choose - 1, stack: stack, output_arr: output_arr)
        stack.pop
      end
      output_arr
    end
    
    def swap(arr, i, j)
      temp = arr[i]
      arr[i] = arr[j]
      arr[j] = temp
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/backtracking'
# arr = [1, 2, 3, 4]
# bt = Backtracking::PermutationsCombinations.new(arr)
# bt.generate_combinations(arr, 3)
# bt.generate_permutations(arr)
