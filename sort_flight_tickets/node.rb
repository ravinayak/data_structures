# Used for namespacing
#
module SortFlightTickets
  # Class definition
  #
  class Node
    # Attribute Accessor
    #
    attr_accessor :value, :next_node, :src_destination_sym

    # Initialize
    #
    def initialize(value, src_destination_sym)
      @value = value
      @next_node = nil
      @src_destination_sym = src_destination_sym
    end
  end
end