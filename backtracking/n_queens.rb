# Used for namespacing
#
module Backtracking
  # Class
  #
  class NQueens
    
    attr_accessor :size
    
    def initialize(size)
      @size = size
    end
    
    def generate_solutions(size)
      dp = Array.new(size) { Array.new(size, []) }
      (0...size).each do |i|
        (0...size).each do |j|
          prep_solutions(i: i, j: j, size: size, dp: dp)
        end
      end
      dp
    end
    
    private
    
    def prep_solutions(i: , j: , size: , dp: )
      return dp[i][j] unless dp[i][j].empty?
      return dp[i][j] if dp[i][j].length >= size
      
      dp[i][j].each do |x_y_coord|
        return dp[i][j] if x_y_coord[0] == i || x_y_coord[1] == j
      end
      
      dp[i][j].each do |x_y_coord|
        x = x_y_coord[0]
        y = x_y_coord[1]
        (1...size).each do |k|
          x_less, y_less = (x - k), (y - k)
          x_greater, y_greater = (x + k), (y + k)
          if x_less >= 0 && x_less < size && y_less >= 0 && y_less < size
            return dp[i][j] if i == x_less && j == y_less
          end
          if x_greater >= 0 && x_greater < size && y_greater >= 0 && y_greater < size
            return dp[i][j] if i == y_greater && j == y_greater
          end
        end
        
        dp[i][j] << [i, j] unless  dp[i][j].include? [i, j]
        return dp[i][j] if dp[i][j].length == size
        
        if (i + 1) >= 0 && (i + 1) < size && (j + 2) >= 0 && (j + 2) < size
          dp[i+1][j+2] = prep_solutions(i: i + 1, j: j + 2 ,size: size, dp: dp)
        end

        if (i - 1) >= 0 && (i - 1) < size && (j + 2) >= 0 && (j + 2) < size
          dp[i-1][j+2] = prep_solutions( i: i - 1, j: j + 2 ,size: size, dp: dp)
        end

        if (i + 1) >= 0 && (i + 1) < size && (j - 2) >= 0 && (j - 2) < size
          dp[i+1][j-2] = prep_solutions(i: i + 1, j: j - 2 ,size: size, dp: dp)
        end

        if (i - 1) >= 0 && (i - 1) < size && (j - 2) >= 0 && (j - 2) < size
          dp[i-1][j-2] = prep_solutions(i: i - 1, j: j - 2 ,size: size, dp: dp)
        end
        
        x = dp[i+1][j+2]
        [dp[i-1][j+2], dp[i+1][j-2], dp[i-1][j-2]].each { |dp_arr| x = dp_arr if x.length < dp_arr.length }
        dp[i][j] << x
        dp[i][j]
      end
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/n_queens'
# num = 4
# bt = Backtracking::NQueens.new(num)
# bt.generate_solutions(num)
