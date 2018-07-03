# Used for namespacing
#
module Backtracking
  # Class
  #
  class WordSearch
    
    attr_accessor :board, :board_visited
    
    def initialize(grid)
      @grid = grid
    end
    
    def word_exists_in_grid(grid, word)
      flag_found = false
      (0...grid.length).each do |grid_row|
        (0...grid[grid_row].length).each do |grid_col|
          res = prep_word_exists_in_board(grid: grid, row: grid_row, column: grid_col, word: word, word_index: 0)
          if res
            puts 'word found'
            flag_found = true
            break
          end
        end
      end
      puts 'word not found' unless flag_found
    end
    
    private
    
    def prep_word_exists_in_board(grid: grid, row: row, column: column, word: word, word_index: word_index)
      return true if word_index == word.length
      return false if row >= grid.length || row < 0 || column >= grid[0].length || column < 0
      return false if word_index > word.length
      return false if grid[row][column] != word[word_index]
      grid[row][column] = '*'
      return true if
        prep_word_exists_in_board(grid: grid, row: row + 1, column: column, word: word, word_index: word_index + 1) ||
        prep_word_exists_in_board(grid: grid, row: row - 1, column: column, word: word, word_index: word_index + 1) ||
        prep_word_exists_in_board(grid: grid, row: row, column: column + 1, word: word, word_index: word_index + 1) ||
        prep_word_exists_in_board(grid: grid, row: row, column: column - 1, word: word, word_index: word_index + 1)
      grid[row][column] = word[word_index]
      false
    end
  end
end

# To run Word Search Problem
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/word_search'
# grid = [
#   ['A','B','C','E'],
#   ['S','F','C','S'],
#   ['A','D','E','E']
# ]
# word_search = Backtracking::WordSearch.new(grid)
# word_search.word_exists_in_grid(grid, 'ABCCED')
# word_search.word_exists_in_grid(grid, 'SEE')
# word_search.word_exists_in_grid(grid, 'ABCB')
