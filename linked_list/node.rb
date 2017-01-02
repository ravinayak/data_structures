# Used for namespacing
#
module LinkedList
  # Class definition for a node
  #
  class Node
    # Attribute Accessor
    #
    attr_accessor :next_node, :value

    # Initialize
    #
    def initialize(value = nil, next_node = nil)
      @value = value
      @next_node = next_node
    end
  end
end