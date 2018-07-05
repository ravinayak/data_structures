# Used for namespacing
#
module Backtracking
  # Class
  #
  class GrayCode
    
    attr_accessor :n
    
    def initialize(n)
      @n = n
    end
    
    def generate_gray_code(n)
      prep_generate_gray_code(n)
    end
    
    private
    
    def prep_generate_gray_code(n)
      return [0] if n == 0
      res = prep_generate_gray_code(n-1)
      num_to_add = 1 << (n-1)
      res.reverse.each { |element| res << element + num_to_add }
      res
    end
  end
end

# To run gray code
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/gray_code'
# n = 3
# gray_code = Backtracking::GrayCode.new(n)
# gray_code.generate_gray_code(3)
# gray_code.generate_gray_code(5)
# gray_code.generate_gray_code(7)
