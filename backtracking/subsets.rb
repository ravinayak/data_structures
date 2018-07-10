# Used for namespacing
#
module Backtracking
  # Class
  #
  class Subsets
    
    def initialize(arr: [])
      @arr = arr
    end
    
    def generate_power_subsets(array)
      prep_power_subsets(array)
    end
    
    private
    
    def prep_power_subsets(array)
      power_subset_arr = []
      len = array.length
      (0...(2 ** len)).each do |num|
        tmp_arr = []
        (0...len).each do |j|
          tmp_arr << array[j] if (num & (1 << j)) > 0
        end
        power_subset_arr << tmp_arr unless power_subset_arr.include?(tmp_arr)
      end
      power_subset_arr
    end
  end
end

# To generate Power Subsets
# require '/Users/ravinayak/Documents/personal_projects/data_structures/backtracking/subsets'
# subsets = Backtracking::Subsets.new
# subsets.generate_power_subsets([1, 2, 2])
# subsets.generate_power_subsets(%w(a b c))
# subsets.generate_power_subsets(%w(a b c d))
# # subsets.generate_power_subsets(%w(a a a a))
