# Used for namespacing
module DynamicProgramming
  # Class representing Grid Problems
  #
  class MaximalSquareOfOnes
    
    # Attribute Accessor
    #
    attr_accessor :grid
    
    def initialize(grid)
      @grid = grid
    end
    
    def retrieve_max_length_square(grid)
      max_length_square(grid)
    end
    
    private
    
    def max_length_square(grid)
      row_count, col_count = grid.length, grid[0].length
      grid_square_of_ones = Array.new(row_count) { Array.new(col_count) }
      process_zero_row_column(grid_square_of_ones, 1, col_count)
      process_zero_row_column(grid_square_of_ones, row_count, 1)
      max_length, end_row_index, end_col_index = 0, 0, 0
      (1...row_count).each do |row_index|
        (1...col_count).each do |col_index|
          if grid[row_index][col_index] == 1
            # Following calculation is for Rectangle
            #
            # length = [
            #   grid_square_of_ones[row_index - 1][col_index - 1][:length],
            #   grid_square_of_ones[row_index][[col_index - 1][:length],
            #   grid_square_of_ones[row_index - 1][col_index][:length]
            # ].max + 1
            #
            if grid_square_of_ones[row_index - 1][col_index - 1][:largest_square_ends] &&
              grid_square_of_ones[row_index - 1][col_index][:largest_square_ends] &&
              grid_square_of_ones[row_index][col_index - 1][:largest_square_ends]
                length = grid_square_of_ones[row_index - 1][col_index - 1][:length] + 1
            else
              length = 0
            end
            if length > max_length
              max_length, end_row_index, end_col_index = length, row_index, col_index
            end
            grid_square_of_ones[row_index][col_index] = { largest_square_ends: true, length: length }
          else
            grid_square_of_ones[row_index][col_index] = { largest_square_ends: false }
          end
        end
      end
      puts " The Maximum length of suqare is :: #{ max_length }"
      start_x_y_co_ordinates = "(#{ end_row_index - max_length + 1 }, #{ end_col_index - max_length + 1})"
      end_x_y_co_ordinates = "(#{ end_row_index + 1}, #{ end_col_index + 1 })"
      puts " Square XY Co-ordinates:: #{ start_x_y_co_ordinates } - #{ end_x_y_co_ordinates }"
    end
    
    def process_zero_row_column(grid_square_of_ones, row_count, col_count)
      (0...row_count).each do |row_index|
        (0...col_count).each do |col_index|
          if grid[row_index][col_index] == 1
            grid_square_of_ones[row_index][col_index] = { largest_square_ends: true, length: 0 }
          else
            grid_square_of_ones[row_index][col_index] = { largest_square_ends: false }
          end
        end
      end
    end
  end
end

# To run Maximal Square Of Ones
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/dynamic_programming/maximal_square_of_ones'
# grid = [
#   [1, 1, 0, 1, 0, 0, 1],
#   [0, 1, 1, 1, 1, 1, 1],
#   [0, 1, 1, 1, 1, 0, 1],
#   [0, 1, 1, 1, 1, 1, 1]
# ]
# maximal_square = DynamicProgramming::MaximalSquareOfOnes.new(grid)
# maximal_square.retrieve_max_length_square(grid)
