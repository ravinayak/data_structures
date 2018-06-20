require_relative '../backtracking/permutations_combinations'
module Backtracking
  
  class Backtracking
    include PermutationsCombinations
    
    attr_accessor :input
    
    def initialize(input)
      @input = input
    end
  end
end

# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/backtracking'
# arr = [1, 2, 3, 4]
# bt = Backtracking::Backtracking.new(arr)
# bt.generate_permutations(arr)
