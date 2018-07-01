# Used for namespacing
module DynamicProgramming
  # Class representing Grid Problems
  #
  class UniquePathsForGrid
    
    attr_accessor :grid
    
    def initialize(grid)
      @grid = grid
    end
    
    def number_of_unique_paths(grid)
      prep_no_unique_paths(grid)
    end
    
    private
    
    def prep_no_unique_paths(grid)
      row_count, col_count = grid.length, grid[0].length
      num_unique_paths_arr = Array.new(row_count) { Array.new(col_count) }
      process_zero_row_col(grid, num_unique_paths_arr, 1, col_count)
      process_zero_row_col(grid, num_unique_paths_arr, row_count, 1)
      (1...row_count).each do |row_index|
        (1...col_count).each do |col_index|
          case grid[row_index][col_index] == 0
          when true
            z = (num_unique_paths_arr[row_index][col_index - 1].nil?) ? 0 : num_unique_paths_arr[row_index][col_index - 1]
            k = (num_unique_paths_arr[row_index - 1][col_index].nil?) ? 0 : num_unique_paths_arr[row_index - 1][col_index]
            num_unique_paths_arr[row_index][col_index] = z + k
          else
            num_unique_paths_arr[row_index][col_index] = nil
          end
        end
      end
      num_unique_paths_arr[row_count - 1][col_count - 1]
    end
    
    def process_zero_row_col(grid, num_unique_paths_arr, row_count, col_count)
      (0...row_count).each do |row_index|
        (0...col_count).each do |col_index|
          if grid[row_index][col_index] == 0
            num_unique_paths_arr[row_index][col_index] = 1
          else
            num_unique_paths_arr[row_index][col_index] = nil
          end
        end
      end
    end
  end
end

# To run Unique Paths for Grid
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/unique_paths_for_grid'
# grid = [
#   [1, 1, 0, 1, 0, 0, 1],
#   [0, 1, 1, 1, 1, 1, 1],
#   [0, 1, 1, 1, 1, 0, 1],
#   [0, 1, 1, 1, 1, 1, 1]
# ]
# unique_paths_grid = DynamicProgramming::UniquePathsForGrid.new(grid)
# unique_paths_grid.number_of_unique_paths(grid)
