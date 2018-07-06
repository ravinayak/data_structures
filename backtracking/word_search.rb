# Used for namespacing
#
module Backtracking
  # Class
  #
  class WordSearch
    
    attr_accessor :board
    
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
    
    def word_exists_in_dict(grid, dict)
      result_arr = []
      max_dict_word_length = dict.reduce(0) do |word_len, word|
        if word.length > word_len
          word_len = word.length
        else
          word_len
        end
      end
      (0...grid.length).each do |grid_row|
        (0...grid[grid_row].length).each do |grid_col|
          puts "Here :: #{grid_row} -- #{grid_col}"
          prep_word_exists_in_dict(grid: grid, row: grid_row, column: grid_col, word_index: 0,
                                         arr: [], res: result_arr, dict: dict, max_dict_word_length: max_dict_word_length)
        end
      end
      puts result_arr.inspect
    end
    
    private
    
    def prep_word_exists_in_board(grid: , row: , column: , word: , word_index: )
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
    
    def prep_word_exists_in_dict(grid: , row: , column: ,  word_index: 0, arr: , res: , dict: , max_dict_word_length: )
      return if row >= grid.length || row < 0 || column >= grid[0].length || column < 0 ||
        word_index >= max_dict_word_length
      return if grid[row][column] == '*'
      
      arr[word_index] = grid[row][column]
      possible_word = arr[0..word_index].join
      res << possible_word if !res.include?(possible_word) && dict.include?(possible_word)
      grid[row][column] = '*'
      
      prep_word_exists_in_dict(grid: grid, row: row + 1, column: column, word_index: word_index + 1, arr: arr,
                               res: res, dict: dict, max_dict_word_length: max_dict_word_length)
      prep_word_exists_in_dict(grid: grid, row: row - 1, column: column, word_index: word_index + 1, arr: arr,
                               res: res, dict: dict, max_dict_word_length: max_dict_word_length)
      prep_word_exists_in_dict(grid: grid, row: row, column: column + 1, word_index: word_index + 1, arr: arr,
                               res: res, dict: dict, max_dict_word_length:max_dict_word_length)
      prep_word_exists_in_dict(grid: grid, row: row, column: column - 1, word_index: word_index + 1, arr: arr,
                               res: res, dict: dict, max_dict_word_length: max_dict_word_length)
      
      grid[row][column] = arr[word_index]
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
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/word_search'
# grid = [
#   ['o','a','a','n'],
#   ['e','t','a','e'],
#   ['i','h','k','r'],
#   ['i','f','l','v']
# ]
# dict = %w(oath oeii eat rain neat ihta fhkl aerk)
# word_search = Backtracking::WordSearch.new(grid)
# word_search.word_exists_in_dict(grid, dict)
