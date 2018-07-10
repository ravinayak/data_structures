# Used for namespacing
#
module Backtracking
  # Class for Board
  #
  class Board
    
    def initialize(size)
      @size = size
      @board = Array.new(size) { Array.new(size, '.') }
      @left_diagonals = []
      @right_diagonals = []
      @cols = []
    end
    
    def add_col(row, col)
      @cols << col
      @left_diagonals << (row + col)
      @right_diagonals << (row - col)
      @board[row][col] = '*'
    end
    
    def remove_col(row, col)
      @cols.delete(col)
      @left_diagonals.delete(row + col)
      @right_diagonals.delete(row - col)
      @board[row][col] = '.'
    end
    
    def is_valid_placement?(row, col)
      !is_invalid_placement?(row, col)
    end
    
    def is_invalid_placement?(row, col)
      @cols.include?(col) || @left_diagonals.include?(row + col) || @right_diagonals.include?(row - col)
    end
    
    def print_board
      (0...size).each do |i|
        puts
        (0...size).each do |j|
          print @board[i][j]
        end
      end
      3.times { puts }
      nil
    end
  end
  
  # Class for NQueens
  #
  class NQueens
    
    attr_accessor :board
    
    def generate_solutions(size)
      @board = Board.new(size)
      solution_arr = []
      dfs(row: 0, size: size, solution_arr: solution_arr, arr: [], index: 0)
      puts "Solutions :: #{solution_arr.length}"
    end
    
    private
    
    def dfs(row:, size:, solution_arr:, arr:, index:)
      if row == size
        puts @board.print_board
        solution_arr << arr
        return
      end
      
      (0...size).each do |col|
        if @board.is_valid_placement?(row, col)
          arr[index] = [row, col]
          @board.add_col(row, col)
          dfs(row: row + 1, size: size, solution_arr: solution_arr, arr: arr, index: index + 1)
          @board.remove_col(row, col)
        end
      end
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/n_queens'
# n_queens = Backtracking::NQueens.new
# n_queens.generate_solutions(8)



