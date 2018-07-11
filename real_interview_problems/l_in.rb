# Used for namespacing
#
module RealInterviewProblems
  # Class
  #
  class LIn
    
    def next_greatest_char(input_arr, search_char)
      prep_next_greatest_char(input_arr, search_char)
    end
    
    def find_influencer(input_matrix)
      size = input_matrix.length
      (0...size).each do |row|
        col_val = nil
        (0...size).each do |col|
          next if row == col
          break if input_matrix[row][col]
          col_val = col
        end
        if col_val == size - 1
          row_val = nil
          (0...size).each do |col|
            next if row == col
            break unless input_matrix[col][row]
            row_val = col
          end
          if row_val == (size - 1)
            return row
          end
        end
      end
      'Influencer does not exist'
    end
    
    private
    
    def prep_next_greatest_char(input_arr, search_char)
      return '' if input_arr.empty?
      index = binary_search(low: 0, high: input_arr.length - 1, input_arr: input_arr, search_char: search_char)
      return input_arr[0] if index >= (input_arr.length - 1) || index < 0
      (index...input_arr.length).each do |index_val|
        return input_arr[index_val] if input_arr[index_val] > search_char
      end
      input_arr[0]
    end
    
    def binary_search(low:, high:, input_arr:, search_char:)
      return high if low > high
      mid = (low + high)/ 2
      return mid if search_char == input_arr[mid]
      return binary_search(low: mid + 1, high: high, input_arr: input_arr, search_char: search_char) if
        search_char > input_arr[mid]
      binary_search(low: low, high: mid - 1, input_arr: input_arr, search_char: search_char)
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/real_interview_problems/l_in'
# lin = RealInterviewProblems::LIn.new
# x = ['c', 'f', 'j', 'p', 'v']
# lin.next_greatest_char(x, 'a')
# lin.next_greatest_char(x, 'c')
# lin.next_greatest_char(x, 'k')
# lin.next_greatest_char(x, 'z')
# lin.next_greatest_char([], 'a')
# lin.next_greatest_char(['a'], 'c')
# lin.next_greatest_char(['a', 'a', 'c'], 'c')
# lin.next_greatest_char(['t', 'z', 'z'], 't')
# grid = [
#   [true, true, false, true],
#   [false, false, false, false],
#   [false, true, false, true],
#   [false, true, true, false]
# ]
# lin.find_influencer(grid)
