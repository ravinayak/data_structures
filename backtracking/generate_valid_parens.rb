require_relative '../stack/stack'

# Used for namespacing
#
module Backtracking
  
  # Class
  #
  class GenerateValidParens
    
    def initialize(num)
      @num = num
    end
    
    def generate_valid_parens(num)
      prep_valid_parens(num: num, output_arr: [], open_braces_count: 0, close_braces_count: 0, index: 0, str: [])
    end
    
    def generate_valid_parens_opt(num)
      prep_valid_parens_optimized(num: num, output_arr: [], open_braces_count: 0, close_braces_count: 0,
                                  index: 0, str: [])
    end
    
    private

    def prep_valid_parens_optimized(num: , output_arr: [], open_braces_count: , close_braces_count: , index: , str: )
      if index == 2 * num
        output_arr << str[0..index].join
        return
      end
  
      if open_braces_count < num
        str[index] = '('
        prep_valid_parens(num: num, output_arr: output_arr, open_braces_count: open_braces_count + 1,
                          close_braces_count: close_braces_count, index: index + 1, str: str)
      end
  
      if close_braces_count < open_braces_count
        str[index] = ')'
        prep_valid_parens(num: num, output_arr: output_arr, open_braces_count: open_braces_count,
                          close_braces_count: close_braces_count + 1, index: index + 1, str: str)
      end
      output_arr
    end

    def prep_valid_parens(num: , output_arr: [], open_braces_count: , close_braces_count: , index: , str: )
      if index == 2 * num
        possible_valid_parens = str[0..index].join
        output_arr << possible_valid_parens if is_valid_parens?(possible_valid_parens)
        return
      end
      
      if open_braces_count < num
        str[index] = '('
        prep_valid_parens(num: num, output_arr: output_arr, open_braces_count: open_braces_count + 1,
                          close_braces_count: close_braces_count, index: index + 1, str: str)
      end

      if close_braces_count < num
        str[index] = ')'
        prep_valid_parens(num: num, output_arr: output_arr, open_braces_count: open_braces_count,
                          close_braces_count: close_braces_count + 1, index: index + 1, str: str)
      end
      output_arr
    end
    
    def is_valid_parens?(str)
      stack = Stack::Stack.new
      (0...str.length).each do |index|
        if str[index] == '('
          stack.push '('
        else
          return false if stack.empty?
          stack.pop
        end
      end
      true
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/generate_valid_parens'
# num = 3
# bt = Backtracking::GenerateValidParens.new(num)
# bt.generate_valid_parens(num)
# bt.generate_valid_parens_opt(4)
