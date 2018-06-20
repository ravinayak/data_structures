module Backtracking
  module PermutationsCombinations
    
    # Generates permutations for distinct integers in an array
    #
    def generate_permutations(arr)
      generate_permutations_for_arr(arr, 0)
    end
    
    
    private
    
    def generate_permutations_for_arr(arr, index)
      case index
      when arr.length
        print arr
        puts
      else
        head = index
        (head...arr.length).each do |iteration|
          swap(arr, index, iteration)
          generate_permutations_for_arr(arr, index + 1)
          swap(arr, index, iteration)
        end
      end
    end
    
    def swap(arr, i, j)
      temp = arr[i]
      arr[i] = arr[j]
      arr[j] = temp
    end
  end
end
