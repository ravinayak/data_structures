# Used for namespacing
#
module Backtracking
  # Class
  #
  class SudokuPuzzleSolver
    
    def initialize(grid = nil)
      @grid = grid
    end
    
    def solve_grid(grid)
      unassigned_cell_arr = []
      (0...grid.length).each do |row|
        (0...grid[0].length).each do |col|
          unassigned_cell_arr << [row, col] if grid[row][col] == '.'
        end
      end
      prep_sudoku_solve(grid: grid, unassigned_cell_arr: unassigned_cell_arr, index: unassigned_cell_arr.length - 1)
    end
    
    private
    
    def prep_sudoku_solve(grid: , unassigned_cell_arr:, index:)
      if index == -1
        print_grid(grid)
        return true
      end
      
      row, col = unassigned_cell_arr[index][0], unassigned_cell_arr[index][1]
      (1..9).each do |k|
        if is_valid_assignment?(grid, row, col, k.to_s)
          grid[row][col] = k.to_s
          ret_val = prep_sudoku_solve(grid: grid, unassigned_cell_arr: unassigned_cell_arr, index: index - 1)
          return ret_val if ret_val
          grid[row][col] = '.'
        end
      end
      false
    end
    
    def is_valid_assignment?(grid, row, col, k)
      valid_row_assignment?(grid, row, k) && valid_col_assignment(grid, col, k) &&
        valid_grid_assignment(grid, row, col, k)
    end
    
    def valid_row_assignment?(grid, row, k)
      (0...grid[0].length).each do |col|
        return false if grid[row][col] == k
      end
      true
    end

    def valid_col_assignment(grid, col, k)
      (0...grid.length).each do |row|
        return false if grid[row][col] == k
      end
      true
    end

    def valid_grid_assignment(grid, row, col, k)
      start_row_index = (row/3) * 3
      start_col_index = (col/3) * 3
      (start_row_index...(start_row_index + 3)).each do |row|
        (start_col_index...(start_col_index + 3)).each do |col|
          return false if grid[row][col] == k
        end
      end
      true
    end
    
    def print_grid(grid)
      (0...grid.length).each do |row|
        (0...grid[0].length).each do |col|
          print '    ' if  col != 0 && col % 3 == 0
          print grid[row][col].to_s +  ' '
        end
        puts
      end
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/sudoku_puzzle_solver'
# sudoku_solver = Backtracking::SudokuPuzzleSolver.new
# grid = [
#   %w(. . . . 8 . . 7 9),
#   %w(. . . 4 1 9 . . 5),
#   %w(. 6 . . . . 2 8 .),
#   %w(7 . . . 2 . . . 6),
#   %w(4 . . 8 . 3 . . 1),
#   %w(8 . . . 6 . . . 3),
#   %w(. 9 8 . . . . 6 .),
#   %w(6 . . 1 9 5 . . .),
#   %w(5 3 . . 7 . . . .)
# ]
# sudoku_solver.solve_grid(grid)
