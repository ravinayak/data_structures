# Used for namespacing
module DynamicProgramming
  # Class representing Range Query
  #
  class RangeQuery
    
    attr_accessor :grid, :sum_arr
    
    def initialize(grid, dimensions=2)
      @grid = grid
      @dimensions = dimensions
      @sum_arr = nil
    end
    
    def find_sum_in_two_d(grid, start_row_index, start_col_index, end_row_index, end_col_index)
      @sum_arr = @sum_arr || prep_sum_for_two_d(grid)
      find_sum_for_given_range(start_row_index - 1, start_col_index - 1, end_row_index - 1, end_col_index - 1)
    end
    
    private
    
    def prep_sum_for_two_d(grid)
      sum_arr = []
      sum_arr << grid[0].dup
      (1...grid.length).each do |row_index|
        sum_arr << grid[row_index].dup
        (0...grid[0].length).each do |col_index|
          sum_arr[row_index][col_index] += sum_arr[row_index-1][col_index]
        end
      end
      sum_arr
    end
    
    def find_sum_for_given_range(start_row_index, start_col_index, end_row_index, end_col_index)
      sum = 0
      (start_col_index..end_col_index).each do |j|
        sum = sum + (@sum_arr[end_row_index][j] - @sum_arr[start_row_index][j]) +
          (@sum_arr[start_row_index][j] - @sum_arr[start_row_index - 1][j])
      end
      sum
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/range_query'
# grid = [
#   [3, 0, 1, 4, 2],
#   [5, 6, 3, 2, 1],
#   [1, 2, 0, 1, 5],
#   [4, 1, 0, 1, 7],
#   [1, 0, 3, 0, 5]
# ]
# range_query = DynamicProgramming::RangeQuery.new(grid)
# range_query.find_sum_in_two_d(grid, 3, 2, 4, 4)
