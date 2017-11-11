require_relative '../sort_mechanisms/merge_insertion_seection_sort'
# Used for namespacing
#
module SortMechanisms
  # Class which includes all sort mechanisms
  #
  class SortMechanisms
    include MergeInsertionSelectionSort

    # Attribute Accessor for class
    #
    attr_accessor :array

    # @param array [Array]
    #
    def initialize(array = nil)
      @array = array
    end
  end
end
# To run and create sorting methods
#
# require '/Users/ravinayak/Documents/personal_projects/data_structures/sort_mechanisms/sort_mechanisms'
# a = [-9, -11, -19, 100, 250, 900, 1000, 1, -1000, 500]
# sm = SortMechanisms::SortMechanisms.new
# sm.merge_sort(a, true)
# a = [-9, -11, -19, 100, 250, 900, 1000, 1, -1000, 500]
# sm.merge_sort(a, false)
# a = [-9, -11, -19, 100, 250, 900, 1000, 1, -1000, 500]
# sm.insertion_sort(a)
# a = [-9, -11, -19, 100, 250, 900, 1000, 1, -1000, 500]
# sm.selection_sort(a)

