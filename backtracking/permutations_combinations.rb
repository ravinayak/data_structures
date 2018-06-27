module Backtracking
  module PermutationsCombinations
    
    # Generates permutations for distinct integers in an array
    #
    def generate_permutations(arr)
      generate_permutations_for_arr(arr, 0)
    end
    
    
    private
    
    # Handles duplicates in an input array
    #
    def generate_permutations_for_arr(arr, index)
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
            generate_permutations_for_arr(arr, index + 1)
          else
            break if arr[iteration] == arr[index]
            swap_flag = true
            swap(arr, index, iteration)
            generate_permutations_for_arr(arr, index + 1)
            swap(arr, index, iteration) if swap_flag
          end
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
