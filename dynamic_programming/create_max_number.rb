# Used for namespacing
#
module DynamicProgramming
  # Includes methods for finding minimum coins needed for making change
  # for "j" cents
  #
  class CreateMaxNumber
    
    attr_accessor :input_arr
    
    def initialize(input_arr)
      @input_arr = @input_arr
    end
    
    private

    def prep_max_k_digit_arr(k_digit_arr, current_k_index, min_index, max_index, k, arr)
      return k_digit_arr if k==0
      max_index = (arr.length - 1) - (k - 1)
      max_element = arr[min_index]
      max_element_index = min_index
      (min_index+1..max_index).each do |loop|
        if max_element < arr[loop]
          max_element = arr[loop]
           max_element_index = loop
        end
      end
      k_digit_arr[current_k_index] = max_element
      prep_arr(k_digit_arr, current_k_index + 1, max_element_index + 1, max_index + 1, k-1, arr)
    end
  end
end
