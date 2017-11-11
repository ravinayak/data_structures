require_relative '../sort_mechanisms/merge_insertion_seection_sort'
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

