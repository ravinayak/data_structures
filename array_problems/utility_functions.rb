# Used for namespacing
#
module ArrayProblems
  module UtilityFunctions
    
    def prepare_digits_for_num(num)
      arr, index = [] , 0
      while num != 0
        arr[index] = num % 10
        index += 1
        num = num/10
      end
      arr
    end
  end
end
