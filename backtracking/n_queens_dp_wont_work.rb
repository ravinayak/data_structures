# # Used for namespacing
# #
# module Backtracking
#   # Class
#   #
#   class NQueens
#
#     attr_accessor :size
#
#     def initialize(size)
#       @size = size
#     end
#
#     def generate_solutions(size)
#       dp = Array.new(size) { Array.new(size, []) }
#       (0...size).each do |i|
#         (0...size).each do |j|
#           prep_solutions(i: i, j: j, size: size, dp: dp, arr: [], index: 0, start_row: i, start_col: j)
#         end
#       end
#       (0...size).each do |i|
#         (0...size).each do |j|
#           puts dp[i][j].inspect
#         end
#       end
#     end
#
#     private
#
#     def prep_solutions(i: , j: , size: , dp: , arr: , index:, start_row: , start_col:)
#       return arr unless arr.empty?
#       return arr if arr.length >= size
#
#       arr.each do |x_y_coord|
#         return arr if x_y_coord[0] == i || x_y_coord[1] == j
#       end
#
#       arr.each do |x_y_coord|
#         x = x_y_coord[0]
#         y = x_y_coord[1]
#         (1...size).each do |k|
#           x_less, y_less = (x - k), (y - k)
#           x_greater, y_greater = (x + k), (y + k)
#           if x_less >= 0 && x_less < size && y_less >= 0 && y_less < size
#             return arr if i == x_less && j == y_less
#           end
#           if x_greater >= 0 && x_greater < size && y_greater >= 0 && y_greater < size
#             return arr if i == y_greater && j == y_greater
#           end
#         end
#       end
#
#       arr[index] << [i, j] unless  arr.include? [i, j]
#       puts "index :: #{index} -- Arr :: #{arr}"
#       return arr if arr.length == size
#
#       if (i + 1) >= 0 && (i + 1) < size && (j + 2) >= 0 && (j + 2) < size
#         prep_solutions(i: i + 1, j: j + 2 ,size: size, dp: dp, arr: arr, index: index)
#       end
#
#       if (i - 1) >= 0 && (i - 1) < size && (j + 2) >= 0 && (j + 2) < size
#         prep_solutions( i: i - 1, j: j + 2 ,size: size, dp: dp, arr: arr, index: index)
#       end
#
#       if (i + 1) >= 0 && (i + 1) < size && (j - 2) >= 0 && (j - 2) < size
#         prep_solutions(i: i + 1, j: j - 2 ,size: size, dp: dp, arr: arr, index: index)
#       end
#
#       if (i - 1) >= 0 && (i - 1) < size && (j - 2) >= 0 && (j - 2) < size
#         prep_solutions(i: i - 1, j: j - 2 ,size: size, dp: dp, arr: arr, index: index)
#       end
#
#       dp[i][j] = arr
#     end
#   end
# end
#
# # require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/n_queens'
# # num = 4
# # bt = Backtracking::NQueens.new(num)
# # bt.generate_solutions(num)
