# Used for namespacing
module DynamicProgramming
  # Class representing Grid Problems
  #
  class GridPathProblem
    # Constants to hold min and max values
    #
    FIXNUM_MAX = (2**(0.size * 8 -2) -1)
    FIXNUM_MIN = -(2**(0.size * 8 -2))
    
    # Attribute Accessor
    #
    attr_accessor :grid
    
    def initialize(grid)
      @grid = grid
    end
    
    def min_path_sum(grid, iterative_flag = true)
      prep_min_path_sum_iterative(grid) if iterative_flag
      min_path_sum_recursive(grid, )
    end
    
    def count_ways(grid)
      return 0 if grid[grid.length - 1][grid[0].length - 1] == 1
      memo = Array.new(grid.length) { Array.new((grid[0].length - 1), 0) }
      prep_count_ways(grid: grid, row: grid.length - 1, col: grid[0].length - 1, memo: memo)
    end
    
    private
    
    def prep_count_ways(grid:, row: , col: , memo: )
      return memo[row][col] = 0 if grid[row][col] == 1 || ((row == 0) && (col == 0))
      return memo[row][col] = 1 if row == 0 || col == 0
      memo[row][col] = prep_count_ways(grid: grid, row: row - 1 , col: col, memo: memo) +
        prep_count_ways(grid: grid, row: row, col: col - 1, memo: memo)
    end
    
    def min_path_sum_recursive(grid)
      memoized_table = Array.new(grid.length) { Array.new(grid[0].length) }
      prep_min_path_sum_recursive(grid, grid.length - 1, grid[0].length - 1,  memoized_table)
    end
    
    def prep_min_path_sum_recursive(grid, row_index, col_index, memoized_table)
      return memoized_table[row_index][col_index] unless memoized_table[row_index][col_index].nil?
      if row_index == 0 && col_index == 0
        memoized_table[row_index][col_index] = grid[row_index][col_index]
        return grid[row_index][col_index]
      end
      return FIXNUM_MAX if row_index < 0 || col_index < 0
      left_sum = prep_min_path_sum_recursive(grid, row_index, col_index - 1, memoized_table)
      top_sum = prep_min_path_sum_recursive(grid, row_index - 1, col_index, memoized_table)
      memoized_table[row_index][col_index] = grid[row_index][col_index] + [left_sum, top_sum].min
    end
    
    def prep_min_path_sum_iterative(grid)
      sum_arr = prep_path_sum(grid)
      path_arr = []
      row_count, col_count = grid.length, grid[0].length
      i, j = row_count - 1, col_count - 1
      while i >= 0 && j >= 0
        path_arr << grid[i][j]
        z = (i==0) ? FIXNUM_MAX : sum_arr[i-1][j]
        k = (j==0) ? FIXNUM_MAX : sum_arr[i][j-1]
        if z < k
          i = i - 1
        else
          j = j - 1
        end
      end
      [sum_arr[row_count-1][col_count-1], path_arr.reverse]
    end
    
    def prep_path_sum(grid)
      row_count, col_count = grid.length, grid[0].length
      sum_arr = []
      (0...row_count).each do |j|
        sum_arr << grid[j].dup
        (0...col_count).each do |i|
          next if i== 0 && j == 0
          z = (i == 0)? FIXNUM_MAX : sum_arr[j][i-1]
          k = (j == 0)? FIXNUM_MAX : sum_arr[j-1][i]
          sum_arr[j][i] += [z,k].min
        end
      end
      sum_arr
    end
  end
end

# To run Grid Path sum
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/grid_path_problem'
# grid = [
#   [1, 4, 5, 8, 9],
#   [1, 2, 3, 4, 13],
#   [14, 15, 19, 18, 25],
#   [1, 5, 1, 16, 19]
# ]
# grid_path_sum = DynamicProgramming::GridPathProblem.new(grid)
# grid_path_sum.min_path_sum(grid, false)
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/grid_path_problem'
# grid = [
#   [0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0]
# ]
# grid_path_sum = DynamicProgramming::GridPathProblem.new(grid)
# grid_path_sum.count_ways(grid)
